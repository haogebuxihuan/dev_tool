@echo off

set "base_url=http://192.168.1.66:9090"
set "md5_key=09e09b3b4c037edca36b1075dcbc24f5"

set "file_content=%1"
if "%file_content%" equ "" (
	echo send invalid
	goto :exit
	pause
	exit
)

if not exist %home%%file_content% (
	echo send config failed, not exist %home%%file_content%
	goto :exit
	pause
	exit
)

set "home=%~dp0"
for /f "tokens=1 delims= " %%a in (%home%%file_content%) do (
	set "pattern=%%a"
	goto :next
)

:next
if exist send_content del send_content
if exist send_content_md5 del send_content_md5

>send_content set /p=%base_url%%pattern%<nul

for /f "skip=1 tokens=1,2 delims==" %%a in (%home%%file_content%) do (
	>>send_content set /p=?%%a^=%%b<nul
	>>send_content_md5 set /p=%%a^=%%b<nul
	goto :next_step
)

echo ----------- end next ----------- 
goto :exit

:next_step
for /f "skip=2 tokens=1,2 delims==" %%a in (%home%%file_content%) do (
	>>send_content set /p=^&%%a^=%%b<nul
	>>send_content_md5 set /p=^&%%a^=%%b<nul
)

>>send_content_md5 set /p=%md5_key%<nul

if exist md5.txt del md5.txt
CertUtil -hashfile %home%send_content_md5 MD5 > md5.txt
for /f "skip=1 tokens=1,2 delims==" %%a in (%home%md5.txt) do (
	>>send_content set /p=^&sign^=%%a<nul
	goto :send
)
echo ----------- end next_step ----------- 
goto :exit

:send
for /f "tokens=1 delims= " %%a in (%home%send_content) do (
	echo curl %%a
	curl %%a
	goto :clear
)
echo ----------- end send ----------- 
goto :exit

:clear
del md5.txt
del send_content
del send_content_md5

:exit
echo done