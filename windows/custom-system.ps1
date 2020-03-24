# install f.lux
choco install -y f.lux

# install jdownloader
choco install -y jdownloader

# install whatsapp desktop
choco install -y whatsapp

# install nmap
choco install -y nmap


# install fonts
$Source      = "../files/*"
$Destination = (New-Object -ComObject Shell.Application).Namespace(0x14)
Get-ChildItem -Path $Source -Include '*.ttf','*.ttc','*.otf' -Recurse | ForEach {
    If (-not(Test-Path "C:\Windows\Fonts\$($_.Name)")) {
        # Install font
        $Destination.CopyHere($_.FullName,0x10)
    }
}


# As the 'Quick Access' elements is accessible in contrast to the default folders from 'This PC', the following remove/add is done:
# hide music folder from 'This PC' in Explorer
Set-ItemProperty -Path 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag' -Name 'ThisPCPolicy' -Value 'Hide'
# hide video folder from 'This PC' in Explorer
Set-ItemProperty -Path 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag' -Name 'ThisPCPolicy' -Value 'Hide'
# hide pictures folder from 'This PC' in Explorer
Set-ItemProperty -Path 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag' -Name 'ThisPCPolicy' -Value 'Hide'
# hide documents folder from 'This PC' in Explorer
Set-ItemProperty -Path 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag' -Name 'ThisPCPolicy' -Value 'Hide'
# hide downloads folder from 'This PC' in Explorer
Set-ItemProperty -Path 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag' -Name 'ThisPCPolicy' -Value 'Hide'
# hide desktop folder from 'This PC' in Explorer
Set-ItemProperty -Path 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag' -Name 'ThisPCPolicy' -Value 'Hide'
# remove 3D objects folder from 'This PC' in Explorer
Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\Namespace' -Value '{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}'
Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace' -Value '{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}'
# add user folder to Quick Access in Explorer

# disable 'recently added' on startmenu
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer' -Name 'HideRecentlyAddedApps' -Value 0

# add scripts to C:/Windows, which is included in path
Copy-Item ./windows/files/hide.ps1 C:/Windows/hide.ps1
$currentlocation=Get-Location;
Set-Location C:\;hide.ps1;Set-Location $currentlocation;
