@echo off

chcp 65001

set "path=%~dp0"
cd /d C:\Program Files\MySQL\MySQL Server 5.7\bin\
echo path ^= %path%

echo echo import base.sql

for /r %path% %%a in (*.sql) do (
	if "%%a" neq "%path%next.sql" (
		echo base %%a
		mysql.exe --protocol=tcp --host=localhost --user=root --port=3306 --default-character-set=utf8 --comments --database=mir_simple_logic_3  < "%%a"
	)
)

echo import next.sql
mysql.exe --protocol=tcp --host=localhost --user=root --port=3306 --default-character-set=utf8 --comments --database=mir_simple_logic_3  < "%path%next.sql"

pause
