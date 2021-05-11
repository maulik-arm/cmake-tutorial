Cmake beginner tutorial. 
Cross - compiling; Adding compiler options

Top level file:

Executable: Tutorial.c
subdirectory lib: add.c, add.h


To build:
mkdir build
cd build
cmake -DTOOLCHAIN_FILE=toolchain_GNUARM.cmake ../
cmake -- build . && make

##Extra Notes
As you define the project name  with project(), cmake starts looking for compiler if cross compiler is not defined
