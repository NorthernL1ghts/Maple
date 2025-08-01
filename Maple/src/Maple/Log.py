import logging
from pathlib import Path
from rich.console import Console
from rich.logging import RichHandler

class Log:
    """Logging class for the Maple framework."""
    
    s_CoreLogger = None
    s_ClientLogger = None

    @staticmethod
    def Init(logFile="logs/Maple.log"):
        # Custom TRACE level below DEBUG
        TRACE_LEVEL = 5
        logging.addLevelName(TRACE_LEVEL, "TRACE")

        def Trace(self, message, *args, **kwargs):
            if self.isEnabledFor(TRACE_LEVEL):
                self._log(TRACE_LEVEL, message, args, **kwargs)
        logging.Logger.Trace = Trace

        # Ensure logs directory exists
        Path("logs").mkdir(parents=True, exist_ok=True)

        # Console handler with colors
        consoleHandler = RichHandler(
            level=TRACE_LEVEL,
            console=Console(stderr=True),
            markup=True,
            rich_tracebacks=True,
            log_time_format="[%H:%M:%S]"
        )

        # File handler
        fileHandler = logging.FileHandler(logFile, mode="w")
        fileFormatter = logging.Formatter("[%(asctime)s] [%(name)s] %(levelname)s: %(message)s", datefmt="%H:%M:%S")
        fileHandler.setFormatter(fileFormatter)

        # Core Logger
        Log.s_CoreLogger = logging.getLogger("MAPLE")
        Log.s_CoreLogger.setLevel(TRACE_LEVEL)
        Log.s_CoreLogger.addHandler(consoleHandler)
        Log.s_CoreLogger.addHandler(fileHandler)
        Log.s_CoreLogger.propagate = False

        # Client Logger
        Log.s_ClientLogger = logging.getLogger("APP")
        Log.s_ClientLogger.setLevel(TRACE_LEVEL)
        Log.s_ClientLogger.addHandler(consoleHandler)
        Log.s_ClientLogger.addHandler(fileHandler)
        Log.s_ClientLogger.propagate = False

    @staticmethod
    def GetCoreLogger():
        return Log.s_CoreLogger

    @staticmethod
    def GetCoreLogger():
        return Log.s_ClientLogger

# Macro-style shorthand (aliases)
MAPLE_CORE_TRACE = lambda msg, *args: Log.GetCoreLogger().Trace(msg, *args)
MAPLE_CORE_INFO = lambda msg, *args: Log.GetCoreLogger().info(msg, *args)
MAPLE_CORE_WARN = lambda msg, *args: Log.GetCoreLogger().warning(msg, *args)
MAPLE_CORE_ERROR = lambda msg, *args: Log.GetCoreLogger().error(msg, *args)
MAPLE_CORE_FATAL = lambda msg, *args: Log.GetCoreLogger().fatal(msg, *args)

MAPLE_TRACE = lambda msg, *args: Log.GetCoreLogger().Trace(msg, *args)
MAPLE_INFO = lambda msg, *args: Log.GetCoreLogger().info(msg, *args)
MAPLE_WARN = lambda msg, *args: Log.GetCoreLogger().warning(msg, *args)
MAPLE_ERROR = lambda msg, *args: Log.GetCoreLogger().error(msg, *args)
MAPLE_FATAL = lambda msg, *args: Log.GetCoreLogger().fatal(msg, *args)