# Mailersend cold email sender - simplified
$apiToken = "mlsn.d3533824285f6068046737fe9ecf7aef7e2aa2904287a8cc92b3a664573df1e0"

$headers = @{
    "Authorization" = "Bearer $apiToken"
    "Content-Type"  = "application/json"
}

$body = @{
    from = @{
        email = "outreach@mail.cozy-foot.com"
        name  = "Ding from Cozy Foot"
    }
    to = @(
        @{
            email = "goodshoe2025@163.com"
            name  = "Test"
        }
    )
    reply_to = @{
        email = "info@cozy-foot.com"
        name  = "Cozy Foot"
    }
    subject = "Test from Cozy Foot via Mailersend"
    text    = "This is a test email. If you can read this, the Mailersend setup is working. Reply should go to info@cozy-foot.com."
    html    = "<p>This is a test email.</p><p>If you can read this, the Mailersend setup is working.</p><p>Reply should go to info@cozy-foot.com.</p>"
} | ConvertTo-Json -Depth 10

Write-Host "Sending email..." -ForegroundColor Cyan

try {
    $response = Invoke-RestMethod -Uri "https://api.mailersend.com/v1/email" -Method Post -Headers $headers -Body $body
    Write-Host "OK! Email sent." -ForegroundColor Green
    Write-Host ("Message ID: " + $response.message_id) -ForegroundColor Green
} catch {
    Write-Host "Failed." -ForegroundColor Red
    Write-Host ("Error: " + $_.Exception.Message) -ForegroundColor Red
    if ($_.Exception.Response) {
        $reader = New-Object System.IO.StreamReader($_.Exception.Response.GetResponseStream())
        $body_text = $reader.ReadToEnd()
        Write-Host ("Response body: " + $body_text) -ForegroundColor Red
    }
}

Read-Host "Press Enter to exit"
