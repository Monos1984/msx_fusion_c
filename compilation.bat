echo off

rem ===================
rem ** Configuration **
rem =================== 
rem - Nom du programme -
set nom=template

rem - Nom du repertoir de sortie
set sortie=dsk

rem - Nom du repertoir du code source
set adrsource=source

rem - Lien du hex2bin -
set adrhex2bin=..\..\tool\

rem - Lien de a lib -
set adrsdk=..\..\fusionc\

rem - Adresse SDCC -
set adrsdcc=..\..\sdcc\bin\

echo ----------------------------------------------
echo --Projet %nom%
echo ----------------------------------------------
echo ---------------------
echo -- Version de SDCC --
echo ---------------------
%adrsdcc%sdcc -v 



rem ================================
rem ** Compilation des fichiers C **
rem ================================
echo -------------------------------
echo -- Compilation des fichier c --
echo -------------------------------


for %%i in (%adrsource%\*.*) do ( 
echo %%~nxi

%adrsdcc%sdcc -c -mz80 -I%adrsdk%include %adrsource%/%%~nxi
 )

pause
rem =================================
rem ** linkage des fichiers objets **
rem =================================
echo -------------------------------------
echo -- linkage des fichiers rel et lib --
echo -------------------------------------
%adrsdcc%sdcc -o msx.ihx -mz80 --no-std-crt0 --code-loc 0x107 --data-loc 0x0 %adrsdk%rel/crt0_msxdos.rel %adrsdk%lib/fusion.lib *.rel


rem =====================
rem ** Creation de bin **
rem =====================

echo ----------------------------------------
echo -- Creation du fichier binaire et com --
echo ----------------------------------------
%adrhex2bin%hex2bin -e com msx.ihx
copy msx.com %sortie%\%nom%.com /y

echo.
if exist "%sortie%/%nom%.com" echo --- Le fichier %nom%.com vient d'etre genere dans le repertoir %sortie% ---
echo.

pause

echo ---------------
echo -- netoyages --
echo ---------------
del *.com
del *.asm
del *.ihx
del *.lk
del *.lst
del *.map
del *.noi
del *.sym
del *.rel

echo ----------------------------
echo -- lancement de %nom%.com --
echo ----------------------------
Lunch_HB_F700D
pause