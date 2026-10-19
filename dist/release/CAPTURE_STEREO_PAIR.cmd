@echo off
setlocal
set "trigger=%~dp0x64\fs25vr_dump.txt"
if not exist "%~dp0x64" set "trigger=%~dp0fs25vr_dump.txt"
if exist "%trigger%" (
  echo A capture request is already waiting for the game.
  echo Wait for the current capture to finish, then run this again.
  pause
  exit /b 1
)
type nul > "%trigger%"
echo Capture requested. The bridge will save the next four stereo frames.
echo Keep FS25 open and in the VR camera while the capture completes.
timeout /t 3 /nobreak >nul
endlocal
