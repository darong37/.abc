rem @ECHO OFF
rem 
rem assignToExe options
rem   Visiblity   : Invisible application
rem   Working dir : current
rem 
call C:\Users\JKK0544\.abc\exe\_init.bat

set CALLDIR=%~dp1

set fn=%~nx1
"%perlExe%" -e "print '%fn%'" | clip

set MINLOGDIR=%LOGSBASE%\%dt08%

IF not EXIST %MINLOGDIR% (
  mkdir %MINLOGDIR%
)
set MINLOG=%MINLOGDIR%\local_%tm06%_bash.log

%mttyExe% -t local-bash -l %MINLOG% /bin/bash --login -i

