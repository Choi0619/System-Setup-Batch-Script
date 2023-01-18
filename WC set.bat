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
title À§´õ½ºÄÄÇ»ÅÍ ¸¶½ºÅÍ

:main
cls
echo.
echo.
echo		[44;37m[À§´õ½ºÄÄÇ»ÅÍ ¸¶½ºÅÍ ¼¼ÆÃ][0m
echo.
echo		1. À§´õ½ºÄÄÇ»ÅÍ ¼¼ÆÃ ÇÑ¹ø¿¡ Àû¿ëÇÏ±â (2~4¹ø ³»¿ë)
echo.
echo		2. À§´õ½ºÄÄÇ»ÅÍ ¹è°æÈ­¸é¸¸ Àû¿ëÇÏ±â
echo.
echo		3. À§´õ½ºÄÄÇ»ÅÍ OEM ·Î°í Ãß°¡ÇÏ±â
echo.
echo		4. À§´õ½ºÄÄÇ»ÅÍ ¸µÅ©/ºÏ¸¶Å© Ãß°¡ÇÏ±â
echo.
echo		5. À©µµ¿ì µğÆæ´õ ²ô±â / ÄÑ±â
echo.
echo		6. ¿øµå¶óÀÌºê(OneDrive) Á¦°Å
echo.
echo		7. À©µµ¿ì ÀÚµ¿ ¾÷µ¥ÀÌÆ® Â÷´Ü / È°¼ºÈ­
echo.
echo		8. Administrator ÃÖ°í °ü¸®ÀÚ °èÁ¤ È°¼ºÈ­ / ºñÈ°¼ºÈ­
echo.
echo		9. Á¾·áÇÏ±â
echo.

echo.
set menu=
set /p menu=¿øÇÏ½Ã´Â ÀÛ¾÷ ¹øÈ£¸¦ ÀÔ·Â ÈÄ ¿£ÅÍ(Enter)¸¦ ´­·¯ÁÖ¼¼¿ä : 
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
copy "%~dp0\set\°£ÆíÇÑ ¿ø°İÁö¿ø - ÇïÇÁÀ¯.url" "C:\Users\%USERNAME%\Favorites\Links"
copy "%~dp0\set\À§´õ½ºÄÄÇ»ÅÍ.url" "C:\Users\%USERNAME%\Favorites\Links"
reg add "HKCU\Software\Microsoft\Internet Explorer\MINIE" /v AlwaysShowMenus /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Internet Explorer\MINIE" /v LinksBandEnabled /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Internet Explorer\MINIE" /v CommandBarEnabled /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Internet Explorer\MINIE" /v ShowStatusBar /t REG_DWORD /d 1 /f
copy "%~dp0\set\Bookmarks" "C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\User Data\Default"


echo.
pause
goto main

:oem
rem oem ·¹Áö½ºÅä¸® Ãß°¡ ::::
regedit.exe /s "%~dp0\set\oem Withus.reg" /f

rem oem ·Î°í Ãß°¡ ::::
copy "%~dp0\set\OEMLOGO.bmp" "c:\windows\system32\oobe" /y

echo.
pause
goto main

:background
rem À§´õ½º ¹è°æÈ­¸é µî·Ï ::::
copy "%~dp0\set\withusbackground.jpg" "C:\Windows\System32" /y
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d  wallpaper_path /f 
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d C:\Windows\System32\withusbackground.jpg /f  
RUNDLL32.EXE user32.dll, UpdatePerUserSystemParameters ,1 ,True


echo.
pause
goto main


:links
rem À§´õ½º ¸µÅ©/ºÏ¸¶Å© Ãß°¡ ::::
copy "%~dp0\set\Google.url" "C:\Users\%USERNAME%\Favorites\Links"
copy "%~dp0\set\NAVER.url" "C:\Users\%USERNAME%\Favorites\Links"
copy "%~dp0\set\YouTube.url" "C:\Users\%USERNAME%\Favorites\Links"
copy "%~dp0\set\°£ÆíÇÑ ¿ø°İÁö¿ø - ÇïÇÁÀ¯.url" "C:\Users\%USERNAME%\Favorites\Links"
copy "%~dp0\set\À§´õ½ºÄÄÇ»ÅÍ.url" "C:\Users\%USERNAME%\Favorites\Links"
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
echo		[44;37m[ ¿øµå¶óÀÌºê(OneDrive) Á¦°ÅÇÏ±â ][0m
echo.
set x86="%SYSTEMROOT%\System32\OneDriveSetup.exe"
set x64="%SYSTEMROOT%\SysWOW64\OneDriveSetup.exe"
echo.
echo OneDrive Á¦°Å ÁØºñÁß...
echo.
taskkill /f /im OneDrive.exe > NUL 2>&1
ping 127.0.0.1 -n 5 > NUL 2>&1
echo OneDrive °ü·Ã ÇÁ·Î¼¼½º¸¦ ´İ´ÂÁß...
echo.
if exist %x64% (
%x64% /uninstall
) else (
%x86% /uninstall
)
ping 127.0.0.1 -n 5 > NUL 2>&1
echo OneDrive °ü·Ã ÆÄÀÏ Á¦°ÅÁß...
echo.
rd "%USERPROFILE%\OneDrive" /Q /S > NUL 2>&1
rd "C:\OneDriveTemp" /Q /S > NUL 2>&1
rd "%LOCALAPPDATA%\Microsoft\OneDrive" /Q /S > NUL 2>&1
rd "%PROGRAMDATA%\Microsoft OneDrive" /Q /S > NUL 2>&1 
echo OneDrive °ü·Ã ·¹Áö½ºÆ®¸® Á¤º¸ Á¦°ÅÁß...
echo.
REG DELETE "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f > NUL 2>&1
REG DELETE "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f > NUL 2>&1
echo.
echo OneDrive¸¦ Á¤»óÀûÀ¸·Î Á¦°ÅÇÏ¿´½À´Ï´Ù!
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
echo		[44;37m[ ÃÖ°í °ü¸®ÀÚ administrator °èÁ¤ °ü¸®  ][0m
echo.
echo.
echo		1. Administrator ÃÖ°í °ü¸®ÀÚ °èÁ¤ È°¼ºÈ­ ÇÏ±â
echo.
echo		2. È°¼ºÈ­µÈ Administrator ÃÖ°í °ü¸®ÀÚ °èÁ¤ ºñÈ°¼ºÈ­ ÇÏ±â
echo.
echo		3. ¸ÅÀÎ ¸Ş´º·Î °¡±â
echo.
echo.
set menu=
set /p menu=¿øÇÏ½Ã´Â ÀÛ¾÷ ¹øÈ£¸¦ ÀÔ·Â ÈÄ ¿£ÅÍ(Enter)Å°¸¦ ´­·¯ÁÖ¼¼¿ä : 
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
rem rem echo ¼³Á¤ º¯°æ ¹× Á¤¸®°¡ ¿Ï·áµÇ¾ú½À´Ï´Ù.

:EXIT 
exit

rem Å©·Ò ºÏ¸¶Å© Ãß°¡ °æ·Î
rem %UserProfile%\AppData\Local\Microsoft\Edge\User Data\Default