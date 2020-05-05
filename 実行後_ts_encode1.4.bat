@echo off
cd /d %~dp0

::まずエンコードしたものはtmpフォルダに

echo test1
echo ITEM_ID=%ITEM_ID%
echo IN_PATH=%IN_PATH%
echo OUT_PATH=%OUT_PATH%
echo SERVICE_ID=%SERVICE_ID%
echo SERVICE_NAME=%SERVICE_NAME%
echo TS_TIME=%TS_TIME%
echo ITEM_MODE=%ITEM_MODE%
echo ITEM_PRIORITY=%ITEM_PRIORITY%
echo EVENT_GENRE=%EVENT_GENRE%
echo IMAGE_WIDTH=%IMAGE_WIDTH%
echo IMAGE_HEIGHT=%IMAGE_HEIGHT%
echo EVENT_NAME=%EVENT_NAME%
echo TAG=%TAG%

::拡張子抜きファイル名
for %%i in ("%IN_PATH%") do set filename=%%~ni
echo filename=%filename%
::拡張子までファイル名
for %%a in ("%OUT_PATH%.mp4") do set filename2=%%~nxa
echo filename2=%filename2%

rem オプションありで
echo for /f test
for /f "delims=" %%a in ("%IN_PATH%") do set IN_NAME=%%~na
for /f "delims=" %%a in ("%OUT_PATH%") do set OUT_DIR=%%~dpa
echo %IN_NAME% | find "NHK" 
if not ERRORLEVEL 1 echo "%OUT_DIR%NHK"
echo IN_PATH=%IN_PATH%
echo  IN_NAME=%IN_NAME%

echo %IN_NAME% | find "TVQ" 
if not ERRORLEVEL 1 echo "%OUT_DIR%TVQ"
echo OUT_PATH=%OUT_PATH%
echo  OUT_DIR=%OUT_DIR%

rem /fオプション抜きで
echo for /f test without option
for %%a in ("%IN_PATH%") do set IN_NAME2=%%~na
for %%a in ("%OUT_PATH%") do set OUT_DIR2=%%~dpa
echo %IN_NAME% | find "NHK" 
if not ERRORLEVEL 1 echo "%OUT_DIR2%NHK"
echo IN_PATH=%IN_PATH%
echo  IN_NAME2=%IN_NAME2%

echo %IN_NAME% | find "TVQ" 
if not ERRORLEVEL 1 echo "%OUT_DIR2%TVQ"
echo OUT_PATH=%OUT_PATH%
echo  OUT_DIR2=%OUT_DIR2%

::ファイル名を取得
::for %%i in ("%IN_PATH%") do set filename=%%~ni

::tsフォルダのtxtをにlog_errに移動
move D:\video\ts\*.ts.err D:\video\ts\err_txt_log

::tsフォルダのerrをlog_errに
move D:\video\ts\*.ts.program.txt D:\video\ts\err_txt_log

::tmpフォルダのenc.errをlog_errに
move D:\video\tmp\*-enc.log D:\video\ts\err_txt_log


::10GB以上かの判断以上であればoverに格納
::以下であればmp4フォルダに
for %%i in (D:\video\tmp\*.mp4) do (
    echo 10GB ober or under
    echo %%i
    echo %%~ni
    echo %%~zi

    if %%~zi gtr 10737418240 (
        echo over 10GB 
         move "%%i" D:\video\tmp\over
    )  else ( 
        echo under 10GB 
        move "%%i" D:\video\mp4
    )
)

echo test2
echo ITEM_ID=%ITEM_ID%
echo IN_PATH=%IN_PATH%
echo OUT_PATH=%OUT_PATH%
echo SERVICE_ID=%SERVICE_ID%
echo SERVICE_NAME=%SERVICE_NAME%
echo TS_TIME=%TS_TIME%
echo ITEM_MODE=%ITEM_MODE%
echo ITEM_PRIORITY=%ITEM_PRIORITY%
echo EVENT_GENRE=%EVENT_GENRE%
echo IMAGE_WIDTH=%IMAGE_WIDTH%
echo IMAGE_HEIGHT=%IMAGE_HEIGHT%
echo EVENT_NAME=%EVENT_NAME%
echo TAG=%TAG%

::mp4やtsの削除

::3日以上前の*.tsを削除
forfiles /P D:\video\ts\succeeded /D -3 /M "*.ts" /c "cmd /c del @file"

::30日以上前の*.mp4を削除
forfiles /P D:\video\mp4 /D -30 /M "*.mp4" /c "cmd /c del @file"


::video
:: ts  -sucseed
::     -faild
::     -txt_err_log
::
:: tmp
::     -over
::
:: mp4 -txt_err_log

::1.3はtmpファイルなどのすべてのフォルダを対象に
::*を使って
