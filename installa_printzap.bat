@echo off
setlocal enabledelayedexpansion
title Installazione Rapida di PrintZap
color 0B

echo.
echo  ==============================================================
echo                   INSTALLAZIONE DI PRINTZAP
echo             Ricezione e Stampa WhatsApp / Email
echo  ==============================================================
echo.

set "TARGET_DIR=%LOCALAPPDATA%\PrintZap"
set "TEMP_ZIP=%TEMP%\PrintZap_setup.zip"
set "VERSION_URL=https://raw.githubusercontent.com/alfaomega-dev/cartoleria-whatsapp-updates/main/version.json"

echo  [1/4] Ricerca ultima versione disponibile...
for /f "usebackq tokens=*" %%A in (`powershell -NoProfile -Command "(Invoke-RestMethod -Uri '%VERSION_URL%').zipUrl" 2^>nul`) do (
    set "ZIP_URL=%%A"
)

if "%ZIP_URL%"=="" (
    set "ZIP_URL=https://raw.githubusercontent.com/alfaomega-dev/cartoleria-whatsapp-updates/main/releases/update-1.1.16.zip"
)

echo.
echo  [2/4] Download pacchetto applicativo in corso con curl...
echo  URL: !ZIP_URL!
curl -L -# "!ZIP_URL!" -o "%TEMP_ZIP%"

if not exist "%TEMP_ZIP%" (
    echo.
    echo  [ERRORE] Impossibile completare il download di PrintZap.
    echo  Verifica che il PC sia connesso a Internet e riprova.
    echo.
    pause
    exit /b 1
)

echo.
echo  [3/4] Installazione dei file in:
echo  %TARGET_DIR%
if not exist "%TARGET_DIR%" mkdir "%TARGET_DIR%"

tar -xf "%TEMP_ZIP%" -C "%TARGET_DIR%" 2>nul
if errorlevel 1 (
    powershell -NoProfile -Command "Expand-Archive -Path '%TEMP_ZIP%' -DestinationPath '%TARGET_DIR%' -Force"
)
del /f /q "%TEMP_ZIP%" >nul 2>&1

echo.
echo  [4/4] Configurazione collegamenti Desktop e Menu Start...
powershell -NoProfile -Command "$ws = New-Object -ComObject WScript.Shell; $s = $ws.CreateShortcut([Environment]::GetFolderPath('Desktop') + '\PrintZap.lnk'); $s.TargetPath = '%TARGET_DIR%\PrintZap.exe'; $s.WorkingDirectory = '%TARGET_DIR%'; $s.Save()" >nul 2>&1
powershell -NoProfile -Command "$ws = New-Object -ComObject WScript.Shell; $s = $ws.CreateShortcut([Environment]::GetFolderPath('Programs') + '\PrintZap.lnk'); $s.TargetPath = '%TARGET_DIR%\PrintZap.exe'; $s.WorkingDirectory = '%TARGET_DIR%'; $s.Save()" >nul 2>&1

echo.
echo  ==============================================================
echo     INSTALLAZIONE COMPLETATA CON SUCCESSO!
echo  ==============================================================
echo.
echo  Avvio di PrintZap in corso...
start "" "%TARGET_DIR%\PrintZap.exe"
timeout /t 3 >nul
exit /b 0
