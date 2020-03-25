# readme

## installation on linux

Please make sure to run the prerequisites.sh file as root first.
Next run ```ansible-playbook ubuntu_1804_hyperv_quickcreate.yml --ask-become-pass``` as a normal user.
For more information to overall configuration see readme_linux.md.

## installation on windows

Ansible wasn't used for windows-host-deployment, as ansible requires a linux control node.
So, to achieve a similar way of working, powershell was used.

Start Powershell (NOT as admin) and run
  Set-ExecutionPolicy Bypass -Scope Process -Force;
  ./windows_10.ps1
  
### todo on windows
- font installation: check not only for a font-name but also for the subclasses (regular, thin, etc.).
- on every registry-change, check if value is already set.