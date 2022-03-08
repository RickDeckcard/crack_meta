CLS
@echo off
if exist "xcopy.txt" del xcopy.txt
if exist "possible_passwords.log" del possible_passwords.log
if exist "metamask.privkeys.txt" del metamask.privkeys.txt
if exist "datos_wallet" del /q datos_wallet
if exist "el_password.txt" del el_password.txt
echo *****************************************************
echo    METAMASK PASSWORD EXTRACTOR BY DECKCARD23
echo *****************************************************
echo                          *
echo COPY METAMASK WALLETS....
xcopy "%localappdata%\Google\Chrome\User Data\Default\Local Extension Settings\nkbihfbeogaeaoehlefnkodbefgpgknn\" "%userprofile%\Desktop\DEMOS\datos_wallet" > xcopy.txt
echo ---------------------------------------
echo 1. Si sabe su password de la billetera.
echo 2. Si no sabe su password.
echo ---------------------------------------
set /p input="Elija opcion 1 o 2: "
if %input%==1 goto 1
if %input%==2 goto 2


:1
set /p id="Introduzca su password: "
echo Extrayendo el vault con la seed codificado.............
python %userprofile%\Desktop\BTCRECOVER\BTCRECOVER_ULTIMATE\btcrecover-master\btcrecover.py --wallet datos_wallet --correct-wallet-password %id% --dump-privkeys metamask.privkeys.txt
echo Decodificando seed de Metamask...............
python %userprofile%\Desktop\BTCRECOVER\BTCRECOVER_ULTIMATE\btcrecover-master\extract-scripts\extract-metamask-vaults.py %userprofile%\Desktop\DEMOS\datos_wallet
type metamask.privkeys.txt
echo *
echo Borrando ficheros temporales........
del xcopy.txt
del possible_passwords.log
del metamask.privkeys.txt
del /q datos_wallet
goto 3


:2
echo START WITH BRUTE FORCE PASSWORD.......
python %userprofile%\Desktop\BTCRECOVER\BTCRECOVER_ULTIMATE\btcrecover-master\btcrecover.py --wallet ./datos_wallet --passwordlist metamask_passwords.txt > el_password.txt
echo THE METAMASK PASSWORD IS
find "Password" el_password.txt
set /p id="Introduzca la contrasena obtenida: "
echo Extrayendo el vault con la seed codificado.............
python %userprofile%\Desktop\BTCRECOVER\BTCRECOVER_ULTIMATE\btcrecover-master\btcrecover.py --wallet datos_wallet --correct-wallet-password %id% --dump-privkeys metamask.privkeys.txt
echo Decodificando seed de Metamask...............
python %userprofile%\Desktop\BTCRECOVER\BTCRECOVER_ULTIMATE\btcrecover-master\extract-scripts\extract-metamask-vaults.py %userprofile%\Desktop\DEMOS\datos_wallet
type metamask.privkeys.txt
echo *
echo *****************
echo *mision cumplida*
echo *****************
echo Borrando ficheros temporales........
del xcopy.txt
del possible_passwords.log
del metamask.privkeys.txt
del /q datos_wallet
del el_password.txt

:3
echo -------------------------------------------
echo Gracias por usar crack_meta
echo Desarrollado por Deckcard23
echo Me puedes seguir en Twitter @rickdeckard23
echo --------------------------------------------