@echo off

set "platform=%1"
set "logdate=%2"
set "logpath=%~dp0\log"
SET "source=%~dp0"

echo start main.bat %platform% %logdate%

CD /D %source%

if not exist log (
	md log
)

if exist ftptmp.bat (
	del ftptmp.bat 
)

echo md log_config
IF not exist log_config.txt (
	echo center_backup >log_config.txt
	echo center_data >>log_config.txt
	echo center_external >>log_config.txt	
	echo center_logic >>log_config.txt	
	echo center_misc >>log_config.txt
	echo center_report >>log_config.txt
	echo center_server >>log_config.txt	
	echo gateway1 >>log_config.txt
	echo gateway2 >>log_config.txt
	echo gateway3 >>log_config.txt
	echo gateway4 >>log_config.txt	
	PING -N 1 127.1>nul
)

echo md ftp_config

echo open 129.211.98.180 >ftptmp.bat
echo user assc AoKnQq54HGLyqlgS >>ftptmp.bat
echo prompt >>ftptmp.bat

FOR /F %%h IN (%source%\log_config.txt) DO (
	if not EXIST %logpath%\%%h md %logpath%\%%h
	if not EXIST %logpath%\%%h\%logdate% md %logpath%\%%h\%logdate%
	
	echo cd %platform%/%%h/%logdate% >>ftptmp.bat
	echo lcd %logpath%/%%h/%logdate% >>ftptmp.bat
	echo mget *.* >>ftptmp.bat
	echo cd ../../../  >>ftptmp.bat
)

echo bye>>ftptmp.bat
echo exit>>ftptmp.bat

PING -N 1 127.1>nul
echo start get_log

ftp -n -s:ftptmp.bat

echo end get_log

PING -N 1 127.1>nul
echo del ftp_config
del ftptmp.bat 
log_config.txt

exit