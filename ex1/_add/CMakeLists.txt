
# Create a library called mylib which includes source files lib.c
# Any number of sources could be listed here 
add_library(_add add.c)

# Make sure the compiler can find include files for our Hello library
# when other libraries or executables link to Hello
target_include_directories(_add PUBLIC add.h)