cmake_minimum_required(VERSION 3.2)

project(studxml)

set(target go)
set(src    main.cpp)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_EXTENSIONS OFF)

#################################################
# libstudxml: download, verify checksum and build
#################################################
include(cmake_extra/libstudxml.cmake)

##################################################
# libstudxml: setup library for this cmake project
##################################################

set(LIBSTUDXML_CMAKE_USAGE 1)

if (${LIBSTUDXML_CMAKE_USAGE} EQUAL 1)
  set(ENV{PKG_CONFIG_PATH} "${PROJECT_BINARY_DIR}/${LIBSTUDXML_INSTALL}/lib/pkgconfig:$ENV{PKG_CONFIG_PATH}")

  include(FindPkgConfig)
  if (PKG_CONFIG_FOUND)
    pkg_check_modules(LIBSTUDXML libstudxml)
  endif ()

  if(LIBSTUDXML_FOUND)
    link_directories(   ${LIBSTUDXML_LIBRARY_DIRS})
    include_directories(${LIBSTUDXML_INCLUDE_DIRS})
    set(libs ${libs}    ${LIBSTUDXML_LIBRARIES})
  else()
    message(FATAL_ERROR "pkgconfig of libstudxml not found")
  endif()

else()

  set(LIBSTUDXML_ROOT ${PROJECT_BINARY_DIR}/${LIBSTUDXML_INSTALL})
  include_directories(${LIBSTUDXML_ROOT}/include)

  link_directories(${LIBSTUDXML_ROOT}/lib)
  set(libs ${libs} studxml)

endif()

################
# build target
################
add_executable(       ${target} ${src})
target_link_libraries(${target} ${libs})
