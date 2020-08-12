# install Visual Studio Code
choco install -y vscode
# reload path
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
# install VSC extensions
Foreach ($e in @("ms-azuretools.vscode-docker","ms-python.python","ms-vscode.Go","tomoki1207")){
    code --install-extension $e
}
