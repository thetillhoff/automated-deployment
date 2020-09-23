# variables
$PSScriptRoot
$restartrequired = $false # default
$logfile = "$PSScriptRoot/automated-deployment.log"
$normal_cmds = @()
$elevated_cmds = @()


# stupidity checks
$user = [Security.Principal.WindowsIdentity]::GetCurrent();
if ((New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)) {
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


# helper-functions
function run-normal {
    Param($cmds)
    Start-Process Powershell -wait -ArgumentList "$cmds"; # maybe add "-NoNewWindows"
}
function run-elevated {
    Param($cmds)
    Start-Process Powershell -wait -verb runas -ArgumentList "$cmds";
}


# prerequisites
$normal_cmds += ,"Start-Transcript -Append `"$logfile`"" # start transcript, as commands start in another window
$normal_cmds += ,"Set-ExecutionPolicy Bypass -Scope Process -Force"
$elevated_cmds += ,"Start-Transcript -Append `"$logfile`"" # start another transcript, as elevated commands start in another window
$elevated_cmds += ,"Set-ExecutionPolicy Bypass -Scope Process -Force"
$elevated_cmds += ,"echo '*** ELEVATED LOG STARTS HERE ***'" # mark the start of elevated commands
$elevated_cmds += ,"$PSScriptRoot/windows/install-choco.ps1"
$elevated_cmds += ,"$PSScriptRoot/windows/install-scoop.ps1"

Write-Host "Prerequisites fulfilled. Starting role installation..."

# roles
$elevated_cmds += ,"$PSScriptRoot/windows/7zip.ps1"
$elevated_cmds += ,"$PSScriptRoot/windows/adobereader.ps1"
#$elevated_cmds += ,"$PSScriptRoot/windows/anaconda.ps1"
$elevated_cmds += ,"$PSScriptRoot/windows/discord.ps1"
$elevated_cmds += ,"$PSScriptRoot/windows/docker.ps1"
$elevated_cmds += ,"$PSScriptRoot/windows/edge.ps1"
#$elevated_cmds += ,"$PSScriptRoot/windows/epic.ps1"
$elevated_cmds += ,"$PSScriptRoot/windows/filezilla.ps1"
#$elevated_cmds += ,"$PSScriptRoot/windows/firefox.ps1"
$elevated_cmds += ,"$PSScriptRoot/windows/flux.ps1"
$elevated_cmds += ,"$PSScriptRoot/windows/fork.ps1"
$elevated_cmds += ,"$PSScriptRoot/windows/git.ps1"
$elevated_cmds += ,"$PSScriptRoot/windows/go-hugo.ps1"
$elevated_cmds += ,"$PSScriptRoot/windows/go-task.ps1"
$elevated_cmds += ,"$PSScriptRoot/windows/golang.ps1"
$elevated_cmds += ,"$PSScriptRoot/windows/googlechrome.ps1"
$elevated_cmds += ,"$PSScriptRoot/windows/heidisql.ps1"
$elevated_cmds += ,"$PSScriptRoot/windows/hyperv.ps1"
#$elevated_cmds += ,"$PSScriptRoot/windows/intellij-idea.ps1"
$elevated_cmds += ,"$PSScriptRoot/windows/java.ps1"
#$elevated_cmds += ,"$PSScriptRoot/windows/jdownloader.ps1"
#$elevated_cmds += ,"$PSScriptRoot/windows/nmap.ps1"
#$elevated_cmds += ,"$PSScriptRoot/windows/nodejs.ps1"
#$elevated_cmds += ,"$PSScriptRoot/windows/office365.ps1"
$elevated_cmds += ,"$PSScriptRoot/windows/openssh.ps1"
#$elevated_cmds += ,"$PSScriptRoot/windows/origin.ps1"
$elevated_cmds += ,"$PSScriptRoot/windows/paintnet.ps1"
$elevated_cmds += ,"$PSScriptRoot/windows/putty.ps1"
$elevated_cmds += ,"$PSScriptRoot/windows/python.ps1"
#$elevated_cmds += ,"$PSScriptRoot/windows/steam.ps1"
$elevated_cmds += ,"$PSScriptRoot/windows/teamviewer.ps1"
#$elevated_cmds += ,"$PSScriptRoot/windows/uplay.ps1"
#$elevated_cmds += ,"$PSScriptRoot/windows/veeam.ps1"
$elevated_cmds += ,"$PSScriptRoot/windows/vlc.ps1"
$elevated_cmds += ,"$PSScriptRoot/windows/vscode.ps1"
$elevated_cmds += ,"$PSScriptRoot/windows/vscommunity.ps1"
$elevated_cmds += ,"$PSScriptRoot/windows/whatsapp.ps1"
$elevated_cmds += ,"$PSScriptRoot/windows/windirstat.ps1"
$elevated_cmds += ,"$PSScriptRoot/windows/wsl2.ps1"

$elevated_cmds += ,"$PSScriptRoot/windows/uninstall.ps1"
$elevated_cmds += ,"$PSScriptRoot/windows/privacy.ps1"
$elevated_cmds += ,"$PSScriptRoot/windows/custom-system.ps1"
$normal_cmds += ,"$PSScriptRoot/windows/custom-user.ps1"


# this should be near the end ot the script:
if ($elevated_cmds.count -gt 0) {
    #$elevated_cmds += ,"Stop-Transcript" # not necessarily required, as the transcript stops when the window closes
    $elevated_cmds += ,"sleep 5" # so the output of the window is readable for a short time - despite the logfile
    run-elevated -cmd "$($elevated_cmds -join '; ')"
}
Write-Output "Elevated-script(s) executed. Continuing with user-script(s)..."
if ($normal_cmds.count -gt 0) {
    #$normal_cmds += ,"Stop-Transcript" # not necessarily required, as the transcript stops when the window closes
    run-normal -cmd "$($normal_cmds -join '; ')"
}

# start log-file
Start-Transcript -Append "$logfile"

# finishing
if ($restartrequired){
  Write-Output "Restart required!"
  Write-Output ""
}
Write-Output "What is now missing:"
Write-Output "- install office, Visio"
Write-Output "- install enpass"
Write-Output "- install netspeedmonitor (file on desktop)"
Write-Output "- install Microsoft-ToDo (from store)"
Write-Output "- install league of legends"
Write-Output "? install openshot video editor"
Write-Output ""
Write-Output "open todos:"
Write-Output "- cleaning of start menu tiles ('unpin group')"
Write-Output "- login to onedrive, enpass, chrome, office"
Write-Output "- configure printers"
Write-Output "- activate windows"
Write-Output "- configure ssh stuff"
Write-Output "- login & configuration of programs"
Write-Output "- create veeam backup job"

Stop-Transcript # so further manual commands won't mess up the logfile
