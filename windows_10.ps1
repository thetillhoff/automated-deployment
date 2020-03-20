# stupidity checks
$user = [Security.Principal.WindowsIdentity]::GetCurrent();
if (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator) {
    Write-Host "You ran this as admin. Please read the readme.md and make sure to not run this as admin."
    exit
}

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


# variables
$restartrequired = $false # default
$logfile = "C:\autoamted-deployment.log"
$normal_cmds = @()
$elevated_cmds = @()


# helper-functions
function run-normal {
    Param($cmds)
    Start-Process powershell -nonewwindow -wait -ArgumentList $cmds
}
function run-elevated {
    Param($cmds)
    Start-Process powershell -wait -verb runas -ArgumentList $cmds
}


# prerequisites
$elevated_cmds += ,"./windows/install_choco.ps1 | Tee-Object -Append -FilePath '$logfile'"
$elevated_cmds += ,"./windows/install_scoop.ps1 | Tee-Object -Append -FilePath '$logfile'"


# roles
$elevated_cmds += ,"./windows/common.ps1 | Tee-Object -Append -FilePath '$logfile'"
$elevated_cmds += ,"./windows/dev.ps1 | Tee-Object -Append -FilePath '$logfile'"
$elevated_cmds += ,"./windows/docker.ps1 | Tee-Object -Append -FilePath '$logfile'"
$elevated_cmds += ,"./windows/hyperv.ps1 | Tee-Object -Append -FilePath '$logfile'"
#./windows/office365.ps1| Tee-Object -Append -FilePath "$logfile" # install manually for x64 and other options
$elevated_cmds += ,"./windows/teamviewer.ps1 | Tee-Object -Append -FilePath '$logfile'"
$elevated_cmds += ,"./windows/./windows/gamelauncher.ps1 | Tee-Object -Append -FilePath '$logfile'"
$elevated_cmds += ,"./windows/custom-system.ps1 | Tee-Object -Append -FilePath '$logfile'"
$normal_cmds += ,"./windows/custom-user.ps1 | Tee-Object -Append -FilePath '$logfile'"


# this should be near the enf ot the script:
run-normal -cmd $($cmds -join "; ")
$elevated_cmds += ,"sleep 3" # so the output of the window is readable for a short time - despite the logfile
run-elevated -cmd $($elevated_cmds -join "; ")

# finishing
if ($restartrequired){
  Write-Output "Restart required!" | Tee-Object -Append -FilePath "$logfile"
  Write-Output "" | Tee-Object -Append -FilePath "$logfile"
}
Write-Output "What is now missing:" | Tee-Object -Append -FilePath "$logfile"
Write-Output "- install office, Visio" | Tee-Object -Append -FilePath "$logfile"
Write-Output "- install enpass" | Tee-Object -Append -FilePath "$logfile"
Write-Output "- install netspeedmonitor (file on desktop)" | Tee-Object -Append -FilePath "$logfile"
Write-Output "- install Microsoft-ToDo (from store)" | Tee-Object -Append -FilePath "$logfile"
Write-Output "- install league of legends" | Tee-Object -Append -FilePath "$logfile"
Write-Output "? install ecplise" | Tee-Object -Append -FilePath "$logfile"
Write-Output "? install Firefox" | Tee-Object -Append -FilePath "$logfile"
Write-Output "? install nodejs" | Tee-Object -Append -FilePath "$logfile"
Write-Output "? install openshot video editor" | Tee-Object -Append -FilePath "$logfile"
Write-Output "? install Teamspeak" | Tee-Object -Append -FilePath "$logfile"
Write-Output "" | Tee-Object -Append -FilePath "$logfile"
Write-Output "open todos:" | Tee-Object -Append -FilePath "$logfile"
Write-Output "- cleaning of start menu tiles ('unpin group')" | Tee-Object -Append -FilePath "$logfile"
Write-Output "- login to onedrive, enpass, chrome, office" | Tee-Object -Append -FilePath "$logfile"
Write-Output "- configure printers" | Tee-Object -Append -FilePath "$logfile"
Write-Output "- activate windows" | Tee-Object -Append -FilePath "$logfile"
Write-Output "- configure ssh stuff" | Tee-Object -Append -FilePath "$logfile"
Write-Output "- login & configuration of game launchers (steam, uplay, epic, origin)" | Tee-Object -Append -FilePath "$logfile"
