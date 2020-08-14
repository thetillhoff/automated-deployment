# install origin
#choco install -y origin

$url = "https://download.dm.origin.com/origin/live/OriginSetup.exe"
$outpath = "C:/Windows/Temp/origin.exe"
Invoke-WebRequest -Uri $url -OutFile $outpath

#$args = @("/SILENT","Separated","Arguments")
$args = @("/SILENT")
Start-Process -Filepath "$outpath" -ArgumentList $args