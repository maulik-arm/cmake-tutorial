message(STATUS "Getting config from .. ${TOOLCHAIN_FILE}")


if(NOT TOOLCHAIN_FILE)
    message(DEPRECATION "SETTING CMAKE_TOOLCHAIN_FILE is deprecated. It has been replaced with TOOLCHAIN_FILE.")
    return()
endif()



set(CMAKE_SYSTEM_NAME Generic)
set(CROSS_COMPILE                       arm-none-eabi CACHE STRING  "Cross-compilation triplet")

find_program(CMAKE_C_COMPILER ${CROSS_COMPILE}-gcc)

if(CMAKE_C_COMPILER STREQUAL "CMAKE_C_COMPILER-NOTFOUND")
    message(FATAL_ERROR "Could not find compiler: '${CROSS_COMPILE}-gcc'")
endif()


set(CMAKE_ASM_COMPILER ${CMAKE_C_COMPILER})



macro(toolchain_reset_compiler_flags)
    set_property(DIRECTORY PROPERTY COMPILE_OPTIONS "")

    add_compile_options(
        --specs=nano.specs
        -Wall
        -Wno-format
        -Wno-return-type
        -Wno-unused-but-set-variable
        -c
        -fdata-sections
        -ffunction-sections
        -fno-builtin
        -fshort-enums
        -funsigned-char
        -mthumb
        -nostdlib
        -std=c99
        $<$<BOOL:${CODE_COVERAGE}>:-g>
        $<$<NOT:$<BOOL:${SYSTEM_FP}>>:-msoft-float>
    )
endmacro()

macro(toolchain_reset_linker_flags)
    set_property(DIRECTORY PROPERTY LINK_OPTIONS "")

    add_link_options(
        --entry=Reset_Handler
        --specs=nano.specs
        LINKER:-check-sections
        LINKER:-fatal-warnings
        LINKER:--gc-sections
        LINKER:--no-wchar-size-warning
        LINKER:--print-memory-usage
    )
endmacro()

macro(toolchain_set_processor_arch)
    set(CMAKE_SYSTEM_PROCESSOR ${SYSTEM_PROCESSOR})
    set(CMAKE_SYSTEM_ARCHITECTURE ${SYSTEM_ARCHITECTURE})

    if (DEFINED SYSTEM_DSP)
        if(NOT SYSTEM_DSP)
            string(APPEND CMAKE_SYSTEM_PROCESSOR "+nodsp")
        endif()
    endif()
endmacro()

macro(toolchain_reload_compiler)
    toolchain_set_processor_arch()
    toolchain_reset_compiler_flags()
    toolchain_reset_linker_flags()

    unset(CMAKE_C_FLAGS_INIT)
    unset(CMAKE_ASM_FLAGS_INIT)

    set(CMAKE_C_FLAGS_INIT "-mcpu=${CMAKE_SYSTEM_PROCESSOR}")
    set(CMAKE_ASM_FLAGS_INIT "-mcpu=${CMAKE_SYSTEM_PROCESSOR}")
    set(CMAKE_C_LINK_FLAGS "-mcpu=${CMAKE_SYSTEM_PROCESSOR}")
    set(CMAKE_ASM_LINK_FLAGS "-mcpu=${CMAKE_SYSTEM_PROCESSOR}")

    set(CMAKE_C_FLAGS ${CMAKE_C_FLAGS_INIT})
    set(CMAKE_ASM_FLAGS ${CMAKE_ASM_FLAGS_INIT})
endmacro()