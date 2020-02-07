# install 7zip
choco install -y 7zip

# install Google Chrome
choco install -y googlechrome

# uninstall games
Get-AppxPackage king.com.FarmHeroesSaga* | Remove-AppxPackage
Get-AppxPackage xingag.xing* | Remove-AppxPackage
Get-AppxPackage Microsoft.bingnews* | Remove-AppxPackage
Get-AppxPackage spotifyab.spotifymusic* | Remove-AppxPackage
Get-AppxPackage king.com.candycrushfriends* | Remove-AppxPackage
Get-AppxPackage king.com.candycrushsaga* | Remove-AppxPackage
Get-AppxPackage Microsoft.gethelp* | Remove-AppxPackage
Get-AppxPackage Microsoft.bingweather* | Remove-AppxPackage
Get-AppxPackage Microsoft.office.oneone* | Remove-AppxPackage
Get-AppxPackage Microsoft.MicrosoftSolitaireCollection* | Remove-AppxPackage

# uninstall other unnecessary software
## mixed reality
Get-AppxPackage Microsoft.MixedReality.Portal* | Remove-AppxPackage
## feedback
Get-AppxPackage Microsoft.WindowsfeedbackHub* | Remove-AppxPackage
## tips
Get-AppxPackage Microsoft.Getstarted* | Remove-AppxPackage
## groove music
Get-AppxPackage Microsoft.ZuneMusic* | Remove-AppxPackage
## movies & tv
Get-AppxPackage Microsoft.ZuneVideo* | Remove-AppxPackage
## xbox
Get-AppxPackage Microsoft.Xbox.TCUI* | Remove-AppxPackage
Get-AppxPackage Microsoft.XboxApp* | Remove-AppxPackage
## weather
Get-AppxPackage Microsoft.BinWeather* | Remove-AppxPackage

# set global execution policy for the whole machine
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine
