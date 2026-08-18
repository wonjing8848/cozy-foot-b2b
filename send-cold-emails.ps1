# Mailersend cold email sender - semi-manual batch
# Usage: prepare contacts.csv in same folder, then run this script

$apiToken = "mlsn.d3533824285f6068046737fe9ecf7aef7e2aa2904287a8cc92b3a664573df1e0"

# ===== Config =====
$csvPath = ".\send-today.csv"
$delaySeconds = 45
$dryRun = $false
$nonInteractive = $true

# ===== Templates (match the COLD_EMAIL_TEMPLATES.md file) =====
$templates = @{
    "hotel" = @{
        subject = "chenille slipper samples for {company}?"
        body = "Hi {name},`n`nSaw {company} is in {personalization} - looks like a boutique property with a focus on guest experience.`n`nWe OEM chenille slippers from Ningbo, China. 2000 pairs/day capacity, custom embroidery for your hotel logo, multiple color options.`n`nCurrently supplying several US boutique hotels and a few resort groups.`n`nQuick question: are you looking for guest slippers, spa slippers, or both? I'll send 3 samples matching your style - you cover shipping (~$15 via DHL), I cover the slippers.`n`nBest,`nDing`ngoodshoe MFG | +86 13559512899`ncozy-foot.com"
    }
    "amazon" = @{
        subject = "chenille slipper supplier for {company}?"
        body = "Hi {name},`n`nSaw {company} on Amazon - looks like you're focused on {personalization}.`n`nWe OEM chenille slippers from Ningbo, China. 12+ embroidery machines, hand-tufting capability, custom packaging. 2000 pairs/day capacity, already shipping to US FBA warehouses.`n`nWe do FNSKU labels, poly bag, and ship directly to Amazon. MOQ starts at 500 pairs for custom design.`n`nWant me to send 3 samples to your US address? Free samples, you just cover shipping.`n`nBest,`nDing`ngoodshoe MFG | +86 13559512899`ncozy-foot.com"
    }
    "brand" = @{
        subject = "chenille slipper samples for {company}?"
        body = "Hi {name},`n`n{personalization}.`n`nWe OEM chenille slippers in Ningbo, China. 12+ embroidery machines, hand-tufting, custom colors and designs. 2000 pairs/day capacity, MOQ starts at just 300 pairs for custom.`n`nTwo questions: are you looking for white-label (our designs, your brand) or fully custom (your own colors, embroidery design)?`n`nHappy to send 3 samples either way - free slippers, you cover ~$15 shipping.`n`nBest,`nDing`ngoodshoe MFG | +86 13559512899`ncozy-foot.com"
    }
}

# ===== Run =====
if (-not (Test-Path $csvPath)) {
    Write-Host ""
    Write-Host "ERROR: contacts.csv not found in this folder" -ForegroundColor Red
    Write-Host ""
    Write-Host "Expected columns: email, name, company, persona, personalization" -ForegroundColor Yellow
    Write-Host "Persona values: hotel | amazon | brand" -ForegroundColor Yellow
    Write-Host ""
    Read-Host "Press Enter to exit"
    exit
}

$contacts = Import-Csv $csvPath
Write-Host ""
Write-Host ("Found " + $contacts.Count + " contacts in " + $csvPath) -ForegroundColor Cyan
Write-Host ("Delay between sends: " + $delaySeconds + " seconds") -ForegroundColor Cyan
Write-Host ("Dry run: " + $dryRun) -ForegroundColor Cyan
Write-Host ""

if ($contacts.Count -eq 0) {
    Write-Host "No contacts to send. Exiting." -ForegroundColor Yellow
    if (-not $nonInteractive) { Read-Host "Press Enter to exit" }
    exit
}

if (-not $nonInteractive) {
    Write-Host "Press Ctrl+C to cancel, or" -ForegroundColor Yellow
    Read-Host "Press Enter to start sending"
}

$counter = 0
$sent = 0
$failed = 0

foreach ($contact in $contacts) {
    $counter++
    Write-Host ""
    Write-Host ("[" + $counter + "/" + $contacts.Count + "] " + $contact.email) -ForegroundColor Yellow

    if (-not $templates.ContainsKey($contact.persona) -and -not $contact.body) {
        Write-Host ("  SKIPPED: persona '" + $contact.persona + "' not recognized and no custom body provided (use: hotel, amazon, brand)") -ForegroundColor Red
        continue
    }

    if ($templates.ContainsKey($contact.persona)) {
        $template = $templates[$contact.persona]
        $subject = $template.subject -replace '\{name\}', $contact.name `
                                      -replace '\{company\}', $contact.company `
                                      -replace '\{personalization\}', $contact.personalization
        $body = $template.body -replace '\{name\}', $contact.name `
                               -replace '\{company\}', $contact.company `
                               -replace '\{personalization\}', $contact.personalization
    } else {
        $subject = $contact.subject
        $body = $contact.body
    }

    # Per-row overrides (optional columns in CSV)
    if ($contact.body) { $body = $contact.body }
    if ($contact.subject) { $subject = $contact.subject }

    Write-Host ("  To:      " + $contact.email) -ForegroundColor Gray
    Write-Host ("  Subject: " + $subject) -ForegroundColor Gray
    $firstLine = ($body -split "`n")[0]
    Write-Host ("  Preview: " + $firstLine) -ForegroundColor Gray

    if ($dryRun) {
        Write-Host "  [DRY RUN] Would send" -ForegroundColor DarkYellow
        continue
    }

    $headers = @{
        "Authorization" = "Bearer $apiToken"
        "Content-Type"  = "application/json"
    }

    $apiBody = @{
        from = @{
            email = "outreach@mail.cozy-foot.com"
            name  = "Ding from Cozy Foot"
        }
        to = @(
            @{
                email = $contact.email
                name  = $contact.name
            }
        )
        reply_to = @{
            email = "info@cozy-foot.com"
            name  = "Cozy Foot"
        }
        subject = $subject
        text    = $body
        html    = ($body -replace "`n", "<br>")
    } | ConvertTo-Json -Depth 10

    try {
        $response = Invoke-RestMethod -Uri "https://api.mailersend.com/v1/email" -Method Post -Headers $headers -Body $apiBody
        Write-Host ("  [OK] Sent. ID: " + $response.message_id) -ForegroundColor Green
        $sent++
    } catch {
        Write-Host ("  [FAILED] " + $_.Exception.Message) -ForegroundColor Red
        if ($_.Exception.Response) {
            $reader = New-Object System.IO.StreamReader($_.Exception.Response.GetResponseStream())
            $errBody = $reader.ReadToEnd()
            $reader.Close()
            Write-Host ("  API says: " + $errBody) -ForegroundColor Red
        }
        $failed++
    }

    if ($counter -lt $contacts.Count) {
        Write-Host ("  Waiting " + $delaySeconds + "s...") -ForegroundColor DarkGray
        Start-Sleep -Seconds $delaySeconds
    }
}

Write-Host ""
Write-Host "==== Summary ====" -ForegroundColor Cyan
Write-Host ("Total contacts: " + $contacts.Count) -ForegroundColor White
Write-Host ("Sent:    " + $sent) -ForegroundColor Green
Write-Host ("Failed:  " + $failed) -ForegroundColor Red
Write-Host ("Skipped: " + ($counter - $sent - $failed)) -ForegroundColor Yellow
Write-Host ""
if (-not $nonInteractive) { Read-Host "Press Enter to exit" }
exit
