# install IntelliJ IDEA Community (for java dev)
choco install -y intellijidea
Remove-Item -Path 'HKLM:\SOFTWARE\Classes\*\shell\Open with IntelliJ IDEA Community Edition' -Recurse # takes a lot of time, but works... probably because of the '*'
