# install git
choco install -y git
Remove-Item -Path 'HKLM:\SOFTWARE\Classes\Directory\shell\git_shell' -recurse
Remove-Item -Path 'HKLM:\SOFTWARE\Classes\Directory\shell\git_gui' -recurse
