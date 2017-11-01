cmake_minimum_required(VERSION 3.8)
project(golden_search_numerical_recipes)

set(CMAKE_CXX_STANDARD 11)

set(SOURCE_FILES main.cpp mins.h nr3.h)
add_executable(golden_search_numerical_recipes ${SOURCE_FILES})