@echo off
set "params=%*"
echo Windows WSL2 CyberPanel Restart Script
echo.
echo Author: Burak BOZ
echo.
echo https://github.com/BurakBoz/cyberpanel-on-wsl2
echo.
echo.
wsl -t cyberpanel
wsl -d cyberpanel --exec systemctl restart mariadb lscpd lshttpd lsmcd lsws crond redis
wsl -d cyberpanel 