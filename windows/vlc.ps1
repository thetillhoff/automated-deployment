# install vlc media player
choco install -y vlc
# remove vlc context-menu integration
Remove-Item -Path 'HKLM:\SOFTWARE\Classes\Directory\shell\PlayWithVLC' -recurse
Remove-Item -Path 'HKLM:\SOFTWARE\Classes\Directory\shell\AddtoPlaylistVLC' -recurse
