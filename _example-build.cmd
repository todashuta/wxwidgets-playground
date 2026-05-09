@echo off

cd %~dp0

call "P:\Apps\Visual Studio 2022 Community\VC\Auxiliary\Build\vcvars64.bat"

set build_dir=.\build

cmake ^
	-B %build_dir% ^
	-G Ninja ^
	-DCMAKE_TOOLCHAIN_FILE="C:\Devel\vcpkg\scripts\buildsystems\vcpkg.cmake" ^
	-DCMAKE_COLOR_DIAGNOSTICS=ON ^
	-DCMAKE_BUILD_TYPE=Release ^
	-DCMAKE_POLICY_VERSION_MINIMUM=3.5
cmake --build %build_dir% -j
pause
