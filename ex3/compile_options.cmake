set(SYSTEM_PROCESSOR cortex-m33)
set(SYSTEM_ARCHITECTURE armv8-m.main)
set(SYSTEM_DSP OFF)

include(${TOOLCHAIN_FILE})
#Stop cmake running default compiler check.
set (CMAKE_C_COMPILER_FORCED true)
