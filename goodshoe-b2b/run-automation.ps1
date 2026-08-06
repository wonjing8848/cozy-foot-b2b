# run-automation.ps1 - Daily B2B Outreach Orchestrator
# 1. Merges new leads
# 2. Selects leads for today (Day 0 or Follow-ups)
# 3. Generates send-today.csv
# 4. Runs send-cold-emails.ps1
# 5. Updates leads-master.csv

$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
Set-Location $scriptPath

$masterPath = ".\leads-master.csv"
$newLeadsPath = ".\new-leads.csv"
$todayPath = ".\send-today.csv"
$todayDate = Get-Date -Format "yyyy-MM-dd"

Write-Host "Starting Daily Outreach Automation - $todayDate" -ForegroundColor Cyan

# --- 1. Merge New Leads ---
if (Test-Path $newLeadsPath) {
    Write-Host "Merging new leads from $newLeadsPath..." -ForegroundColor Yellow
    $master = @(Import-Csv $masterPath)
    $newLeads = @(Import-Csv $newLeadsPath)
    $existingEmails = $master.email
    
    foreach ($lead in $newLeads) {
        if ($existingEmails -notcontains $lead.email) {
            $newObj = [PSCustomObject]@{
                email              = $lead.email
                name               = $lead.name
                company            = $lead.company
                website            = $lead.website
                persona            = $lead.persona
                status             = "pending"
                last_sent_date     = ""
                next_followup_date = ""
                whatsapp           = if ($lead.whatsapp) { $lead.whatsapp } else { "" }
                source             = $lead.source
                notes              = $lead.notes
                personalization    = $lead.personalization
            }
            $master += $newObj
            Write-Host "  Added: $($lead.email)" -ForegroundColor Gray
        }
    }
    $master | Export-Csv $masterPath -NoTypeInformation -Encoding UTF8
    Remove-Item $newLeadsPath
    Write-Host "Merge complete." -ForegroundColor Green
} else {
    $master = @(Import-Csv $masterPath)
}

# --- 2. Define Follow-up Templates ---
$followups = @{
    "day3" = @{
        subject = "re: chenille slipper samples for {company}?"
        body = "Hi {name},`n`nQuick follow-up. I've attached a few photos of recent chenille slipper work we did for a similar boutique brand. The custom embroidery and hand-tufting really stand out in person.`n`nIf samples make sense for your team to evaluate, I can ship a set to your address this week. You just cover the shipping (~$15), and the slippers are on us.`n`nBest,`nDing"
    }
    "day7" = @{
        subject = "re: chenille slipper samples for {company}?"
        body = "Hi {name},`n`nJust wanted to share that we recently finished a custom order of 1,500 pairs for a brand similar to {company}. They went with a custom hand-tufted design that turned out beautifully.`n`nIf you're still considering options for the upcoming season, I'd be happy to put together a quick spec sheet or pricing guide for you - no commitment needed.`n`nBest,`nDing"
    }
    "day14" = @{
        subject = "close the file?"
        body = "Hi {name},`n`nI haven't heard back, so I'll assume the timing isn't right for new slipper designs at {company} and I'll close the file on my end.`n`nIf you ever need custom chenille slippers in the future, please don't hesitate to reach out. I'll be happy to send over some samples same-day.`n`nWishing you all the best,`nDing"
    }
}

# --- 3. Select Leads for Today ---
$leadsToRecord = @()
$csvData = @()

foreach ($lead in $master) {
    $shouldSend = $false
    $stage = ""
    
    if ($lead.status -eq "pending") {
        $shouldSend = $true
        $stage = "day0"
    } elseif ($lead.next_followup_date -and $lead.next_followup_date -le $todayDate -and $lead.status -match "^sent-day") {
        # Only handle up to Day 14 follow-ups for now as per logic
        if ($lead.status -eq "sent-day0") { $stage = "day3"; $shouldSend = $true }
        elseif ($lead.status -eq "sent-day3") { $stage = "day7"; $shouldSend = $true }
        elseif ($lead.status -eq "sent-day7") { $stage = "day14"; $shouldSend = $true }
    }
    
    if ($shouldSend) {
        if ($stage -eq "day0") {
            # Day 0 uses the templates inside send-cold-emails.ps1
            $csvRow = [PSCustomObject]@{
                email           = $lead.email
                name            = $lead.name
                company         = $lead.company
                persona         = $lead.persona
                personalization = $lead.personalization
                subject         = ""
                body            = ""
            }
        } else {
            # Follow-ups use custom subject/body
            $tpl = $followups[$stage]
            $csvRow = [PSCustomObject]@{
                email           = $lead.email
                name            = $lead.name
                company         = $lead.company
                persona         = "custom" # This will trigger the catch-all in send-cold-emails.ps1
                personalization = $lead.personalization
                subject         = $tpl.subject -replace '\{name\}', $lead.name -replace '\{company\}', $lead.company -replace '\{personalization\}', $lead.personalization
                body            = $tpl.body -replace '\{name\}', $lead.name -replace '\{company\}', $lead.company -replace '\{personalization\}', $lead.personalization
            }
        }
        $csvData += $csvRow
        
        # Mark for status update
        $lead.status = "sent-$stage"
        $lead.last_sent_date = $todayDate
        $interval = switch ($stage) { "day0" { 3 }; "day3" { 4 }; "day7" { 7 }; default { 0 } }
        if ($interval -gt 0) {
            $lead.next_followup_date = (Get-Date).AddDays($interval).ToString("yyyy-MM-dd")
        } else {
            $lead.next_followup_date = "" # End of sequence or manual
        }
    }
    $leadsToRecord += $lead
}

if ($csvData.Count -gt 0) {
    Write-Host "Preparing $($csvData.Count) emails for today..." -ForegroundColor Cyan
    $csvData | Export-Csv $todayPath -NoTypeInformation -Encoding UTF8
    
    # --- 4. Run send-cold-emails.ps1 ---
    Write-Host "Triggering send-cold-emails.ps1..." -ForegroundColor Yellow
    powershell -NoProfile -ExecutionPolicy Bypass -File "$scriptPath\send-cold-emails.ps1"
    
    # --- 5. Update leads-master.csv ---
    Write-Host "Updating leads-master.csv..." -ForegroundColor Yellow
    $leadsToRecord | Export-Csv $masterPath -NoTypeInformation -Encoding UTF8
    Write-Host "Automation run complete." -ForegroundColor Green
} else {
    Write-Host "No leads to send today." -ForegroundColor Gray
}
