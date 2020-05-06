@echo off
cd /d %~dp0

::拡張子抜きファイル名の取得
for %%i in ("%IN_PATH%") do set filename=%%~ni
echo filename=%filename%

rem ::tsフォルダのtxtをにlog_errに移動
rem move "D:\video\ts\%filename%.ts.err" D:\video\ts\err_txt_log
rem 
rem ::tsフォルダのerrをlog_errに
rem move "D:\video\ts\%filename%.ts.program.txt" D:\video\ts\err_txt_log
rem 
rem ::tmpフォルダのenc.errをlog_errに
rem move "D:\video\tmp\%filename%-enc.log" D:\video\ts\err_txt_log
rem 
rem echo filename=%filename%

::tsフォルダのtxtをにlog_errに移動
move D:\video\ts\*.ts.err D:\video\ts\err_txt_log

::tsフォルダのerrをlog_errに
move D:\video\ts\*.ts.program.txt D:\video\ts\err_txt_log

::tmpフォルダのenc.errをlog_errに
move D:\video\tmp\*-enc.log D:\video\ts\err_txt_log

echo filename=%filename%

::10GB以上かの判断以上であればoverに格納
::for /f "usebackq delims=" %%i in ("D:\video\tmp\%filename%*.mp4") do (
for %%i in (D:\video\tmp\*.mp4) do (
    echo %%i

    rem if %%~zi gtr 10737418240 (
    rem     rem 10GBを上回ったのでoverフォルダに
    rem     move "%%i" D:\video\tmp\over
    rem )  else ( 
    rem     rem 10GBを下回ったので処理
rem 
    rem     ::ここまで共通 ここから分岐
    rem     echo %%i
rem 
    rem     rem        ::ファイル名に”めざまし"あればmezaにコピー
    rem     rem        echo "%filename%" | find "めざまし" >NUL
    rem     rem        if not ERRORLEVEL 1 copy "%%i" D:\video\mp4\meza
    rem     rem
    rem     rem        ::ファイル名に”WBS”あればwbsにコピー
    rem     rem        echo "%filename%" | find "WBS" >NUL
    rem     rem        if not ERRORLEVEL 1 copy "%%i" D:\video\mp4\wbs
rem 
    rem     ::ここまで分岐 ここから共通
rem 
    rem     rem mp4フォルダにコピー
    rem     move "%%i" D:\video\mp4
rem 
    rem )
    echo for-clear

    if %%~zi gtr 10737418240 (
        echo over 10GB 
         move "%%i" D:\video\tmp\over
    )  else ( 
        ::ファイル名に”めざまし"あればmezaにコピー
        echo "%filename%"
        echo "%filename%" | find "めざまし" >NUL
        if not ERRORLEVEL 1 copy "%%i" D:\video\mp4\meza
        ::ファイル名に”WBS”あればwbsにコピー
        echo "%filename%"
        echo "%filename%" | find "WBS" >NUL
        if not ERRORLEVEL 1 copy "%%i" D:\video\mp4\wbs
        echo under 10GB 
        move "%%i" D:\video\mp4
    )

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



rem ::苦労のあと
rem ::ここまで共通
rem ::ここから分岐
rem 
rem rem ::mezaにコピー
rem rem for %%a in ("%OUT_PATH%.mp4") do (
rem rem     copy "D:\video\mp4\%%~nxa" D:\video\mp4\meza
rem rem     )
rem rem 
rem rem ::wbsに移動
rem rem for %%a in ("%OUT_PATH%.mp4") do (
rem rem     copy "D:\video\mp4\%%~nxa" D:\video\mp4\wbs
rem rem     )
rem 
rem 
rem 
rem ::video
rem :: ts  -sucseed
rem ::     -faild
rem ::     -txt_err_log
rem ::
rem ::
rem ::
rem :: tmp
rem ::     -over
rem ::
rem :: mp4 -limit
rem ::      save
rem ::      stock
rem ::
rem 
rem ::1.3はtmpファイルなどのすべてのフォルダを対象に
rem ::*を使って
rem 
rem ::ts_encode1.4が下敷きとなっているbatファイル
