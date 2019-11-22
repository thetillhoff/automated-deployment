# install Visual Studio Code
choco install -y vscode
# install VSC extensions
Foreach ($e in @("ms-azuretools.vscode-docker","ms-python.python","ms-vscode.Go","tomoki1207")){
    code --install-extension $e
}

# install git
choco install -y git

# install git fork
choco install -y git-fork

# install python with pip
choco install -y python

# install go
choco install -y go

# install go-task
scoop bucket add extras; scoop install task