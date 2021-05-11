cmake_minimum_required(VERSION 3.15)

set(SYSTEM_PROCESSOR cortex-m33)
set(SYSTEM_ARCHITECTURE armv8-m.main)
set(SYSTEM_DSP OFF)


include(${TOOLCHAIN_FILE})
#Stop cmake running default compiler check.
set (CMAKE_C_COMPILER_FORCED true)


# Set the languages for project, else it will give undefined reference
# _exit error;
project("Tutorial" LANGUAGES C ASM)
toolchain_reload_compiler()


#define target
add_executable(Tutorial tutorial.c)

# add subdirectory to build where source CMakeLists.txt and
# other code is located
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/_add)
target_sources(Tutorial PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/_add/add.c)

# Add path for header includes
target_include_directories(Tutorial PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/_add)