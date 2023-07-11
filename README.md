# Install CyberPanel on WSL2 Windows

#### This script can help you to install CyberPanel on Windows.

1. It uses AlmaLinux 8 rootfs.
2. It will install automaticly systemd for WSL2 (distrod)
3. It will install htop hostname cronie nano wget curl sudo tmpwatch openssh-server
4. It will symlink all php versions for short usage you can use it like "php73 test.php"
5. It will upgrade system php-cli version to lsphp8.1


### Extra cronjob list;

1. (tmpwatch) delete files older than 24 hours on /tmp daily at 00:00
2. (cleanup) delete .DS_Store files daily at 01:15 AM
3. (os) yum update and upgrade daily at 02:15 AM
4. (cyberpanel) restart lscpd daily at 03:00 AM and on reboot
5. (cyberpanel) restart lsws daily at 03:00 AM and on reboot
6. (cyberpanel) upgrade CyberPanel daily at 05:00 AM

### Warning about automatic updates
Those extra cronjobs for updates can broke your system you can delete those with `crontab -e` command if you want.

### Instructions

1. Download this repo and extract it.
2. You must run cmd.exe as ADMINISTRATOR first. (Do not use powershell.)
3. go in that folder with cd command like `cd "C:/Users/myuser/Desktop/cyberpanel-on-wsl2/"`
4. run `install.bat` command from that window.
5. Read the screen carefully and follow the instructions on terminal output.
6. Reboot and try again if fails installation.
7. DO NOT say YES to reboot question after cyberpanel installed. SAY NO. If you say YES here installation will FAIL.
8. Enjoy your CyberPanel on Windows!
9. Go to https://127.0.0.1:8090 use your credentials.
10. run `wsl -d cyberpanel` command from cmd for access to cyberpanel linux shell.


### Quick installation with git command (FIRST RUN cmd.exe AS ADMINISTRATOR)
````
git clone https://github.com/BurakBoz/cyberpanel-on-wsl2.git
cd cyberpanel-on-wsl2
install.bat
````
