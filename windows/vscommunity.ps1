# install Visual Studio 2019 Community
choco install -y visualstudio2019community
# remove context-menu integration of visual studio community
Remove-Item -Path 'HKLM:\SOFTWARE\Classes\Directory\shell\AnyCode' -Recurse
