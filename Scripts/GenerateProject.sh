#!/bin/bash

# ==============================
# Win-GenerateProject.sh
# ==============================

# Exit on any error
set -e

# Create build folder if it doesn't exist
if [ ! -d "build" ]; then
    mkdir build
fi

# Move into build folder
cd build

# Run CMake configure with Visual Studio 2022 x64 generator
cmake -G "Visual Studio 17 2022" -A x64 ..

# Build the solution (Debug config by default)
cmake --build . --config Debug

cd ..

echo
echo "=============================="
echo "  Maple.sln generated!"
echo "  Open build/Maple.sln in Visual Studio"
echo "=============================="
read -p "Press any key to continue . . ."