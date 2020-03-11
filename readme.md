# readme

## installation on linux

Please make sure to run the prerequisites.sh file as root first.
Next run ```ansible-playbook ubuntu_1804_hyperv_quickcreate.yml --ask-become-pass``` as a normal user.
For more information to overall configuration see readme_linux.md.

## installation on windows

Ansible wasn't used for windows-host-deployment, as ansible requires a linux control node.
So, to achieve a similar way of working, powershell was used.

Start Powershell as admin and run
  Set-ExecutionPolicy Bypass -Scope Process -Force;
  ./windows_10.ps1
  
