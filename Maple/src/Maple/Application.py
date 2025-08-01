"""
Maple Core Application Framework

This module provides the core Application class that serves as the foundation
for all Maple-based applications.
"""


class Application:
    """
    Base Application class for Maple framework.
    
    This is the core class that all Maple applications should inherit from.
    """
    
    def __init__(self):
        """Initialize the application."""
        self.ApplicationRunning = False
    
    @staticmethod
    def CreateApplication():
        """
        Create a new application instance.
        
        Returns:
            Application: A new application instance
        """
        return Application()
    
    def Run(self):
        """Run the application."""
        self.ApplicationRunning = True
        print("Application is running...")
        
        # Run forever
        while self.ApplicationRunning:
            pass 