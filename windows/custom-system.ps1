# helper-functions
function install-font {
    Param($fontname)
    if (-not ("Windows.Media.Fonts" -as [Type])) { # required so powershell finds the type
        Add-Type -AssemblyName PresentationCore
    }
    $fontlist = [Windows.Media.Fonts]::SystemFontFamilies | Sort-Object Source | Select-Object -ExpandProperty Source
    if (-not ($fontlist -contains $fontname)) {
        # install fonts
        $Source      = "$PSScriptRoot/../files/*"
        $Destination = (New-Object -ComObject Shell.Application).Namespace(0x14)
        Get-ChildItem -Path $Source -Include "$fontname*.ttf","$fontname*.ttc","$fontname*.otf" -Recurse | ForEach {
            If (-not(Test-Path "C:\Windows\Fonts\$($_.Name)")) {
                # Install font
        #        $Destination.CopyHere($_.FullName,0x10) # silent, but don't overwrite
                $Destination.CopyHere($_.FullName,0x14) # silent and overwrite
            }
        }
    }
    else {
        echo "The font $fontname is already installed."
    }
}


# install f.lux
choco install -y f.lux
# configure f.lux
Set-ItemProperty -path 'HKCU:\SOFTWARE\Michael Herf\flux\offer' -name "bigupdate" -value 4000
Set-ItemProperty -path 'HKCU:\SOFTWARE\Michael Herf\flux\offer' -name "readme" -value 4111
Set-ItemProperty -path 'HKCU:\SOFTWARE\Michael Herf\flux\offer' -name "welcome" -value 1000
Set-ItemProperty -path 'HKCU:\SOFTWARE\Michael Herf\flux\Preferences' -name "alarm" -value 0
Set-ItemProperty -path 'HKCU:\SOFTWARE\Michael Herf\flux\Preferences' -name "canpreventsleep" -value 0
Set-ItemProperty -path 'HKCU:\SOFTWARE\Michael Herf\flux\Preferences' -name "data" -value 0
Set-ItemProperty -path 'HKCU:\SOFTWARE\Michael Herf\flux\Preferences' -name "hasv4" -value 2
Set-ItemProperty -path 'HKCU:\SOFTWARE\Michael Herf\flux\Preferences' -name "hotkeys" -value 0
Set-ItemProperty -path 'HKCU:\SOFTWARE\Michael Herf\flux\Preferences' -name "huedawndusknames" -value "door,porch"
Set-ItemProperty -path 'HKCU:\SOFTWARE\Michael Herf\flux\Preferences' -name "Indoor" -value 5000
Set-ItemProperty -path 'HKCU:\SOFTWARE\Michael Herf\flux\Preferences' -name "Late" -value 3600
Set-ItemProperty -path 'HKCU:\SOFTWARE\Michael Herf\flux\Preferences' -name "Latitude" -value 4840
Set-ItemProperty -path 'HKCU:\SOFTWARE\Michael Herf\flux\Preferences' -name "Longitude" -value 1000
Set-ItemProperty -path 'HKCU:\SOFTWARE\Michael Herf\flux\Preferences' -name "prompt-bedtime" -value 0

# install jdownloader
choco install -y jdownloader

# install whatsapp desktop
choco install -y whatsapp

# install nmap
choco install -y nmap


# install fonts
install-font("Roboto")
install-font("Open Sans")


# As the 'Quick Access' elements is accessible in contrast to the default folders from 'This PC', the following remove/add is done:
# hide music folder from 'This PC' in Explorer
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag' -Name 'ThisPCPolicy' -Value 'Hide'
# hide video folder from 'This PC' in Explorer
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag' -Name 'ThisPCPolicy' -Value 'Hide'
# hide pictures folder from 'This PC' in Explorer
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag' -Name 'ThisPCPolicy' -Value 'Hide'
# hide documents folder from 'This PC' in Explorer
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag' -Name 'ThisPCPolicy' -Value 'Hide'
# hide downloads folder from 'This PC' in Explorer
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag' -Name 'ThisPCPolicy' -Value 'Hide'
# hide desktop folder from 'This PC' in Explorer
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag' -Name 'ThisPCPolicy' -Value 'Hide'
# remove 3D objects folder from 'This PC' in Explorer
if (Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\Namespace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}') {
    Remove-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\Namespace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}'
}
if (Test-Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}') {
    Remove-Item -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}'
}
# add user folder to Quick Access in Explorer

# disable 'recently added' on startmenu
if ( -not (Test-Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer')) {
    New-Item 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer' # create if not exists
}
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "HideRecentlyAddedApps" -Value 0

# add scripts to C:/Windows, which is included in path
Copy-Item $PSScriptRoot/files/hide.ps1 C:/Windows/hide.ps1
$currentlocation=Get-Location;
Set-Location C:\;hide.ps1;Set-Location $currentlocation;
