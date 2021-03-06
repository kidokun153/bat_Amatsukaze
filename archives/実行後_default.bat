@echo off
cd /d %~dp0

::拡張子抜きファイル名の取得
for %%i in ("%IN_PATH%") do set filename=%%~ni
echo filename=%filename%

::tsフォルダのtxtをにlog_errに移動
move "D:\video\ts\%filename%.ts.err" D:\video\ts\err_txt_log

::tsフォルダのerrをlog_errに
move "D:\video\ts\%filename%.ts.program.txt" D:\video\ts\err_txt_log

::tmpフォルダのenc.errをlog_errに
move "D:\video\tmp\%filename%-enc.log" D:\video\ts\err_txt_log


::10GB以上かの判断以上であればoverに格納
::以下であればmp4フォルダに
for /f "usebackq" %%i in ("D:\video\tmp\%filename%*.mp4") do (
if %%~zi gtr 10737418240 (
    rem 10GBを上回ったのでoverフォルダに
    move "%%i" D:\video\tmp\over
)  else ( 
    rem 10GBを下回ったので処理

    ::ここまで共通 ここから分岐

    ::ファイル名に”めざまし"あればmezaにコピー
    echo %filename% | find "めざまし" >NUL
    if not ERRORLEVEL 1 copy "%%i" D:\video\mp4\meza

    ::ファイル名に”WBS”あればwbsにコピー
    echo %filename% | find "WBS" >NUL
    if not ERRORLEVEL 1 copy "%%i" D:\video\mp4\wbs

    ::ここまで分岐 ここから共通

    rem mp4フォルダにコピー
    move "%%i" D:\video\mp4

)

::mp4やtsの削除

::3日以上前の*.tsを削除
forfiles /P D:\video\ts\succeeded /D -3 /M "*.ts" /c "cmd /c del @file"

::15日以上前の*.mp4を削除
forfiles /P D:\video\mp4 /D -15 /M "*.mp4" /c "cmd /c del @file"

::3か月以上前のlimitのmp4削除
forfiles /P D:\video\mp4\limit /D -90 /M "*.mp4" /c "cmd /c del @file"

::2か月以上前のmezaのmp4削除
forfiles /P D:\video\mp4\meza /D -60 /M "*.mp4" /c "cmd /c del @file"

::2か月以上前のwbsのmp4削除
forfiles /P D:\video\mp4\wbs /D -60 /M "*.mp4" /c "cmd /c del @file"



::苦労のあと
::ここまで共通
::ここから分岐

rem ::mezaにコピー
rem for %%a in ("%OUT_PATH%.mp4") do (
rem     copy "D:\video\mp4\%%~nxa" D:\video\mp4\meza
rem     )
rem 
rem ::wbsに移動
rem for %%a in ("%OUT_PATH%.mp4") do (
rem     copy "D:\video\mp4\%%~nxa" D:\video\mp4\wbs
rem     )


rem     ::ファイル名に”めざまし"あればmezaにコピー
rem     echo %filename% | find "めざまし" >NUL
rem     if not ERRORLEVEL 1 copy "%%i" D:\video\mp4\meza\%%ni.mp4"
rem 
rem     ::ファイル名に”WBS”あればwbsにコピー
rem     echo %filename% | find "WBS" >NUL
rem     if not ERRORLEVEL 1 copy "%%i" "D:\video\mp4\wbs\%%ni.mp4"

::video
:: ts  -sucseed
::     -faild
::     -txt_err_log
::
::
::
:: tmp
::     -over
::
:: mp4 -limit
::      save
::      stock
::

::1.3はtmpファイルなどのすべてのフォルダを対象に
::*を使って

::ts_encode1.4が下敷きとなっているbatファイル
