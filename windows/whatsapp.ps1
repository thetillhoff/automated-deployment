# install whatsapp desktop
#choco install -y whatsapp

Write-Host "Installing whatsapp..."

$url = "https://web.whatsapp.com/desktop/windows/release/x64/WhatsAppSetup.exe"
$outpath = "C:/Windows/Temp/whatsapp.exe"
Invoke-WebRequest -Uri $url -OutFile $outpath

#$args = @("/SILENT","Separated","Arguments")
$args = @("--SILENT")
Start-Process -Filepath "$outpath" -ArgumentList $args

Write-Host "Finished installing whatsapp."
