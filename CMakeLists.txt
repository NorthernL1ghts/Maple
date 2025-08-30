cmake_minimum_required(VERSION 3.20)

project(Maple LANGUAGES CXX)

if(NOT CMAKE_SIZEOF_VOID_P EQUAL 8)
    message(FATAL_ERROR "Only x64 builds are supported.")
endif()

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(OUTPUT_DIR ${CMAKE_SOURCE_DIR}/Binaries)
set(INT_DIR ${CMAKE_SOURCE_DIR}/Intermediates)

include(FetchContent)

# -----------------------------
# Fetch fmt first
# -----------------------------
FetchContent_Declare(
    fmt
    GIT_REPOSITORY https://github.com/fmtlib/fmt.git
    GIT_TAG 10.1.0
)
FetchContent_MakeAvailable(fmt)

# -----------------------------
# Fetch spdlog and use external fmt
# -----------------------------
set(SPDLOG_FMT_EXTERNAL ON CACHE BOOL "" FORCE)
FetchContent_Declare(
    spdlog
    GIT_REPOSITORY https://github.com/gabime/spdlog.git
    GIT_TAG v1.12.0
)
FetchContent_MakeAvailable(spdlog)

# -----------------------------
# Fetch GLFW
# -----------------------------
FetchContent_Declare(
    glfw
    GIT_REPOSITORY https://github.com/glfw/glfw.git
    GIT_TAG 3.3.8
)
FetchContent_MakeAvailable(glfw)

# -----------------------------
# Maple Library
# -----------------------------
file(GLOB_RECURSE MAPLE_SRC "${CMAKE_SOURCE_DIR}/Maple/src/Maple/*.cpp" "${CMAKE_SOURCE_DIR}/Maple/src/Maple/*.h")
add_library(Maple SHARED ${MAPLE_SRC})

target_include_directories(Maple PUBLIC ${CMAKE_SOURCE_DIR}/Maple/src)
target_link_libraries(Maple PUBLIC spdlog::spdlog fmt::fmt glfw)

target_compile_definitions(Maple PRIVATE MP_BUILD_DLL PUBLIC MP_PLATFORM_WINDOWS)

set_target_properties(Maple PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${OUTPUT_DIR}/$<CONFIG>
    ARCHIVE_OUTPUT_DIRECTORY ${OUTPUT_DIR}/$<CONFIG>
    LIBRARY_OUTPUT_DIRECTORY ${OUTPUT_DIR}/$<CONFIG>
    OBJECT_OUTPUT_DIRECTORY ${INT_DIR}/Maple/$<CONFIG>
    VS_DEBUGGER_WORKING_DIRECTORY ${OUTPUT_DIR}/$<CONFIG>
)

# -----------------------------
# Sandbox App
# -----------------------------
file(GLOB_RECURSE SANDBOX_SRC "${CMAKE_SOURCE_DIR}/Sandbox/src/*.cpp")
add_executable(Sandbox ${SANDBOX_SRC})

target_include_directories(Sandbox PRIVATE ${CMAKE_SOURCE_DIR}/Maple/src)
target_link_libraries(Sandbox PRIVATE Maple spdlog::spdlog fmt::fmt glfw)
target_compile_definitions(Sandbox PUBLIC MP_PLATFORM_WINDOWS)

set_target_properties(Sandbox PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${OUTPUT_DIR}/$<CONFIG>
    ARCHIVE_OUTPUT_DIRECTORY ${OUTPUT_DIR}/$<CONFIG>
    LIBRARY_OUTPUT_DIRECTORY ${OUTPUT_DIR}/$<CONFIG>
    OBJECT_OUTPUT_DIRECTORY ${INT_DIR}/Sandbox/$<CONFIG>
    VS_DEBUGGER_WORKING_DIRECTORY ${OUTPUT_DIR}/$<CONFIG>
)

add_custom_command(TARGET Sandbox POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_if_different
        $<TARGET_FILE:Maple>
        $<TARGET_FILE_DIR:Sandbox>
)
