@echo off
echo Windows WSL2 CyberPanel Installation Script
echo Author: Burak BOZ
echo https://github.com/BurakBoz/cyberpanel-on-wsl2
echo WARNING: Becareful! this script will shutdown all wsl instances.
echo and it wil delete older installation of your WSL2 CyberPanel
echo if it's okey for you you can press ANY key OR close this window.
pause
echo Please set the installation path for CyberPanel ext4.vhdx file.
set CyberInstallPath="C:\cyberpanel"
set /p CyberInstallPath=Installation path [Press enter if it is ok] (default - %CyberInstallPath%)?:
echo CyberPanel installation path is: %CyberInstallPath%
echo if it's okey for you you can press ANY key OR close this window.
pause
wsl --set-default-version 2
echo shutting down wsl..
wsl --shutdown
echo unregistering older cyberpanel installation..
wsl --unregister cyberpanel > NUL
echo terminating older cyberpanel installation..
wsl --terminate cyberpanel > NUL
echo installing AlmaLinux 8 rootfs..
wsl --import cyberpanel %CyberInstallPath% install_amd64.tar.gz
echo wsl AlmaLinux installation completed.
echo installing CyberPanel.
timeout 3
wsl -d cyberpanel --cd %cd% --exec bash install.sh
echo CyberPanel installation on WSL2 complete.
echo Enjoy your fresh CyberPanel installation on Windows WSL2!