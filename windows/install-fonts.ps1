$Source      = "./*"
$Destination = (New-Object -ComObject Shell.Application).Namespace(0x14)

Get-ChildItem -Path $Source -Include '*.ttf','*.ttc','*.otf' -Recurse | ForEach {
    If (-not(Test-Path "C:\Windows\Fonts\$($_.Name)")) {
        # Install font
        $Destination.CopyHere($_.FullName,0x10)
    }
}