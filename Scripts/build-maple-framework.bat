@echo off
echo Building Maple Framework...
echo.

REM Create necessary directories if they don't exist
if not exist "Maple\src" mkdir "Maple\src"
if not exist "Maple\src\Maple" mkdir "Maple\src\Maple"
if not exist "Sandbox\src" mkdir "Sandbox\src"

REM Create __init__.py files if they don't exist
if not exist "Maple\src\__init__.py" (
    echo Creating Maple\src\__init__.py...
    echo """ > "Maple\src\__init__.py"
    echo Maple Source Package >> "Maple\src\__init__.py"
    echo. >> "Maple\src\__init__.py"
    echo This package contains the Maple framework source code. >> "Maple\src\__init__.py"
    echo """ >> "Maple\src\__init__.py"
    echo. >> "Maple\src\__init__.py"
    echo from .Maple import Application >> "Maple\src\__init__.py"
    echo. >> "Maple\src\__init__.py"
    echo __all__ = ["Application"] >> "Maple\src\__init__.py"
)

if not exist "Maple\src\Maple\__init__.py" (
    echo Creating Maple\src\Maple\__init__.py...
    echo """ > "Maple\src\Maple\__init__.py"
    echo Maple Core Framework >> "Maple\src\Maple\__init__.py"
    echo. >> "Maple\src\Maple\__init__.py"
    echo A universal application framework for Python projects. >> "Maple\src\Maple\__init__.py"
    echo """ >> "Maple\src\Maple\__init__.py"
    echo. >> "Maple\src\Maple\__init__.py"
    echo from .Application import Application >> "Maple\src\Maple\__init__.py"
    echo. >> "Maple\src\Maple\__init__.py"
    echo __version__ = "1.0.0" >> "Maple\src\Maple\__init__.py"
    echo __all__ = ["Application"] >> "Maple\src\Maple\__init__.py"
)

if not exist "Sandbox\src\__init__.py" (
    echo Creating Sandbox\src\__init__.py...
    echo """ > "Sandbox\src\__init__.py"
    echo Sandbox Application Package >> "Sandbox\src\__init__.py"
    echo. >> "Sandbox\src\__init__.py"
    echo A sample application demonstrating the Maple framework. >> "Sandbox\src\__init__.py"
    echo """ >> "Sandbox\src\__init__.py"
    echo. >> "Sandbox\src\__init__.py"
    echo from .SandboxApp import SandboxApp >> "Sandbox\src\__init__.py"
    echo. >> "Sandbox\src\__init__.py"
    echo __all__ = ["SandboxApp"] >> "Sandbox\src\__init__.py"
)

REM Check if Python is available
python --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Python is not installed or not in PATH
    echo Please install Python and try again.
    pause
    exit /b 1
)

echo Python found: 
python --version

REM Install dependencies if requirements.txt exists
if exist "requirements.txt" (
    echo Installing dependencies...
    pip install -r requirements.txt
) else (
    echo No requirements.txt found, skipping dependency installation.
)

REM Create a simple test to verify the build
echo Testing build...
python -c "import sys; sys.path.insert(0, 'Maple/src'); from Maple.Application import Application; print('✓ Maple framework imported successfully')"

if errorlevel 1 (
    echo ERROR: Build test failed
    pause
    exit /b 1
)

echo.
echo ✓ Build completed successfully!
echo.
echo To run the SandboxApp, use: Scripts\run-sandbox-app.bat
echo.
pause 