# prerequisites

## install chocolatey
./windows/install_choco.ps1

## install scoop
./windows/install_scoop.ps1


# variables
$USER = "dev"
#Get credentials for given user
$Credential = Get-Credential $USER

# roles
./windows/common.ps1
./windows/dev.ps1
./windows/docker.ps1
#./windows/custom.ps1
$customconfigjob = Start-Job -ScriptBlock {./windows/custom.ps1} -Credential $Credential
Wait-Job $customconfigjob
Receive-Job -Job $customconfigjob