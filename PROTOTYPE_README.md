# FS25 Native VR — Windows build source and stereo diagnostic prototype

This ZIP is **source code, not an installer**. It is an experimental prototype derived from the MIT-licensed FS25VR project (original copyright and notices preserved). It includes the C++ OpenXR/D3D12 bridge, the FS25 Lua mod, and a GitHub Actions workflow that builds the Windows files without requiring Visual Studio on the user's computer.

## Build and install

1. Upload the contents of this folder to the existing `FS25-NativeVR` GitHub repository, including `.github/workflows/build-windows.yml`.
2. In GitHub open **Actions** → **Build Windows VR prototype** → **Run workflow**. A push to `main` also starts the build.
3. When the workflow succeeds, download the `FS25-NativeVR-Windows-prototype` artifact ZIP and extract it.
4. Run `INSTALL.bat` from the extracted package. It installs `dinput8.dll`, `openxr_loader.dll`, and `fs25vr.ini` into the game's `x64` folder and `FS25_VR.zip` into the mods folder.
5. Start Meta Horizon Link, make it the active OpenXR runtime, connect the Quest 3, then start FS25 and enable **VR (OpenXR, stereoscopic 6DOF)** for the save.
6. Run `CAPTURE_STEREO_PAIR.cmd` from the game's `x64` folder to save the diagnostic eye images.

The build package is experimental. Test it on a separate copy of the game install or keep a backup so it can be removed quickly with `UNINSTALL.bat`.

## Limitations

The project currently inherits FS25VR's alternate-eye renderer, including the stereo-alignment issue under investigation. The diagnostic build enables `profile=1` and `debugLog=1` and packages the OpenXR loader beside the bridge DLL. CI requires GitHub-hosted Windows runners and network dependency downloads; the first build can still reveal compiler or package errors that need correction.
