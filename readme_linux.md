# linux os installation
You can install ubuntu in server mode and install GUI-components afterwards. This deployment expects you to use a fully feature Gnome installation.
If you are behind proxy you should tell the installer about it and load all updates beforehand.
If this is a virtual machine on Hyper-V and you want to use minikube or other virtual machines, run the following command on an administrative powershell: ```Set-VMProcessor -VMName <VMName> -ExposeVirtualizationExtensions $true```

# GUI installation
If you only install ubuntu in server mode you can now install missing GUI components.
First lets update the installed system:
- sudo apt-get update && sudo apt-get upgrade -y
Now you can either install only the required components with:
- sudo apt-get install -y gnome-session gdm3 gnome-terminal
Or you install the full Gnome desktop:
- sudo apt-get install -y tasksel
- sudo tasksel install ubuntu-desktop
Reboot now. The startup may tike a while, especially the network can take up to 2 min to progress.

# [optional] proxy installation
After login at gnome, start the terminal and load any proxy software you need. For via cifs:
- sudo mkdir /mnt/Downloads
- sudo apt-get install -y cifs-utils
- sudo mount -t cifs -o username=<username>,password=<password> //DNSnameorIP/path /mnt/Downloads
Now the folder is mounted under /mnt/Downloads. If you need golang installed, run:
- sudo snap install go
If you need additional configuration to /etc/sudoers, do them now. For example add:
- %sudo  ALL=NOPASSWD:SETENV:/home/dev/opt/tproxy/tproxy -firewall=*
If you need additional folders for /somepath/env, create it now. Also create the /env file if necessary.
Now install the proxy software. If possible with a service, so it starts automatically.
Reboot now. Afterwards your internet connection should work as intended.
  
# additional software and settings
Now you can configure the system properly:
- git clone https://github.com/tillhoff/automated_deployment
- cd automated_deployment
- chmod +x ./prereqisites.sh ./run.sh
- sudo ./prerequisites.sh
- ./run.sh

# vm configuration
Now you can configure the virtual machine if necessary:
- cd ~ 
- git clone https://github.com/microsoft/linux-vm-tools
- cd linux-vm-tools/ubuntu/18.04
- chmod +x ./install.sh
- sudo ./install.sh
Shutdown the machine now.
When shutdown, use the following powershell command on the host to enable enhanced sessions:
- set-vm <vmname> -enhancedsessiontransporttype hvsocket
Make sure to close and reopen the vmconnect window. Start the machine now.
  
# drive mapping
When logged in, configure the proper drive mapping:
- create the required /mnt/* folders
- insert the required lines to /etc/fstab for example:
  - \\cifs-serverdnsorip\HOFTILL$\Data\workspace /mnt/workspace cifs auto,rw,uid=dev,gid=dev,file_mode=0744,dir_mode=0755,credentials=/home/dev/.smbcredentials 0 0
  - \\cifs-serverdnsorip\HOFTILL$\Data\Downloads /mnt/Downloads cifs auto,rw,uid=dev,gid=dev,file_mode=0644,dir_mode=0755,credentials=/home/dev/.smbcredentials 0 0
  - \\cifs-serverdnsorip\HOFTILL$\Data\.ssh /mnt/.ssh cifs auto,ro,uid=dev,gid=dev,file_mode=0400,dir_mode=0744,credentials=/home/dev/.smbcredentials 0 0
- make sure to create the /home/dev/.smbcredentials referenced in the lines exists and contains the credentials in the following way:
username=<username>
password=<password>
- sudo mount -a
Now the drives are mounted under /mnt/*
After you made the those folders don't exist, you can now create the symlinks f.e. with:
- ln -s /mnt/Downloads ~/Downloads


Now, the whole system is configured properly.
