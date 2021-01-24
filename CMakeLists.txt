cmake_minimum_required(VERSION 3.13.4)

project(OLAS)

add_executable(${PROJECT_NAME} main.cpp)

add_subdirectory(Adder)

#includes directories to the target so that instead of "Adder/lib.h"
#we can write <lib.h> in main.cpp
target_include_directories(${PROJECT_NAME} PRIVATE Headers)

#target_link_directories is indeed not needed here because the 
#library is a subproject that cmake is building
#target_link_directories(${PROJECT_NAME} PRIVATE Adder Headers)

#links library adder assembled in upper CMakeLists.txt to the target
target_link_libraries(${PROJECT_NAME} adder)