@ECHO off
ECHO LOADING OpenSees.exe

SET ans=Y


:run_again
	CALL OpenSees.exe frame.tcl
	ECHO Wanna run again? (Y/y or N/n)
	SET /p ans=
	IF "%ans%"=="Y"  (
		GOTO run_again
	)
	IF "%ans%"=="y"  (
		GOTO run_again
	)
@PAUSE