@echo off
cd /d %~dp0

::まずエンコードしたものはtmpフォルダに

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
    echo %%i
    echo %%~ni
    echo %%~zi

    if %%~zi gtr 10737418240 (
        echo 10GBをオーバーしていました
         move "%%i" D:\video\tmp\over
    )  else ( 
        echo 10GB以内でした
        move "%%i" D:\video\mp4
    )
)

::test
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
