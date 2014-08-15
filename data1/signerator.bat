
@Echo off
cls
ECHO.
ECHO.
ECHO You should ensure your SET PATH commands are set up already to access 
ECHO the keytool, ant, jarsigner, and zipalign executables
ECHO.
ECHO To use this batch:
ECHO Please Export Android Project from within processing. (Ctrl+Shift+E)
ECHO.
ECHO This batch file should then be ran from the sketch directory
ECHO.
ECHO The current directory is:
ECHO.
ECHO %~dp0
ECHO.
ECHO.
Pause
CLS
ECHO.
ECHO.
set /p varSketchName="Please eneter the name of your sketch:"
ECHO.
set /p varSketchAlias="Please enter an Alias for your sketch:"
ECHO.
ECHO.
ECHO Generating key file or verifying key if one exists
ECHO.
ECHO keytool -genkey -v -keystore %~dp0android\%varSketchName%-release-key.keystore -alias %varSketchAlias% -keyalg RSA -keysize 2048 -validity 10000
pause
keytool -genkey -v -keystore %~dp0android\%varSketchName%-release-key.keystore -alias %varSketchAlias% -keyalg RSA -keysize 2048 -validity 10000
ECHO.
ECHO.
ECHO Now we will create the .APK file using ANT
ECHO ant release
pause
cd android
call ant release
ECHO.
ECHO.
cd..
ECHO Signing APK with your secret key to prepare for release
ECHO.
ECHO jarsigner -verbose -keystore %~dp0android\%varSketchName%-release-key.keystore %~dp0android\bin\%varSketchName%-release-unsigned.apk %varSketchAlias%
pause
call jarsigner -verbose -keystore %~dp0android\%varSketchName%-release-key.keystore %~dp0android\bin\%varSketchName%-release-unsigned.apk %varSketchAlias%
ECHO.
ECHO.
ECHO Verifying Signed APK
ECHO.
ECHO jarsigner -verify %~dp0android\bin\%varSketchName%-release-unsigned.apk
pause
call jarsigner -verify %~dp0android\bin\%varSketchName%-release-unsigned.apk
ECHO.
ECHO.
ECHO Creating folder \android\SignedAPK to store final output
md SignedAPK
ECHO.
ECHO.
set /p varSignedAppName="Please enter name for final signed apk (w/o .apk extension): "
ECHO.
ECHO.
ECHO Running zipalign on final APK
ECHO.
ECHO zipalign -v 4 %~dp0android\bin\%varSketchName%-release-unsigned.apk %~dp0SignedAPK\%varSignedAppName%.apk
pause
call zipalign -v 4 %~dp0android\bin\%varSketchName%-release-unsigned.apk %~dp0SignedAPK\%varSignedAppName%.apk
ECHO.
ECHO.
ECHO Congradulations, you now have an app exported to 
ECHO.
ECHO %~dp0android\SignedAPK\%varSignedAppName%.apk
pause
