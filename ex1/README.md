Cmake beginner tutorial.

Top level file:

Executable: Tutorial.c
subdirectory lib: add.c, add.h


To build:
mkdir build
cd build
cmake ../ && cmake -- build . && make