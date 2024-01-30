@REM 명령어 출력 삭제
@echo off  
@REM UTF-8 설정
chcp 65001

@REM -- 1.관리자 권한 실행 add the following to the top of your bat file--
:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------


@REM 2.현재 디렉토리에서 jdk디렉토리 찾아서 있으면 JAVA_HOME 시스템 변수에 값 할당
for /f "delims=" %%i in ('dir /ad /b *jdk*') do set JDK_DIR_NAME=%%i
:break

if exist "%JDK_DIR_NAME%" (
    echo "Java Directory Exist"
) else (
    echo "Java Directory Not Exist"
)
set JAVA_PATH=%cd%\%JDK_DIR_NAME%

@REM '-m' 옵션은 시스템 변수로 할당 할때 사용, 사용자 변수로 넣으려면 '-m' 제거
setx JAVA_HOME %JAVA_PATH% -m
@echo %JAVA_PATH%

@REM 3.set Path 명령어로 'jdk' 문구가 있는 지 확인

set Path | findstr /i "jdkx"

if "%errorlevel%" == "0" (
    @echo "JDK가 Path에 포함되어 있습니다."
) else (
    @echo "JDK가 Path에 포홤되어 있지 않습니다."
) 

@REM 스크립트 실행 후 cmd창이 자동으로 종료 되는 것을 막기 위한 명령어
pause