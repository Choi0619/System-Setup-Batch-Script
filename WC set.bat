@echo off 
rem mode con cols=80 lines=20 
color 0a

>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo Run as Administrator...
    goto UACPrompt
) else ( goto gotAdmin )
:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    rem del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
title ��������ǻ�� ������

:main
cls
echo.
echo.
echo		[44;37m[��������ǻ�� ������ ����][0m
echo.
echo		1. ��������ǻ�� ���� �ѹ��� �����ϱ� (2~4�� ����)
echo.
echo		2. ��������ǻ�� ���ȭ�鸸 �����ϱ�
echo.
echo		3. ��������ǻ�� OEM �ΰ� �߰��ϱ�
echo.
echo		4. ��������ǻ�� ��ũ/�ϸ�ũ �߰��ϱ�
echo.
echo		5. ������ ����� ���� / �ѱ�
echo.
echo		6. ������̺�(OneDrive) ����
echo.
echo		7. ������ �ڵ� ������Ʈ ���� / Ȱ��ȭ
echo.
echo		8. Administrator �ְ� ������ ���� Ȱ��ȭ / ��Ȱ��ȭ
echo.
echo		9. �����ϱ�
echo.

echo.
set menu=
set /p menu=���Ͻô� �۾� ��ȣ�� �Է� �� ����(Enter)�� �����ּ��� : 
if "%menu%" == "1" goto all
if "%menu%" == "2" goto background
if "%menu%" == "3" goto oem
if "%menu%" == "4" goto links
if "%menu%" == "5" goto def
if "%menu%" == "6" goto one_del
if "%menu%" == "7" goto no_update
if "%menu%" == "8" goto admin_enable
if "%menu%" == "9" goto EXIT
goto main


:all
regedit.exe /s "%~dp0\set\oem Withus.reg" /f

copy "%~dp0\set\OEMLOGO.bmp" "c:\windows\system32\oobe" /y
copy "%~dp0\set\withusbackground.jpg" "C:\Windows\System32" /y

reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d  wallpaper_path /f 
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d C:\Windows\System32\withusbackground.jpg /f
RUNDLL32.EXE user32.dll, UpdatePerUserSystemParameters ,1 ,True

copy "%~dp0\set\Google.url" "C:\Users\%USERNAME%\Favorites\Links"
copy "%~dp0\set\NAVER.url" "C:\Users\%USERNAME%\Favorites\Links"
copy "%~dp0\set\YouTube.url" "C:\Users\%USERNAME%\Favorites\Links"
copy "%~dp0\set\������ �������� - ������.url" "C:\Users\%USERNAME%\Favorites\Links"
copy "%~dp0\set\��������ǻ��.url" "C:\Users\%USERNAME%\Favorites\Links"
reg add "HKCU\Software\Microsoft\Internet Explorer\MINIE" /v AlwaysShowMenus /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Internet Explorer\MINIE" /v LinksBandEnabled /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Internet Explorer\MINIE" /v CommandBarEnabled /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Internet Explorer\MINIE" /v ShowStatusBar /t REG_DWORD /d 1 /f
copy "%~dp0\set\Bookmarks" "C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\User Data\Default"


echo.
pause
goto main

:oem
rem oem �������丮 �߰� ::::
regedit.exe /s "%~dp0\set\oem Withus.reg" /f

rem oem �ΰ� �߰� ::::
copy "%~dp0\set\OEMLOGO.bmp" "c:\windows\system32\oobe" /y

echo.
pause
goto main

:background
rem ������ ���ȭ�� ��� ::::
copy "%~dp0\set\withusbackground.jpg" "C:\Windows\System32" /y
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d  wallpaper_path /f 
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d C:\Windows\System32\withusbackground.jpg /f  
RUNDLL32.EXE user32.dll, UpdatePerUserSystemParameters ,1 ,True


echo.
pause
goto main


:links
rem ������ ��ũ/�ϸ�ũ �߰� ::::
copy "%~dp0\set\Google.url" "C:\Users\%USERNAME%\Favorites\Links"
copy "%~dp0\set\NAVER.url" "C:\Users\%USERNAME%\Favorites\Links"
copy "%~dp0\set\YouTube.url" "C:\Users\%USERNAME%\Favorites\Links"
copy "%~dp0\set\������ �������� - ������.url" "C:\Users\%USERNAME%\Favorites\Links"
copy "%~dp0\set\��������ǻ��.url" "C:\Users\%USERNAME%\Favorites\Links"
reg add "HKCU\Software\Microsoft\Internet Explorer\MINIE" /v AlwaysShowMenus /t REG_DWORD /d 1 /f   
reg add "HKCU\Software\Microsoft\Internet Explorer\MINIE" /v LinksBandEnabled /t REG_DWORD /d 1 /f   
reg add "HKCU\Software\Microsoft\Internet Explorer\MINIE" /v CommandBarEnabled /t REG_DWORD /d 1 /f   
reg add "HKCU\Software\Microsoft\Internet Explorer\MINIE" /v ShowStatusBar /t REG_DWORD /d 1 /f
copy "%~dp0\set\Bookmarks" "C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\User Data\Default"

echo.
pause
goto main


:def
start %~dp0\set\def\"DefenderControl.exe"
echo.
pause
goto main


:one_del
cls
echo.
echo.
echo		[44;37m[ ������̺�(OneDrive) �����ϱ� ][0m
echo.
set x86="%SYSTEMROOT%\System32\OneDriveSetup.exe"
set x64="%SYSTEMROOT%\SysWOW64\OneDriveSetup.exe"
echo.
echo OneDrive ���� �غ���...
echo.
taskkill /f /im OneDrive.exe > NUL 2>&1
ping 127.0.0.1 -n 5 > NUL 2>&1
echo OneDrive ���� ���μ����� �ݴ���...
echo.
if exist %x64% (
%x64% /uninstall
) else (
%x86% /uninstall
)
ping 127.0.0.1 -n 5 > NUL 2>&1
echo OneDrive ���� ���� ������...
echo.
rd "%USERPROFILE%\OneDrive" /Q /S > NUL 2>&1
rd "C:\OneDriveTemp" /Q /S > NUL 2>&1
rd "%LOCALAPPDATA%\Microsoft\OneDrive" /Q /S > NUL 2>&1
rd "%PROGRAMDATA%\Microsoft OneDrive" /Q /S > NUL 2>&1 
echo OneDrive ���� ������Ʈ�� ���� ������...
echo.
REG DELETE "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f > NUL 2>&1
REG DELETE "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f > NUL 2>&1
echo.
echo OneDrive�� ���������� �����Ͽ����ϴ�!
echo.
echo.
echo.
pause
goto main

:no_update
start %~dp0\set\no_update\"Wub.exe"
echo.
pause
goto main


:admin_enable
cls
echo.
echo.
echo		[44;37m[ �ְ� ������ administrator ���� ����  ][0m
echo.
echo.
echo		1. Administrator �ְ� ������ ���� Ȱ��ȭ �ϱ�
echo.
echo		2. Ȱ��ȭ�� Administrator �ְ� ������ ���� ��Ȱ��ȭ �ϱ�
echo.
echo		3. ���� �޴��� ����
echo.
echo.
set menu=
set /p menu=���Ͻô� �۾� ��ȣ�� �Է� �� ����(Enter)Ű�� �����ּ��� : 
if "%menu%" == "1" goto a
if "%menu%" == "2" goto b
if "%menu%" == "3" goto main
goto admin

:a
net user administrator /active:yes
echo.
pause
goto main

:b
net user Administrator /active:no
echo.
pause
goto main


rem goto SUCCESS

rem :SUCCESS
rem rem echo ���� ���� �� ������ �Ϸ�Ǿ����ϴ�.

:EXIT 
exit

rem ũ�� �ϸ�ũ �߰� ���
rem %UserProfile%\AppData\Local\Microsoft\Edge\User Data\Default