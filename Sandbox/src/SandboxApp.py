"""
Sandbox Application

This is a sample application that demonstrates how to use the Maple framework.
"""

# Import local Utility to configure the path
from Utility import ConfigureMaplePath

# Configure the path using local Utility
ConfigureMaplePath()

# Now import Application from Maple
from Maple.Application import Application


class SandboxApp:
    """
    Sample application that demonstrates the Maple framework.
    
    This class shows how to use the Application base class.
    """
    
    def __init__(self):
        """Initialize the SandboxApp."""
        self.App = Application.CreateApplication()
    
    def Run(self):
        """Run the sandbox application."""
        print("Starting SandboxApp...")
        self.App.Run()


if __name__ == "__main__":
    # Create and run the application
    sandbox = SandboxApp()
    sandbox.Run() 