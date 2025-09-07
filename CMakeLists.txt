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
# Dependencies (spdlog)
# ============================
include(FetchContent)

FetchContent_Declare(
    spdlog
    GIT_REPOSITORY https://github.com/gabime/spdlog.git
    GIT_TAG v1.13.0 # Use latest stable version
)

FetchContent_MakeAvailable(spdlog)

# ============================
# Maple - Shared Library (DLL)
# ============================
# Collect all source/header files under Maple/src
file(GLOB_RECURSE MAPLE_SOURCES CONFIGURE_DEPENDS
    ${CMAKE_SOURCE_DIR}/Maple/src/*.cpp
    ${CMAKE_SOURCE_DIR}/Maple/src/*.h
)

# Exclude EntryPoint.h (should only be used by client apps, not Maple itself)
list(REMOVE_ITEM MAPLE_SOURCES ${CMAKE_SOURCE_DIR}/Maple/src/Maple/EntryPoint.h)

add_library(Maple SHARED ${MAPLE_SOURCES})

# Include directories (so we can do #include "Maple/...")
target_include_directories(Maple PUBLIC
    ${CMAKE_SOURCE_DIR}/Maple/src
)

# Preprocessor definitions
target_compile_definitions(Maple
    PRIVATE MP_BUILD_DLL
    PUBLIC MP_PLATFORM_WINDOWS
)

# Link spdlog
target_link_libraries(Maple PUBLIC spdlog::spdlog)

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
