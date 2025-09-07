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
    GIT_TAG v1.13.0
)

FetchContent_MakeAvailable(spdlog)

# ============================
# Maple - Shared Library (DLL)
# ============================
# Collect all source/header files under Maple/src
file(GLOB_RECURSE MAPLE_SOURCES
    ${CMAKE_SOURCE_DIR}/Maple/src/*.cpp
    ${CMAKE_SOURCE_DIR}/Maple/src/*.h
)

add_library(Maple SHARED ${MAPLE_SOURCES})

# Precompiled header
target_precompile_headers(Maple PRIVATE ${CMAKE_SOURCE_DIR}/Maple/src/mppch.h)

# Include directories
target_include_directories(Maple PUBLIC ${CMAKE_SOURCE_DIR}/Maple/src)

# Preprocessor definitions
target_compile_definitions(Maple
    PRIVATE MP_BUILD_DLL
    PUBLIC MP_PLATFORM_WINDOWS
)

# Link spdlog
target_link_libraries(Maple PUBLIC spdlog::spdlog)

# Output and intermediate folders
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
file(GLOB_RECURSE SANDBOX_SOURCES
    ${CMAKE_SOURCE_DIR}/Sandbox/src/*.cpp
    ${CMAKE_SOURCE_DIR}/Sandbox/src/*.h
)

add_executable(Sandbox ${SANDBOX_SOURCES})

# Precompiled header for Sandbox (optional)
target_precompile_headers(Sandbox PRIVATE ${CMAKE_SOURCE_DIR}/Maple/src/mppch.h)

# Link Sandbox to Maple
target_link_libraries(Sandbox PRIVATE Maple)

# Include Maple headers
target_include_directories(Sandbox PRIVATE ${CMAKE_SOURCE_DIR}/Maple/src)

# Preprocessor definitions
target_compile_definitions(Sandbox PUBLIC MP_PLATFORM_WINDOWS)

# Output and intermediate folders
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
