@echo off
cd /d %~dp0

::�܂��G���R�[�h�������̂�temp�t�H���_��

::�t�@�C�������擾
for %%i in ("%IN_PATH%") do set FILE_NAME=%%~ni

::ts�t�H���_��txt����log_err�Ɉړ�
move D:\video\ts\%FILE_NAME%.ts.err D:\video\temp\err_txt_log

::ts�t�H���_��err��log_err��
move D:\video\ts\%FILE_NAME%.ts.program.txt D:\video\temp\err_txt_log

::temp�t�H���_��enc.err��log_err��
move D:\video\temp\%FILE_NAME%-enc.log D:\video\temp\err_txt_log

::10GB�ȏォ�̔��f�ȏ�ł����over�Ɋi�[
::�ȉ��ł����mp4�t�H���_��
for %%i in ("D:\video\temp\%FILE_NAME%.mp4") do set SIZE=%%~zi

if %SIZE% lss 10737418240Byte (
    rem �t�@�C���ړ�
    move D:\video\temp\%FILE_NAME%.mp4 D:\video\temp\over
) else ( 
    rem �t�@�C���͂��̂܂�
    move D:\video\temp\%FILE_NAME%.mp4 D:\video\mp4
)


::mp4�t�H���_��.mp4������ꍇsucsesse�t�H���_��ts���폜


::video
:: ts  -sucseed
::     -faild
::
:: temp-txt_err_log
::     -over
::
:: mp4

