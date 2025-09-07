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
# Dependencies
# ============================
include(FetchContent)

# spdlog
FetchContent_Declare(
    spdlog
    GIT_REPOSITORY https://github.com/gabime/spdlog.git
    GIT_TAG v1.13.0
)
FetchContent_MakeAvailable(spdlog)

# GLFW
FetchContent_Declare(
    glfw
    GIT_REPOSITORY https://github.com/glfw/glfw.git
    GIT_TAG 3.3.8
)
FetchContent_MakeAvailable(glfw)

# ============================
# Maple - Shared Library (DLL)
# ============================
file(GLOB_RECURSE MAPLE_SOURCES
    ${CMAKE_SOURCE_DIR}/Maple/src/*.cpp
    ${CMAKE_SOURCE_DIR}/Maple/src/*.h
    ${CMAKE_SOURCE_DIR}/Maple/src/Platform/*.cpp
    ${CMAKE_SOURCE_DIR}/Maple/src/Platform/*.h
)

add_library(Maple SHARED ${MAPLE_SOURCES})

# Precompiled header
target_precompile_headers(Maple PRIVATE ${CMAKE_SOURCE_DIR}/Maple/src/mppch.h)

# Include directories
target_include_directories(Maple PUBLIC
    ${CMAKE_SOURCE_DIR}/Maple/src
    ${CMAKE_SOURCE_DIR}/Maple/src/Platform
)

# Preprocessor definitions
target_compile_definitions(Maple
    PRIVATE MP_BUILD_DLL
    PUBLIC MP_PLATFORM_WINDOWS
)

# Force /MD for all MSVC configurations
if(MSVC)
    foreach(flag_var
            CMAKE_C_FLAGS_DEBUG CMAKE_C_FLAGS_RELEASE CMAKE_C_FLAGS_RELWITHDEBINFO CMAKE_C_FLAGS_MINSIZEREL
            CMAKE_CXX_FLAGS_DEBUG CMAKE_CXX_FLAGS_RELEASE CMAKE_CXX_FLAGS_RELWITHDEBINFO CMAKE_CXX_FLAGS_MINSIZEREL)
        string(REPLACE "/MT" "/MD" ${flag_var} "${${flag_var}}")
        string(REPLACE "/MTd" "/MD" ${flag_var} "${${flag_var}}")
    endforeach()
endif()

# Link spdlog, GLFW, and OpenGL
if(WIN32)
    target_link_libraries(Maple PUBLIC spdlog::spdlog glfw opengl32)
else()
    target_link_libraries(Maple PUBLIC spdlog::spdlog glfw)
endif()

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
target_include_directories(Sandbox PRIVATE
    ${CMAKE_SOURCE_DIR}/Maple/src
    ${CMAKE_SOURCE_DIR}/Maple/src/Platform
)

# Preprocessor definitions
target_compile_definitions(Sandbox PUBLIC MP_PLATFORM_WINDOWS)

# Force /MD for Sandbox as well
if(MSVC)
    foreach(flag_var
            CMAKE_C_FLAGS_DEBUG CMAKE_C_FLAGS_RELEASE CMAKE_C_FLAGS_RELWITHDEBINFO CMAKE_C_FLAGS_MINSIZEREL
            CMAKE_CXX_FLAGS_DEBUG CMAKE_CXX_FLAGS_RELEASE CMAKE_CXX_FLAGS_RELWITHDEBINFO CMAKE_CXX_FLAGS_MINSIZEREL)
        string(REPLACE "/MT" "/MD" ${flag_var} "${${flag_var}}")
        string(REPLACE "/MTd" "/MD" ${flag_var} "${${flag_var}}")
    endforeach()
endif()

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
