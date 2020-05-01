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
#taskkill /IM explorer.exe /F; explorer.exe # killing explorer while files are written (logfile) is not a good idea. Instead:
Set-Variable -Name restartrequired -Value $true -Scope Global # setting variable globally

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
Copy-Item $PSScriptRoot/files/black.jpg C:/Users/$env:UserName/Pictures/black.jpg
Set-ItemProperty -path 'HKCU:\Control Panel\Desktop' -name wallpaper -value C:/Users/$env:UserName/Pictures/black.jpg
Set-Variable -Name restartrequired -Value $true -Scope Global # setting variable globally

# disable web results in start-menu-search
#Import-Module -Name WindowsSearch
#Set-WindowsSearchSetting -EnableWebResultsSetting $false # doesn't work

# disable onedrive ads
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ShowSyncProviderNotifications' -Value 0

# remove everything from (public & user) desktop
Remove-Item C:\Users\Public\Desktop\*.lnk
Remove-Item $HOME\Desktop\*.lnk
#Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace' -Name '{645FF040-5081-101B-9F08-00AA002F954E}' #recycle bin

# clear taskbar (only explorer remains)
reg import ./windows/files/cleantaskbar.reg
# add shortcuts to taskbar:
#%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\... -> OneNote, Outlook, but not ms-task, chrome

Write-Host "Finished custom-user.ps1"