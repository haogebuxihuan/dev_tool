:: start cross team and game team
:: 本文件放在 根目录
:: \mir-products\trunk\MIR 这个路径需要 server_config 文件。   1, 配置的服务器文件 *.json。   2, config_list.txt里面记录要启动的服务器。
:: gaowenhao

@ECHO off

CHCP 65001
TASKLIST /NH | find "GameMain.exe" && TASKKILL /F /T /IM "GameMain.exe"

ECHO 等待结束上一次启动的进程
PING -N 3 127.1>nul

SET "source=%~dp0\mir-products\trunk\MIR"

ECHO 目录切换到工作目录 %source%
CD /D %source%

rem 检查文件
IF NOT EXIST server_config (
	ECHO 目录 %source% 下缺少配置文件 server_config
	Pause
	EXIT
)

IF NOT EXIST server_config\config_list.txt (
	ECHO 目录 %source%\server_config\ 下缺少配置文件 config_list.txt
	Pause
	EXIT
)
	
IF NOT EXIST server_config\cs_config.txt (
	ECHO 目录 %source%\server_config\ 下缺少配置文件 cs_config.txt
	Pause
	EXIT
)

FOR /F %%h IN (%source%\server_config\config_list.txt) DO (	
	PING -N 3 127.1>nul
	ECHO 目标是 %%h
	::IF EXIST %%h rmdir /S/Q %%h	
	IF NOT EXIST %%h MD %%h	
	IF NOT EXIST %%h\config MD %%h\config
	IF NOT EXIST %%h\log MD %%h\log

	COPY /Y server %%h
	COPY /Y server_config\%%h.json %%h\config\game_server_config.json
	COPY /Y server\config\game_server_log.conf %%h\config\game_server_log.conf
	
	ECHO %%h | find "game">nul &&(
		COPY /Y server_config\cs_config.txt %%h\config\cs_config.txt
	)

	junction -d %%h/data
	junction -d %%h/map
	junction -d %%h/script

	junction %%h/data ../publish/export/server/Config/data
	junction %%h/map ../publish/export/server/Config/map
	junction %%h/script ../publish/export/server/Code/script
)

ECHO 服务器布置结束

ECHO 跨服服务器启动准备
PING -N 3 127.1>nul

FOR /F %%h IN (%source%\server_config\config_list.txt) DO (
	ECHO %%h | find "cross">nul &&(
		CD /D %source%/%%h
		START GameMain.exe
	) 
)
ECHO 等待跨服服务器启动结束

ECHO 游戏服务器启动准备
PING -N 3 127.1>nul
FOR /F %%h IN (%source%\server_config\config_list.txt) DO (
	ECHO %%h | find "game">nul &&(
		CD /D %source%/%%h
		START GameMain.exe
	)
)
ECHO 游戏服务器启动准备结束

PING -N 3 127.1>nul

CD /D %source%\client
start MIR.exe






