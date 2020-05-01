# install Docker for Windows
choco install -y docker-desktop

# disable autostart of Docker (0x03 disables, 0x02 enables, any other value seems to disable)
Set-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run -Name "Docker Desktop" -Value ([byte[]](0x03,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00))