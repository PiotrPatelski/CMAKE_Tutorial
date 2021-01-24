cmake_minimum_required(VERSION 3.13.4)

project(OLAS)

add_executable(${PROJECT_NAME} main.cpp)

add_subdirectory(Adder)

add_subdirectory(external/glfw)

#includes directories to the target so that instead of "Adder/lib.h"
#we can write <lib.h> in main.cpp
target_include_directories(${PROJECT_NAME} 
    PUBLIC Headers 
    PUBLIC external/glfw/include
) 

#target_link_directories is indeed not needed here because the 
#library is a subproject that cmake is building
#target_link_directories(${PROJECT_NAME} PRIVATE Adder PRIVATE Headers)

#however we need this for external libraries
target_link_directories(${PROJECT_NAME}
    PRIVATE external/glfw/src)

#links library libadder.a assembled in upper CMakeLists.txt to the target
#links library libglfw3.a assembled in glfw CMakeLists.txt to the target 
target_link_libraries(${PROJECT_NAME} adder glfw) 