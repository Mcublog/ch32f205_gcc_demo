cmake_minimum_required(VERSION 3.22)

# Setup compiler settings
set(CMAKE_TRY_COMPILE_TARGET_TYPE   "STATIC_LIBRARY")
set(CMAKE_C_STANDARD                11)
set(CMAKE_C_STANDARD_REQUIRED       ON)
set(CMAKE_C_EXTENSIONS              ON)
set(CMAKE_CXX_STANDARD              20)
set(CMAKE_CXX_STANDARD_REQUIRED     ON)
set(CMAKE_CXX_EXTENSIONS            ON)
if(NOT ${CMAKE_HOST_SYSTEM_NAME} MATCHES "Linux")
    set(CMAKE_SYSTEM_NAME           Generic) # workaround for Windows
endif()

set_property(GLOBAL PROPERTY RULE_MESSAGES OFF)
# Added color compiler output
if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
    add_compile_options(-fdiagnostics-color=always)
endif()
# Set defines
add_definitions(-DprojCOVERAGE_TEST=0)
add_definitions(-D_WINDOWS_)

project(ch32f205demo VERSION 0.1.0 LANGUAGES C CXX ASM)

include(config/common.cmake)
include(config/mcu.cmake)
include(config/utils.cmake)

include_directories(
    ${HAL_INCLUDE_DIRS}
    ${CMAKE_CURRENT_SOURCE_DIR}
)

add_executable(${F205_TARGET} main.c ${HAL_SOURCES})
# Project symbols
target_compile_definitions(${F205_TARGET} PRIVATE ${symbols_SYMB})

# Compiler options
target_compile_options(${F205_TARGET}
    PRIVATE
    ${ARM_NONE_EABI_FLAGS}
    -Wno-missing-braces
    -Wno-pointer-sign
)
# Linker options
target_link_options(${F205_TARGET} PRIVATE ${F205_FW_LINKER_OPTION})
# Convert output to hex and binary
add_custom_command(TARGET ${F205_TARGET}
    POST_BUILD
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
    COMMAND ${CMAKE_OBJCOPY} ARGS -O ihex   -I elf32-littlearm ${F205_TARGET} ${F205_TARGET}.hex
    COMMAND ${CMAKE_OBJCOPY} ARGS -O binary -I elf32-littlearm ${F205_TARGET} ${F205_TARGET}.bin
)
