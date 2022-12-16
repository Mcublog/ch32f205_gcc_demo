# Include utils
include(config/utils.cmake)

# region COMMON
set(LIBS_DIR ${PROJECT_SOURCE_DIR}/libs)

# region COMMON
set(HAL_INCLUDE_DIRS
    ${LIBS_DIR}/CH32F20x_StdPeriph_Driver/StdPeriph_Driver/inc
    ${LIBS_DIR}/CH32F20x_StdPeriph_Driver/CMSIS/
    ${LIBS_DIR}/CH32F20x_StdPeriph_Driver/CMSIS/WCH
    ${LIBS_DIR}/CH32F20x_StdPeriph_Driver/CMSIS/WCH/CH32F20x/Include
    ${LIBS_DIR}/CH32F20x_StdPeriph_Driver/CMSIS/WCH/CH32F20x/Source
    ${LIBS_DIR}/CH32F20x_StdPeriph_Driver/CMSIS/WCH/CH32F20x
)
set_property(GLOBAL PROPERTY HAL_INCLUDE_DIRS_PROPERTY ${HAL_INCLUDE_DIRS})

file(GLOB_RECURSE HAL_SOURCES
    ${LIBS_DIR}/CH32F20x_StdPeriph_Driver/CMSIS/WCH/CH32F20x/Source/GCC/startup_ch32f20x.S
    ${LIBS_DIR}/CH32F20x_StdPeriph_Driver/CMSIS/WCH/CH32F20x/Source/system_ch32f20x.c
    ${LIBS_DIR}/libs/CH32F20x_StdPeriph_Driver/StdPeriph_Driver/src/*.c
)
# endregion

# region RTT
set(RTT_ENABLE true)
if(CMAKE_BUILD_TYPE STREQUAL Release)
    set(RTT_ENABLE false)
endif()

if(${RTT_ENABLE})
    LOG_INFO("RTT is enabled")
    set(RTT_VERSION SEGGER_RTT_V762c)
    set(RTT_DIR ${LIBS_DIR}/${RTT_VERSION})
    set(RTT_INCLUDE_DIRS
        ${RTT_DIR}/Config
        ${RTT_DIR}/RTT)
    # Add sources
    file(GLOB_RECURSE RTT_SOURCES
        ${RTT_DIR}/RTT/*.c
        ${RTT_DIR}/RTT/*.S
        ${RTT_DIR}/Syscalls/SEGGER_RTT_Syscalls_GCC.c
    )
endif()
set_property(GLOBAL PROPERTY RTT_INCLUDES_PROPERTY ${RTT_INCLUDE_DIRS})
set_property(GLOBAL PROPERTY RTT_SOURCES_PROPERTY ${RTT_SOURCES})

# endregion

