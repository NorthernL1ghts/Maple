@echo off
echo Running SandboxApp...
echo.

REM Check if Python is available
python --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Python is not installed or not in PATH
    echo Please install Python and try again.
    pause
    exit /b 1
)

REM Check if SandboxApp.py exists
if not exist "Sandbox\src\SandboxApp.py" (
    echo ERROR: SandboxApp.py not found
    echo Please run Scripts\build-maple-framework.bat first to create the application.
    pause
    exit /b 1
)

REM Check if Application.py exists
if not exist "Maple\src\Maple\Application.py" (
    echo ERROR: Maple framework not found
    echo Please run Scripts\build-maple-framework.bat first to create the framework.
    pause
    exit /b 1
)

echo Starting SandboxApp...
echo.

REM Run the SandboxApp
python "Sandbox\src\SandboxApp.py"

echo.
echo SandboxApp finished.
pause 