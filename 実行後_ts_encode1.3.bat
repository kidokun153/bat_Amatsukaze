@echo off
cd /d %~dp0

::まずエンコードしたものはtempフォルダに

::ファイル名を取得
for %%i in ("%IN_PATH%") do set FILE_NAME=%%~ni

::tsフォルダのtxtをにlog_errに移動
move D:\video\ts\%FILE_NAME%.ts.err D:\video\temp\err_txt_log

::tsフォルダのerrをlog_errに
move D:\video\ts\%FILE_NAME%.ts.program.txt D:\video\temp\err_txt_log

::tempフォルダのenc.errをlog_errに
move D:\video\temp\%FILE_NAME%-enc.log D:\video\temp\err_txt_log

::10GB以上かの判断以上であればoverに格納
::以下であればmp4フォルダに
for %%i in ("D:\video\temp\%FILE_NAME%.mp4") do set SIZE=%%~zi

if %SIZE% lss 10737418240Byte (
    rem ファイル移動
    move D:\video\temp\%FILE_NAME%.mp4 D:\video\temp\over
) else ( 
    rem ファイルはそのまま
    move D:\video\temp\%FILE_NAME%.mp4 D:\video\mp4
)


::mp4フォルダに.mp4がある場合sucsesseフォルダのtsを削除


::video
:: ts  -sucseed
::     -faild
::
:: temp-txt_err_log
::     -over
::
:: mp4

