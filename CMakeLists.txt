cmake_minimum_required(VERSION 3.6)
project(dplyr)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")

set(SRC_DIR ${PROJECT_NAME}-pkg/src)

set(R_LIBRARY "~/R-library")
set(R_INCLUDE "/usr/share/R/include")

include_directories(${R_LIBRARY}/Rcpp/include)
include_directories(${R_LIBRARY}/BH/include)
include_directories(${R_LIBRARY}/plogr/include)
include_directories(${R_INCLUDE})
include_directories(${SRC_DIR})
include_directories(${PROJECT_NAME}-pkg/inst/include)

add_definitions(-D__CLION__)


file(GLOB SOURCE_FILES ${SRC_DIR}/*.cpp ${SRC_DIR}/*.c)
add_library(${PROJECT_NAME} ${SOURCE_FILES})

add_custom_target(
    Rinstall
    COMMAND ${${PROJECT_NAME}_SOURCE_DIR}/build.sh
)
