@echo off
setlocal enabledelayedexpansion
title Winget Bulk Installer

:: Re-launch as administrator if not already elevated
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Requesting administrator privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

set "FAILED="

for %%i in (
    McAfee.MCPR
    Malwarebytes.Malwarebytes
    Webroot.SecureAnywhere
    Corsair.iCUE.4
    Corsair.iCUE.3
    WhirlwindFX.SignalRgb
    BinaryMark.BatchImageSplitter
    BinaryMark.BatchPhotoFace
    BinaryMark.BatchImageResizer
    360.360DocProtect
    360.360VirtualVault
    360.360Ent
    360.360Zip
    360.360SE
    360.360GT
    HelmutBuhler.8GadgetPack
    AIVOICE.KURITA
    MoeruAI.AIRI
) do (
    echo.
    echo ==== Installing %%i ====
    winget install -e --id %%i --silent --accept-package-agreements --accept-source-agreements
    if errorlevel 1 set "FAILED=!FAILED! %%i"
)

echo.
echo ==============================
if defined FAILED (
    echo Finished. These packages failed or were not found:
    for %%f in (!FAILED!) do echo   - %%f
) else (
    echo Finished. All packages installed successfully.
)
echo ==============================
pause
