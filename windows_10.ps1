$msg = 'Did you double-check the selected roles? [y]'
do {
    $response = Read-Host -Prompt $msg
    if ($response -ne 'y') {
        Write-Host "Please double-check the roles."
    }
} until ($response -eq 'y')

$msg = 'Did you double-check the custom.ps1-script? [y]'
do {
    $response = Read-Host -Prompt $msg
    if ($response -ne 'y') {
        Write-Host "Please double-check the custom.ps1-script."
    }
} until ($response -eq 'y')


# prerequisites

## install chocolatey
./windows/install_choco.ps1 | Tee-Object -Append -FilePath "C:\automated-deployment.log"

## install scoop
./windows/install_scoop.ps1 | Tee-Object -Append -FilePath "C:\automated-deployment.log"


# variables
#$USER = $env:UserName
#Get credentials for given user
#$Credential = Get-Credential $USER
$restartrequired = $false
$logfilelocation = "C:\automated-deployment.log"

# roles
./windows/common.ps1 | Tee-Object -Append -FilePath "$logfilelocation"
./windows/dev.ps1 | Tee-Object -Append -FilePath "$logfilelocation"
./windows/docker.ps1 | Tee-Object -Append -FilePath "$logfilelocation"
./windows/hyperv.ps1 | Tee-Object -Append -FilePath "$logfilelocation"
#./windows/office365.ps1| Tee-Object -Append -FilePath "$logfilelocation" # install manually for x64 and other options
./windows/teamviewer.ps1 | Tee-Object -Append -FilePath "$logfilelocation"
./windows/gamelauncher.ps1 | Tee-Object -Append -FilePath "$logfilelocation" # steam etc.
./windows/custom.ps1 | Tee-Object -Append -FilePath "$logfilelocation"
#$customconfigjob = Start-Job -ScriptBlock {./windows/custom.ps1} -Credential $Credential
#Wait-Job $customconfigjob
#Receive-Job -Job $customconfigjob

if ($restartrequired){
  Write-Output "Restart required!" | Tee-Object -Append -FilePath "$logfilelocation"
  Write-Output "" | Tee-Object -Append -FilePath "$logfilelocation"
}

Write-Output "What is now missing:" | Tee-Object -Append -FilePath "$logfilelocation"
Write-Output "- install office, Visio" | Tee-Object -Append -FilePath "$logfilelocation"
Write-Output "- install enpass" | Tee-Object -Append -FilePath "$logfilelocation"
Write-Output "- install netspeedmonitor (file on desktop)" | Tee-Object -Append -FilePath "$logfilelocation"
Write-Output "- install Microsoft-ToDo (from store)" | Tee-Object -Append -FilePath "$logfilelocation"
Write-Output "- install league of legends" | Tee-Object -Append -FilePath "$logfilelocation"
Write-Output "? install ecplise" | Tee-Object -Append -FilePath "$logfilelocation"
Write-Output "? install Firefox" | Tee-Object -Append -FilePath "$logfilelocation"
Write-Output "? install nodejs" | Tee-Object -Append -FilePath "$logfilelocation"
Write-Output "? install openshot video editor" | Tee-Object -Append -FilePath "$logfilelocation"
Write-Output "? install Teamspeak" | Tee-Object -Append -FilePath "$logfilelocation"
Write-Output "" | Tee-Object -Append -FilePath "$logfilelocation"
Write-Output "open todos:" | Tee-Object -Append -FilePath "$logfilelocation"
Write-Output "- cleaning of start menu tiles ('unpin group')" | Tee-Object -Append -FilePath "$logfilelocation"
Write-Output "- log into onedrive, enpass, chrome, office" | Tee-Object -Append -FilePath "$logfilelocation"
Write-Output "- configure printers" | Tee-Object -Append -FilePath "$logfilelocation"
Write-Output "- activate windows" | Tee-Object -Append -FilePath "$logfilelocation"
Write-Output "- configure ssh stuff" | Tee-Object -Append -FilePath "$logfilelocation"
Write-Output "- configure game launchers (steam, uplay, epic, origin)" | Tee-Object -Append -FilePath "$logfilelocation"
