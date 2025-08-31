@echo off
setlocal enabledelayedexpansion

REM ==============================
REM Win-GenerateProject.bat
REM ==============================

REM Create build folder if it doesn't exist
if not exist build (
    mkdir build
)

REM Move into build folder
cd build

REM Run CMake configure with VS 2022 x64 generator
cmake -G "Visual Studio 17 2022" -A x64 ..

REM Build the solution (Debug config by default)
cmake --build . --config Debug

cd ..
echo.
echo ==============================
echo   Maple.sln generated!
echo   Open build/Maple.sln in Visual Studio
echo ==============================
pause