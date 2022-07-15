cmake_minimum_required(VERSION 3.10)
project(vidcap_api LANGUAGES CXX C)

# OpenCV
find_package(OpenCV REQUIRED)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DOPENCV")

add_library(vidcap_api SHARED "$ORIGIN/lib/vidcap_src/vidcap_api.cpp")