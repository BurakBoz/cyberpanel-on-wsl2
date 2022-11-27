@echo off
echo Windows WSL2 CyberPanel Installation Script
echo.
echo Author: Burak BOZ
echo https://github.com/BurakBoz/cyberpanel-on-wsl2
echo.
echo Supported OS: Windows 11 22H2
echo.
echo WARNING: Becareful! this script will shutdown all wsl instances.
echo and it wil delete older installation of your WSL2 CyberPanel
echo If it's ok, you can press ANY key to continue OR close this window to abort.
echo.
pause
wget --no-check-certificate -nc https://github.com/AlmaLinux/wsl-images/releases/download/v8.5.3-RC3/install_amd64.tar.gz
echo Install WSL 2 Kernel for windows.
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
wget --no-check-certificate -nc https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi -O wsl_update_x64.msi
wsl_update_x64.msi /quiet
wsl --set-default-version 2
:: Reboot windows after this installation.
wsl.exe --update
echo.
echo.
echo If this is your first time running this script, close this terminal window and RESTART your computer now! 
echo.
echo If you are running this script for the second time, press any key to continue.
echo.
echo.
pause
echo.
echo.
echo Please set the installation path for CyberPanel ext4.vhdx file.
set CyberInstallPath="C:\cyberpanel"
set /p CyberInstallPath=Installation path [Press enter if it is ok] (default - %CyberInstallPath%)?:
echo CyberPanel installation path is: %CyberInstallPath%
echo If it's ok, you can press ANY key to continue OR close this window to abort.
pause
echo.
echo.
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
echo.
echo.
echo installing CyberPanel.
timeout 3
echo wsl -d cyberpanel --cd "%cd%" --exec bash install.sh >tmp.bat
tmp.bat
del tmp.bat
echo.
echo.
echo.
echo CyberPanel installation on WSL2 complete.
echo Enjoy your fresh CyberPanel installation on Windows WSL2!
echo.
echo.
echo If you need autostart with windows run autostart-with-windows.bat file as administator on CMD.EXE