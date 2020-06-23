::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: start deploy.bat create center 9010
:: start deploy.bat create gateway 10810
:: start deploy.bat create gameserver 25011
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

@echo off
chcp 65001

set "oper=%1"
set "type=%2"
set "port=%3"
echo deploy %oper% %type% %port%

set "source=F:\mir-assc-b\mir-products\trunk\MIR"
echo source_path = %source%

set "home=%~dp0"
echo home ^= %home%

if "%oper%" equ "" (
	echo stop gateway
	for /d %%a in (%home%gateway*) do (
		call :stop %%~na
		ping -n 1 127.1>nul
	)	
	rem pause
	echo stop gameserver
	for /d %%a in (%home%gameserver*) do (
		call :stop %%~na
		ping -n 1 127.1>nul
	)
	echo stop center
	for /d %%a in (%home%center*) do (
		call :stop %%~na
		ping -n 1 127.1>nul
	)	
	echo start center
	for /d %%a in (%home%center*) do (
		call :update %%~na %source%
		call :start %%~na
		ping -n 1 127.1>nul
	)		
	echo start gameserver
	for /d %%a in (%home%gameserver*) do (
		call :update %%~na %source%
		call :start %%~na
		ping -n 1 127.1>nul
	)
	echo start gateway
	for /d %%a in (%home%gateway*) do (
		call :update %%~na %source%
		call :start %%~na
		ping -n 1 127.1>nul
	)
	exit
)

if "%oper%" neq "create" if "%oper%" neq "start" if "%oper%" neq "stop" if "%oper%" neq "update" (
	echo oper fail: deploy %*
	exit
)

if "%type:~0,6%" neq "center" if "%type:~0,7%" neq "gateway" if "%type:~0,10%" neq "gameserver" (
	echo type err: deploy %*
	exit
)

if "%oper%" equ "update" (
	for /d %%a in (%home%%type%%port%) do (
		echo deal update dir %%a
		call :stop %%~na
		call :update %%~na %source%
		call :start %%~na
		ping -n 3 127.1>nul
	)
	exit
)

if "%oper%" equ "stop" (
	for /d %%a in (%home%%type%%port%) do (
		echo deal stop dir %%a
		call :stop %%~na
		ping -n 3 127.1>nul
	)
	exit
)

if "%oper%" equ "start" (
	for /d %%a in (%home%%type%%port%) do (
		echo deal start dir %%a
		call :stop %%~na
		call :start %%~na
		ping -n 3 127.1>nul
	)
	exit
)

if "%oper%" equ "create" (
	call :create %type% %port% %source%
	call :update %type%%port% %source%
	call :save %type%%port%
	call :start %type%%port%
	exit
)

echo end deploy %*
exit

:create
echo -------- call create %* --------
set "type=%1"
set "port=%2"
set "source=%3"

set "deploy_run=%~dp0"
echo cd deploy_run ^= %deploy_run%
cd /d %deploy_run%

for /f "tokens=1,2 delims= " %%c in (%deploy_run%\deploy_config.txt) do (
	set "%%c=%%d"
)

echo PlatformId ^= %PlatformId%
echo PlatformName ^= %PlatformName%

echo PingTimeout ^= %PingTimeout%
echo ApiHost ^= %ApiHost%

echo MysqlHost ^= %MysqlHost%
echo MysqlPort ^= %MysqlPort%
echo MysqlUser ^= %MysqlUser%
echo MysqlPassword ^= %MysqlPassword%
echo MysqlDatabase ^= %MysqlDatabase%

echo RedisHost ^= %RedisHost%
echo RedisPort ^= %RedisPort%
echo RedisPassword ^= %RedisPassword%
echo RedisDB ^= %RedisDB%

echo MergedBackupPath ^=%MergedBackupPath%

if not exist %type%%port% md %type%%port%
cd /d %deploy_run%\%type%%port%
	
if "%type%" equ "center" (
	if not exist config.json (
		echo create config.json

		echo {> config.json
		echo 	"ServerPort": %port%,>> config.json
		echo 	"PingTimeout": %PingTimeout%,>> config.json
		echo 	"Md5Key": "09e09b3b4c037edca36b1075dcbc24f5",>> config.json
		echo 	"ApiHost": %ApiHost%,>> config.json
		echo 	"PlatformId": %PlatformId%,>> config.json
		echo 	"DB":%RedisDB%,>> config.json
		echo 	"MysqlCfg" : {>> config.json	
		echo 	"Host" : %MysqlHost%,>> config.json
		echo 	"Port" : %MysqlPort%,>> config.json
		echo 	"User" : %MysqlUser%,>> config.json
		echo 	"Password" : %MysqlPassword%,>> config.json
		echo 	"Database" : %MysqlDatabase%>> config.json
		echo 	},>> config.json
		echo 	"RedisCfg" : {>> config.json
		echo 	"Host" : %RedisHost%,>> config.json
		echo 	"Port" : %RedisPort%,>> config.json
		echo 	"Password" : %RedisPassword%>> config.json
		echo 	},>> config.json
		echo 	"MergedBackupPath":%MergedBackupPath%>> config.json
		echo }>> config.json
	)	
)

if "%type%" equ "gateway" (
	if not exist gw_settings.json (
		echo create gw_settings.json

		echo {> gw_settings.json
		echo 	"UserPort": %port%,>> gw_settings.json
		echo 	"WebCenterUrls": %ApiHost%>> gw_settings.json
		echo }>> gw_settings.json
	)
)

if "%type%" equ "gameserver" (
	if not exist config mkdir config
	cd .\config
	if not exist game_server_config.json (
		echo create game_server_config.json
		echo {> game_server_config.json
		echo   "PlatformId": "0", //平台标识>> game_server_config.json
		echo   "PlatformName": "demo",>> game_server_config.json
		echo   "ServerPort": %port%, //端口>> game_server_config.json
		echo   "WebCenterBaseAdresses":[%ApiHost%],>> game_server_config.json
		echo   "Gname": "ltby2",>> game_server_config.json
		echo   "Gid": 139,>> game_server_config.json
		echo   "webdata": {>> game_server_config.json
		echo     "key": "09e09b3b4c037edca36b1075dcbc24f5",>> game_server_config.json
		echo     "addr": "http://service.code.gscq.wmhdgame.cn/ExchangeCode/Validated",>> game_server_config.json
		echo     "addr2": "http://service.code.gscq.wmhdgame.cn/ExchangeCode/ResultValidated",>> game_server_config.json
		echo   },>> game_server_config.json
		echo   "SetRoleInitAttr": true,>> game_server_config.json
		echo   "SetPlotPass": true,>> game_server_config.json
		echo   "DbLogicSaveInterval": 180000,>> game_server_config.json
		echo }>> game_server_config.json
	)

	if not exist game_server_log.conf (
		echo create game_server_log.json
		copy /y %source%\server\config\game_server_log.conf .\game_server_log.conf
	)
	cd ..\
	
	if not exist _commit.bat (
		copy /y %source%\server\_commit.bat _commit.bat
		copy /y %source%\server\lge.dll lge.dll
		copy /y %source%\server\log4net.dll log4net.dll
		copy /y %source%\server\log4net.pdb log4net.pdb
		copy /y %source%\server\Microsoft.QualityTools.Testing.Fakes.dll Microsoft.QualityTools.Testing.Fakes.dll
		copy /y %source%\server\MySql.Data.dll MySql.Data.dll
		copy /y %source%\server\Newtonsoft.Json.dll Newtonsoft.Json.dll
		copy /y %source%\server\Newtonsoft.Json.pdb Newtonsoft.Json.pdb
		copy /y %source%\server\PerfCopy.dll PerfCopy.dll
		copy /y %source%\server\PerfCopy.pdb PerfCopy.pdb
		copy /y %source%\server\PerfCopy.xml PerfCopy.xml
		copy /y %source%\server\protobuf-net.dll protobuf-net.dll
		copy /y %source%\server\RingByteBuffer.dll RingByteBuffer.dll
		copy /y %source%\server\RingByteBuffer.pdb RingByteBuffer.pdb
		copy /y %source%\server\RingByteBuffer.xml RingByteBuffer.xml
		copy /y %source%\server\ServiceStack.Client.dll ServiceStack.Client.dll
		copy /y %source%\server\ServiceStack.Common.dll ServiceStack.Common.dll
		copy /y %source%\server\ServiceStack.Interfaces.dll ServiceStack.Interfaces.dll
		copy /y %source%\server\ServiceStack.Redis.dll ServiceStack.Redis.dll
		copy /y %source%\server\ServiceStack.Redis.pdb ServiceStack.Redis.pdb
		copy /y %source%\server\ServiceStack.Text.dll ServiceStack.Text.dll
		copy /y %source%\server\System.Data.SQLite.dll System.Data.SQLite.dll
	)
)
goto :exit

:stop
echo -------- call stop %1 --------
tasklist /nh | find "%1.exe" && taskkill /t /im "%1.exe" && ping -n 3 127.1>nul
goto :exit

:start
echo -------- call start %1 --------
cd /d %~dp0%1
start %1.exe
goto :exit

:update
echo -------- call update %1 --------
set "name=%1"
set "source=%2"
set "junctionpath=%source%\..\tool"

cd /d %~dp0%1

if not exist data md data
if "%name:~0,6%" equ "center" (
	copy /y %source%\center\data\config.json .\data\config.json
	copy /y %source%\center\center .\center
	copy /y %source%\center\center.exe .\%name%.exe

	%junctionpath%\junction -d .\data\data
	%junctionpath%\junction .\data\data %source%\..\publish\export\server\Config\data
)

if "%name:~0,7%" equ "gateway" (
	copy /y %source%\gateway\gateway .\gateway
	copy /y %source%\gateway\gateway.exe .\%name%.exe
)

if "%name:~0,10%" equ "gameserver" (
	copy /y %source%\server\GameCore.dll GameCore.dll
	copy /y %source%\server\GameCore.pdb GameCore.pdb
	copy /y %source%\server\GameDb.dll GameDb.dll
	copy /y %source%\server\GameDb.pdb GameDb.pdb
	copy /y %source%\server\GameLib.dll GameLib.dll
	copy /y %source%\server\GameLib.pdb GameLib.pdb
	copy /y %source%\server\GameMain.exe %name%.exe
	copy /y %source%\server\GameMain.exe.config GameMain.exe.config
	copy /y %source%\server\GameMain.pdb GameMain.pdb
	copy /y %source%\server\GameServer.dll GameServer.dll
	copy /y %source%\server\GameServer.pdb GameServer.pdb
	
	%junctionpath%\junction -d .\data
	%junctionpath%\junction -d .\map
	%junctionpath%\junction -d .\script

	%junctionpath%\junction .\data %source%\..\publish\export\server\Config\data
	%junctionpath%\junction .\map %source%\..\publish\export\server\Config\map
	%junctionpath%\junction .\script %source%\..\publish\export\server\Code\script
)
goto :exit

:save
echo -------- call save %1 --------
cd /d %~dp0%1

echo %~dp0%1
if not exist run.bat (
	echo cd /d %%~dp0\..\ >run.bat
	echo call deploy.bat update %1 >>run.bat
	echo exit >>run.bat
)

:exit
echo done