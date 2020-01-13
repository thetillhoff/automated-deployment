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

# install git
choco install -y git

# install git fork
choco install -y git-fork

# install python with pip
choco install -y python

# install go
choco install -y go

# install go-task
scoop bucket add extras; scoop install task --global

# install go-hugo with scss support
choco install hugo-extended -confirm
