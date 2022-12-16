# region MCU GLOBAL PROPERTY
set(F205_TARGET               f205_fw)

set_property(GLOBAL PROPERTY STM32F205_TARGET_NAME_PROPERTY         ${F205_TARGET})

# Put here your symbols (preprocessor defines), one in each line
# Encapsulate them with double quotes for safety purpose
set(symbols_SYMB
    $<$<CONFIG:DEBUG>:"DEBUG">
    $<$<CONFIG:RELASE>:"NDEBUG">
    $<$<CONFIG:RelWithDebInfo>:"DEBUG">
    "ARM_MATH_CM3"
    "USE_STDPERIPH_DRIVER"
)

set_property(GLOBAL PROPERTY STM32_DEFINES_PROPERTY
    ${symbols_SYMB}
)

set(CPU_PARAMETERS -mthumb
    # This needs attention to properly set for used MCU
    -mcpu=cortex-m3

    # None for M3
    # -mfpu=fpv5-d16
    -mfloat-abi=soft)

set(ARM_NONE_EABI_FLAGS
    ${CPU_PARAMETERS}
    # -Wall
    # -Wextra
    -Wpedantic
    -funsigned-char
    -fdata-sections
    -ffunction-sections
    -fdiagnostics-color=always
    -fno-common
    -fmessage-length=0
    # Full debug configuration
    $<$<CONFIG:DEBUG>: -Og -g3 -ggdb>
    # Release
    $<$<CONFIG:RELEASE>:-Os -s>
    # Release with DEBUG
    $<$<CONFIG:RelWithDebInfo>:-Os -g3 -ggdb>
)

set_property(GLOBAL PROPERTY ARM_NONE_EABI_FLAGS_PROPERTY
    ${ARM_NONE_EABI_FLAGS}
)

# Set linker script
set(F205_FW_LINKER_SCRIPT ${PROJECT_SOURCE_DIR}/libs/CH32F20x_StdPeriph_Driver/CH32F205RB_FLASH.ld)

set(MCU_COMMON_LINKER_OPTION
    ${CPU_PARAMETERS}
    -specs=nano.specs
    -specs=nosys.specs
    # -u _printf_float                # STDIO float formatting support
    -Wl,--start-group
    -lc
    -lm
    -fno-exceptions
    -fno-rtti
    -Wl,--end-group
    -Wl,--print-memory-usage
)

set_property(GLOBAL PROPERTY COMMON_MCU_LINKER_OPTIONS_PROPERTY ${MCU_COMMON_LINKER_OPTION})

set(F205_FW_LINKER_OPTION
    -T${F205_FW_LINKER_SCRIPT}
    ${MCU_COMMON_LINKER_OPTION}
    -Wl,-Map=${F205_TARGET}.map
)
# endregion