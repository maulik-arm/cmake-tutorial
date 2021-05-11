cmake_minimum_required(VERSION 3.19)
project(Tutorial)

#define target
add_executable(Tutorial tutorial.c)

# add subdirectory to build where source CMakeLists.txt and
# other code is located
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/_add)
target_sources(Tutorial PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/_add/add.c)

# Add path for header includes
target_include_directories(Tutorial PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/_add)