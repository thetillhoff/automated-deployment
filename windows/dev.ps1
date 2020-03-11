# install Visual Studio Code
choco install -y vscode
# reload path
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
# install VSC extensions
Foreach ($e in @("ms-azuretools.vscode-docker","ms-python.python","ms-vscode.Go","tomoki1207")){
    code --install-extension $e
}

# install Visual Studio 2019 Community
choco install -y visualstudio2019community
# remove context-menu integration of visual studio community
Remove-ItemProperty -Path 'HKCR:\Directory\shell' -Name 'AnyCode'

# install git
choco install -y git

# install git fork
choco install -y git-fork

# install python with pip
choco install -y python --params "/INSTALLDIR:C:\.Python38"

# install golang
choco install -y golang --install-arguments="INSTALLDIR=C:\.Go"

# install go-task
scoop bucket add extras; scoop install task --global

# install go-hugo with scss support
choco install -y hugo-extended

# install heidi-sql
choco install -y heidisql

# install putty
choco install -y putty

# install filezilla
choco install -y filezilla

# install openssh
choco install -y openssh
