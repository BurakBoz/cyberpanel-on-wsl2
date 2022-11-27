@echo off
set "params=%*"
echo Windows WSL2 CyberPanel Start Script
echo.
echo Author: Burak BOZ
echo.
echo https://github.com/BurakBoz/cyberpanel-on-wsl2
echo.
echo.
wsl -d cyberpanel --exec /opt/distrod/bin/distrod enable --start-on-windows-boot
