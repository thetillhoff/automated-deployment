# install f.lux
choco install -y f.lux

# install jdownloader
choco install -y jdownloader

# install whatsapp desktop
choco install -y whatsapp

# install nmap
choco install -y nmap

# show file extensions
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'HidefileExt' -Value 0

# show all icons in traybar
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer' -Name 'EnableAutoTray' -Value 0

# remove search field from taskbar
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Search' -Name 'SearchboxTaskbarMode' -Value 0

# pin explorer ribbon
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Ribbon' -Name 'MinimizedStateTabletModeOff' -Value 0

# set explorer to open 'This PC' by default instead of 'Quick access'
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'LaunchTo' -Value 1
#   1 == This PC
#   2 == Quick access
#   3 == Downloads

# set explorer to always show full path
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer' -Name 'CabinetState' -Value 1
#   0 == display name
#   1 == display full path

# set explorer to never show recently used files in quick access
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' -Name 'ShowRecent' -Value 0
# set explorer to never show frequently used files in quick access
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' -Name 'ShowFrequent' -Value 0
# delete history of recently and frequently used files
Remove-Item -recurse -force $env:APPDATA/Microsoft/Windows/Recent/*
# restart explorer afterwards
taskkill /IM explorer.exe /F; explorer.exe

 # disable 'recently added' on startmenu
 Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer' -Name 'HideRecentlyAddedApps' -Value 0

# switch to darkmode
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize' -Name 'AppsUseLightTheme' -Value 0
# disable transparency
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize' -Name 'EnableTransparency' -Value 0
## set accent color on start, taskbar and action center
#Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize' -Name 'ColorPrevalence' -Value 1
## set accent color on title bars
#Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\DWM' -Name 'ColorPrevalence' -Value 1

# delete background image history
#for ($i = 0; $i -le 5; $i++)
#{
#  if (Test-RegistryValue -path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Wallpapers" -value "BackgroundHistoryPath$i" )
#  {
#    Remove-ItemProperty -path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Wallpapers" -name "BackgroundHistoryPath$i" 
#  }
#}
# change background image
Copy-Item ./windows/files/black.jpg C:/windows/black.jpg
Set-ItemProperty -path 'HKCU:\Control Panel\Desktop\' -name wallpaper -value C:/windows/black.jpg
$restartrequired = $true

# disable web results in start-menu-search
Set-WindowsSearchSetting -EnableWebResultsSetting $false

# disable onedrive ads
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ShowSyncProviderNotifications' -Value 0

# add scripts to C:/Windows, which is included in path
Copy-Item ./windows/files/hide.ps1 C:/Windows/hide.ps1
$currentlocation=Get-Location;
cd C:\;hide.ps1;cd $currentlocation;

# remove everything from (public & user) desktop
Remove-Item C:\Users\Public\Desktop\*.lnk
Remove-Item $HOME\Desktop\*.lnk
#Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace' -Name '{645FF040-5081-101B-9F08-00AA002F954E}' #recycle bin

# clear taskbar (only explorer remains)
reg import ./windows/files/cleantaskbar.reg
# add shortcuts to taskbar:
#%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\... -> OneNote, Outlook, but not ms-task, chrome
