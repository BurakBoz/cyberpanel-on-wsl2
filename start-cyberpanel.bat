@echo off
set "params=%*"
echo Windows WSL2 CyberPanel Start Script
echo Author: Burak BOZ
echo https://github.com/BurakBoz/cyberpanel-on-wsl2
wsl -d cyberpanel --cd %cd% --exec systemctl start lscpd lshttpd lsmcd lsws crond redis-sentinel redis