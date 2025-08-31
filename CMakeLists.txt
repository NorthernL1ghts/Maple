cmake_minimum_required(VERSION 3.20)

project(Maple LANGUAGES CXX)

# Only support x64
if(NOT CMAKE_SIZEOF_VOID_P EQUAL 8)
    message(FATAL_ERROR "Only x64 builds are supported.")
endif()

# Set C++20 standard
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Base output directories
set(OUTPUT_DIR ${CMAKE_SOURCE_DIR}/Binaries)
set(INT_DIR ${CMAKE_SOURCE_DIR}/Intermediates)

# ============================
# Maple - Shared Library (DLL)
# ============================
add_library(Maple SHARED
    Maple/src/Maple.h
    Maple/src/Maple/Application.cpp
    Maple/src/Maple/Application.h
    Maple/src/Maple/Core.h
    Maple/src/Maple/EntryPoint.h
)

target_include_directories(Maple PUBLIC
    ${CMAKE_SOURCE_DIR}/Maple/src
)

# Preprocessor definitions
target_compile_definitions(Maple
    PRIVATE MP_BUILD_DLL
    PUBLIC MP_PLATFORM_WINDOWS
)

# Output and intermediate folders for Maple
set_target_properties(Maple PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${OUTPUT_DIR}/$<CONFIG>
    ARCHIVE_OUTPUT_DIRECTORY ${OUTPUT_DIR}/$<CONFIG>
    LIBRARY_OUTPUT_DIRECTORY ${OUTPUT_DIR}/$<CONFIG>
    OBJECT_OUTPUT_DIRECTORY ${INT_DIR}/Maple/$<CONFIG>
    VS_DEBUGGER_WORKING_DIRECTORY ${OUTPUT_DIR}/$<CONFIG>
)

# ============================
# Sandbox - Console Application
# ============================
add_executable(Sandbox
    Sandbox/src/SandboxApp.cpp
)

# Link Sandbox to Maple
target_link_libraries(Sandbox PRIVATE Maple)

# Include Maple headers
target_include_directories(Sandbox PRIVATE
    ${CMAKE_SOURCE_DIR}/Maple/src
)

# Preprocessor definitions
target_compile_definitions(Sandbox
    PUBLIC MP_PLATFORM_WINDOWS
)

# Output and intermediate folders for Sandbox
set_target_properties(Sandbox PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${OUTPUT_DIR}/$<CONFIG>
    ARCHIVE_OUTPUT_DIRECTORY ${OUTPUT_DIR}/$<CONFIG>
    LIBRARY_OUTPUT_DIRECTORY ${OUTPUT_DIR}/$<CONFIG>
    OBJECT_OUTPUT_DIRECTORY ${INT_DIR}/Sandbox/$<CONFIG>
    VS_DEBUGGER_WORKING_DIRECTORY ${OUTPUT_DIR}/$<CONFIG>
)

# ============================
# Copy Maple.dll to Sandbox after build
# ============================
add_custom_command(TARGET Sandbox POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_if_different
        $<TARGET_FILE:Maple>
        $<TARGET_FILE_DIR:Sandbox>
)