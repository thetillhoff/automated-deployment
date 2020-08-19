# add wsl2 feature
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
wsl --set-default-version 2 # set wsl2 as default
