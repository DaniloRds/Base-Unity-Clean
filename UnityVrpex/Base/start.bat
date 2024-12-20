@echo off

echo ===---------[BASE UNITY]---------===
echo     Base Vrpex (final version)
echo     Bugs Fixed Version: 3.0.1
echo     Developed by: Unity Dev 
echo     Discord: discord.gg/kYFy8JwVfd
echo ===---------------------------------===

pause
start ..\artifacts\FXServer.exe +exec config/config.cfg +set onesync_enableInfinity 0 +set onesync on +set sv_enforceGameBuild 2612
exit

