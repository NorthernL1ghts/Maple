#!/bin/bash

echo "Running SandboxApp..."
echo

# Check if Python is available
if ! command -v python3 &> /dev/null; then
    if ! command -v python &> /dev/null; then
        echo "ERROR: Python is not installed or not in PATH"
        echo "Please install Python and try again."
        exit 1
    else
        PYTHON_CMD="python"
    fi
else
    PYTHON_CMD="python3"
fi

# Check if SandboxApp.py exists
if [ ! -f "Sandbox/src/SandboxApp.py" ]; then
    echo "ERROR: SandboxApp.py not found"
    echo "Please run ./Scripts/build-maple-framework.sh first to create the application."
    exit 1
fi

# Check if Application.py exists
if [ ! -f "Maple/src/Maple/Application.py" ]; then
    echo "ERROR: Maple framework not found"
    echo "Please run ./Scripts/build-maple-framework.sh first to create the framework."
    exit 1
fi

echo "Starting SandboxApp..."
echo

# Run the SandboxApp
$PYTHON_CMD "Sandbox/src/SandboxApp.py"

echo
echo "SandboxApp finished." 