
#creates libadder.a from adder.cpp
add_library(adder adder.cpp)

#includes directories to the target so that instead of "Headers/adder.h"
#we can write <adder.h> in main.cpp
target_include_directories(adder PRIVATE ../Headers)