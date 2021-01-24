#! /bin/sh


#-DGLFW_BUILD_DOCS=OFF dodatkowa opcja z external/glfw/CMakeLists 
cmake -DGLFW_BUILD_DOCS=OFF -S . -B out/build