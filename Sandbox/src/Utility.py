"""
Sandbox Utility Module

This module provides utility functions for the Sandbox application,
including path configuration for the Maple framework.
"""

import sys
from pathlib import Path


def ConfigureMaplePath():
    """
    Configure the Python path to include the Maple framework.
    
    This function automatically adds the Maple/src directory to sys.path
    so that the Maple framework can be imported from the Sandbox.
    """
    # Get the current file's directory
    current_file = Path(__file__)
    
    # Navigate to the Maple/src directory
    maple_src_path = current_file.parent.parent.parent / "Maple" / "src"
    
    # Convert to string and add to sys.path if not already there
    maple_src_str = str(maple_src_path)
    
    if maple_src_str not in sys.path:
        sys.path.insert(0, maple_src_str)
        return True
    
    return False


def GetMaplePath():
    """
    Get the path to the Maple framework.
    
    Returns:
        str: The path to the Maple/src directory
    """
    current_file = Path(__file__)
    maple_src_path = current_file.parent.parent.parent / "Maple" / "src"
    return str(maple_src_path)


# Auto-configure the path when this module is imported
ConfigureMaplePath() 