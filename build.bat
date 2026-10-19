@echo off
rem Local build requires Visual Studio 2022+ with C++ desktop workload, CMake, Ninja,
rem and the OpenXR SDK unpacked into third_party\openxr (see README.md).
setlocal
cd /d "%~dp0"
echo.
echo ============================================================
echo  FS25 NativeVR - Windows build
echo ============================================================
echo.
set "VCVARS="
set "VSWHERE=%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"
if exist "%VSWHERE%" (
    for /f "usebackq delims=" %%i in (`"%VSWHERE%" -latest -prerelease -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath`) do set "VCVARS=%%i\VC\Auxiliary\Build\vcvars64.bat"
)
if not exist "%VCVARS%" (
    echo ERROR: Visual Studio C++ tools were not found.
    echo Install Visual Studio 2022 or later with the "Desktop development with C++" workload.
    echo.
    echo BUILD STOPPED.
    pause
    exit /b 1
)
where cmake >nul 2>&1
if errorlevel 1 (
    echo ERROR: CMake was not found. Install CMake 3.20 or later and add it to PATH.
    echo.
    echo BUILD STOPPED.
    pause
    exit /b 1
)
where ninja >nul 2>&1
if errorlevel 1 (
    echo ERROR: Ninja was not found. Install Ninja and add it to PATH.
    echo.
    echo BUILD STOPPED.
    pause
    exit /b 1
)
if not exist "%~dp0third_party\openxr" (
    echo ERROR: The OpenXR SDK is missing from third_party\openxr.
    echo Follow the "Building from source" steps in README.md, then run this again.
    echo.
    echo BUILD STOPPED.
    pause
    exit /b 1
)
echo Initializing the Visual Studio compiler...
call "%VCVARS%"
if errorlevel 1 (
    echo ERROR: Visual Studio compiler initialization failed.
    echo.
    echo BUILD STOPPED.
    pause
    exit /b 1
)
echo.
echo Configuring the project...
cmake -S "%~dp0." -B "%~dp0build" -G Ninja -DCMAKE_BUILD_TYPE=RelWithDebInfo
if errorlevel 1 (
    echo ERROR: CMake configuration failed.
    echo.
    echo BUILD STOPPED.
    pause
    exit /b 1
)
echo.
echo Compiling the bridge...
cmake --build "%~dp0build"
if errorlevel 1 (
    echo ERROR: Compilation failed.
    echo.
    echo BUILD STOPPED.
    pause
    exit /b 1
)
if not exist "%~dp0build\dinput8.dll" (
    echo ERROR: Build finished without producing build\dinput8.dll.
    echo.
    echo BUILD STOPPED.
    pause
    exit /b 1
)
echo.
echo BUILD SUCCEEDED: %~dp0build\dinput8.dll
pause
exit /b 0
