# install vlc media player
choco install -y vlc
# remove vlc context-menu integration
Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Classes\Directory\shell' -Name 'PlayWithVLC'
Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Classes\Directory\shell' -Name 'AddtoPlaylistVLC'
