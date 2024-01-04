@REM 명령어 출력 삭제
@echo off  
@REM UTF-8 설정
chcp 65001

for /f "delims=" %%i in ('dir /ad /b *jdk*') do set JDK_DIR_NAME=%%i
:break

if exist "%JDK_DIR_NAME%" (
    echo "Java Directory Exist"
) else (
    echo "Java Directory Not Exist"
)

set JDK_DIR=%cd%\%JDK_DIR_NAME%\bin

@echo %JDK_DIR%

@REM 스크립트 실행 후 cmd창이 자동으로 종료 되는 것을 막기 위한 명령어
pause