# Maple

![Maple's LOGO](Resources/Branding/LOGO.png)

A universal application framework and template library for Python projects.

## Overview

Maple provides a comprehensive foundation for building scalable applications in Python. The framework offers a clean, minimal architecture designed for rapid development and easy extensibility across various application types.

Maple is designed to be a lightweight, yet powerful framework that simplifies application development by providing a standardized structure and common utilities. It's perfect for developers who want to focus on their application logic rather than boilerplate code.

## Features

- **Minimalist Application Framework**: Streamlined Application class with intuitive lifecycle management
- **Cross-Platform Compatibility**: Native support for Windows, macOS, and Linux environments
- **Simplified Import System**: Clean `from Maple.Application import Application` syntax with automatic path configuration
- **Automated Build System**: Streamlined setup process with platform-specific scripts
- **Utility Integration**: Built-in path configuration and framework utilities
- **PascalCase Naming**: Consistent naming conventions throughout the codebase

## Quick Start

### Prerequisites

- Python 3.7 or higher
- pip (Python package installer)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/NorthernL1ghts/Maple
   cd Maple
   ```

2. **Build the framework**
   
   **Windows:**
   ```cmd
   Scripts\build-maple-framework.bat
   ```
   
   **Unix/Linux/macOS:**
   ```bash
   ./Scripts/build-maple-framework.sh
   ```

3. **Run the sandbox application**
   
   **Windows:**
   ```cmd
   Scripts\run-sandbox-app.bat
   ```
   
   **Unix/Linux/macOS:**
   ```bash
   ./Scripts/run-sandbox-app.sh
   ```

## Usage

### Basic Application

```python
from Maple.Application import Application

# Create a new application instance
app = Application.CreateApplication()

# Execute the application
app.Run()
```

### Custom Application with Utility

```python
# Import local Utility to configure the path
from Utility import ConfigureMaplePath

# Configure the path using local Utility
ConfigureMaplePath()

# Now import Application from Maple
from Maple.Application import Application

class MyApp:
    def __init__(self):
        self.App = Application.CreateApplication()
    
    def Run(self):
        print("Initializing MyApp...")
        self.App.Run()

if __name__ == "__main__":
    my_app = MyApp()
    my_app.Run()
```

## What is Maple?

Maple is a universal application framework that provides:

### Core Components
- **Application Class**: A base class that handles application lifecycle management
- **Utility System**: Path configuration and framework utilities
- **Build System**: Automated setup scripts for different platforms

### Key Benefits
- **Rapid Development**: Get started quickly with minimal boilerplate
- **Consistent Structure**: Standardized application architecture
- **Cross-Platform**: Works seamlessly across different operating systems
- **Extensible**: Easy to extend and customize for specific needs

### Architecture
Maple follows a simple but effective architecture:
1. **Framework Core**: Contains the Application class and core utilities
2. **Application Layer**: Your custom application code
3. **Utility Layer**: Path configuration and helper functions

## Build System

The Maple build system consists of platform-specific scripts that handle:

### Build Scripts
- **Windows**: `Scripts\build-maple-framework.bat`
- **Unix/Linux/macOS**: `Scripts\build-maple-framework.sh`

### What the Build System Does
1. **Directory Creation**: Creates necessary project directories
2. **Package Initialization**: Generates `__init__.py` files
3. **Dependency Management**: Installs required Python packages
4. **Framework Testing**: Verifies the framework is working correctly
5. **Path Configuration**: Sets up proper import paths

### Run Scripts
- **Windows**: `Scripts\run-sandbox-app.bat`
- **Unix/Linux/macOS**: `Scripts\run-sandbox-app.sh`

### What the Run Scripts Do
1. **Environment Check**: Verifies Python installation
2. **File Validation**: Ensures required files exist
3. **Application Execution**: Runs the SandboxApp demonstration

## Dependencies

All libraries can be found in [requirements.txt](requirements.txt).

## Scripts

- **`Scripts/build-maple-framework.bat`**: Windows build script
- **`Scripts/build-maple-framework.sh`**: Unix/Linux/macOS build script
- **`Scripts/run-sandbox-app.bat`**: Windows run script
- **`Scripts/run-sandbox-app.sh`**: Unix/Linux/macOS run script

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
