$msg = 'Did you double-check the selected roles? [Y/N]'
do {
    $response = Read-Host -Prompt $msg
    if ($response -ne 'y*') {
        Write-Host "Please double-check the roles."
    }
} until ($response -eq 'y*')

$msg = 'Did you double-check the custom.ps1-script? [Y/N]'
do {
    $response = Read-Host -Prompt $msg
    if ($response -ne 'y*') {
        Write-Host "Please double-check the custom.ps1-script."
    }
} until ($response -eq 'y*')

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
./windows/hyperv.ps1
#./windows/office365.ps1 # install manually for x64 and other options
./windows/custom.ps1
#$customconfigjob = Start-Job -ScriptBlock {./windows/custom.ps1} -Credential $Credential
#Wait-Job $customconfigjob
#Receive-Job -Job $customconfigjob

if ($restartrequired){
  Write-Output "Restart required!"
  Write-Output ""
}

Write-Output "What is now missing:"
Write-Output "- install office, Visio"
Write-Output "- install enpass"
Write-Output "- install netspeedmonitor (file on desktop)"
Write-Output "- install Microsoft-ToDo (from store)"
Write-Output "- install games/launchers"
Write-Output "? install ecplise"
Write-Output "? install Firefox"
Write-Output "? install nodejs"
Write-Output "? install openshot video editor"
Write-Output "? install Teamspeak"
Write-Output ""
Write-Output "open todos:"
Write-Output "- cleaning of start menu tiles ('unpin group')"
Write-Output "- log into onedrive, enpass, chrome, office"
Write-Output "- configure printers"
Write-Output "- configure ssh stuff"
