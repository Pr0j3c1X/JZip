::���Ŀǰ״̬
ftype JFsoft.Jzip | findstr "^JFsoft.Jzip" >nul 2>nul && set "tips.FileAssoc=��" || set "tips.FileAssoc=��"

::������
if "%1"=="-on" call :on
if "%1"=="-off" call :off
if /i "%1"=="-reon" (
	if "%�ļ�����%"=="y" call :on
)
if "%1"=="-switch" (
	if "%tips.FileAssoc%"=="��" call :off
	if "%tips.FileAssoc%"=="��" call :on
)
goto :EOF


:on
net session >nul 2>nul && (
	for %%a in (%jzip.spt.open%) do 1>nul assoc .%%a=JFsoft.Jzip
	1>nul ftype JFsoft.Jzip="%path.jzip.launcher%" %%1
)
net session >nul 2>nul || (
	1> "%dir.jzip.temp%\getadmin.vbs" (
		echo.Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/q /c for %%a in (%jzip.spt.open%) do assoc .%%a=JFsoft.Jzip& ftype JFsoft.Jzip=""%path.jzip.launcher%"" %%1", "", "runas", 1
		echo.Set fso = CreateObject^("Scripting.FileSystemObject"^) : fso.DeleteFile^(WScript.ScriptFullName^)
		)
	) && "%dir.jzip.temp%\getadmin.vbs"
)
reg add "HKEY_CURRENT_USER\Software\JFsoft.Jzip" /t REG_SZ /v "�ļ�����" /d "y" /f >nul
goto :EOF


:off
net session >nul 2>nul && (
	for %%a in (%jzip.spt.open%) do 1>nul assoc .%%a=
	1>nul ftype JFsoft.Jzip=
)
net session >nul 2>nul || (
	1> "%dir.jzip.temp%\getadmin.vbs" (
		echo.Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/q /c for %%a in (%jzip.spt.open%) do assoc .%%a=& ftype JFsoft.Jzip=", "", "runas", 1
		echo.Set fso = CreateObject^("Scripting.FileSystemObject"^) : fso.DeleteFile^(WScript.ScriptFullName^)
		)
	) && "%dir.jzip.temp%\getadmin.vbs"
)
reg add "HKEY_CURRENT_USER\Software\JFsoft.Jzip" /t REG_SZ /v "�ļ�����" /d "" /f >nul
goto :EOF
