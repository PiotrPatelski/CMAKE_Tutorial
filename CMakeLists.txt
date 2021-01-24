cmake_minimum_required(VERSION 3.13.4)

project(OLAS)

add_executable(${PROJECT_NAME} main.cpp)

add_subdirectory(Adder)

#           DOWNLOAD ALL THE SUBMODULES
find_package(Git QUIET)
if(GIT_FOUND AND EXISTS "${PROJECT_SOURCE_DIR}/.git")

# Update submodules as needed
    option(GIT_SUBMODULE "Check submodules during build" ON)
    if(GIT_SUBMODULE)
        message(STATUS "Submodule update")
        execute_process(COMMAND ${GIT_EXECUTABLE} submodule update --init --recursive
                        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
                        RESULT_VARIABLE GIT_SUBMOD_RESULT)
        if(NOT GIT_SUBMOD_RESULT EQUAL "0")
            message(FATAL_ERROR "git submodule update --init failed with ${GIT_SUBMOD_RESULT}, please checkout submodules")
        endif()
    endif()
endif()

#           CHECK ALL THE SUBMODULES
if(NOT EXISTS "${PROJECT_SOURCE_DIR}/external/glfw/CMakeLists.txt")
    message(FATAL_ERROR "The glfw submodules was not downloaded! GIT_SUBMODULE was turned off or failed. Please update submodules and try again.")
endif()


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


