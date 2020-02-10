# prerequisites

## install chocolatey
./windows/install_choco.ps1

## install scoop
./windows/install_scoop.ps1


# variables
#$USER = $env:UserName
#Get credentials for given user
#$Credential = Get-Credential $USER
$restartrequired = $false

# roles
./windows/common.ps1
./windows/dev.ps1
./windows/docker.ps1
./windows/custom.ps1
#$customconfigjob = Start-Job -ScriptBlock {./windows/custom.ps1} -Credential $Credential
#Wait-Job $customconfigjob
#Receive-Job -Job $customconfigjob

if ($restartrequired){
  Write-Output "Restart required!"
}

Write-Output "What is now missing:"
Write-Output "- install office, Visio"
Write-Output "- install enpass"
Write-Output "- install Microsoft-ToDo (from store)"
Write-Output "- install whatsapp (store)"
Write-Output "- Install veeam / configure backup"
Write-Output "? install advanced port scanner"
Write-Output "- install games/launchers"
Write-Output "? install ecplise"
Write-Output "- install JDownloader"
Write-Output "- install Firefox"
Write-Output "- install nodejs"
Write-Output "- install netspeedmonitor"
Write-Output "- install openshot video editor"
Write-Output "- install putty (path?/onedrive?)"
Write-Output "- install Teamspeak"
Write-Output ""
Write-Output "What is now to do:"
Write-Output "- cleaning of start menu tiles ('unpin group')"
Write-Output "- log into onedrive, enpass, chrome, office"
Write-Output "- configure printers"
