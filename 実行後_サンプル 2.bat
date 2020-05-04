@echo off
for /f "delims=" %%a in ("%OUT_PATH%") do set DST=%%~dpa???C???????O
mkdir "%DST%"
for /f "delims=" %%a in ('GetOutFiles cwdtl') do set FILES=%%a
:loop
for /f "tokens=1* delims=;" %%a in ("%FILES%") do (
   move /Y "%%a" "%DST%"
   set FILES=%%b
   )
if defined FILES goto :loop


::まずエンコードしたものはtempフォルダに

::tsフォルダのtxtをにlog_errに移動
::tsフォルダのerrをlog_errに
::tempフォルダのenc.errをlog_errに

::10GB以上かの判断以上であればover10GBに格納
::以下であればmp4フォルダに

::mp4フォルダに.mp4がある場合sucsesseフォルダのtsを削除


::video
:: ts  -sucseed
::     -faild
::
:: temp-txt_err_log
::     -over10GB
::
:: mp4

