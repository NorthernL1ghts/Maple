#!/bin/bash

echo "Building Maple Framework..."
echo

# Create necessary directories if they don't exist
mkdir -p Maple/src/Maple
mkdir -p Sandbox/src

# Create __init__.py files if they don't exist
if [ ! -f "Maple/src/__init__.py" ]; then
    echo "Creating Maple/src/__init__.py..."
    cat > "Maple/src/__init__.py" << 'EOF'
"""
Maple Source Package

This package contains the Maple framework source code.
"""

from .Maple import Application

__all__ = ["Application"]
EOF
fi

if [ ! -f "Maple/src/Maple/__init__.py" ]; then
    echo "Creating Maple/src/Maple/__init__.py..."
    cat > "Maple/src/Maple/__init__.py" << 'EOF'
"""
Maple Core Framework

A universal application framework for Python projects.
"""

from .Application import Application

__version__ = "1.0.0"
__all__ = ["Application"]
EOF
fi

if [ ! -f "Sandbox/src/__init__.py" ]; then
    echo "Creating Sandbox/src/__init__.py..."
    cat > "Sandbox/src/__init__.py" << 'EOF'
"""
Sandbox Application Package

A sample application demonstrating the Maple framework.
"""

from .SandboxApp import SandboxApp

__all__ = ["SandboxApp"]
EOF
fi

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

echo "Python found:"
$PYTHON_CMD --version

# Install dependencies if requirements.txt exists
if [ -f "requirements.txt" ]; then
    echo "Installing dependencies..."
    $PYTHON_CMD -m pip install -r requirements.txt
else
    echo "No requirements.txt found, skipping dependency installation."
fi

# Create a simple test to verify the build
echo "Testing build..."
$PYTHON_CMD -c "import sys; sys.path.insert(0, 'Maple/src'); from Maple.Application import Application; print('✓ Maple framework imported successfully')"

if [ $? -ne 0 ]; then
    echo "ERROR: Build test failed"
    exit 1
fi

echo
echo "✓ Build completed successfully!"
echo
echo "To run the SandboxApp, use: ./Scripts/run-sandbox-app.sh"
echo 