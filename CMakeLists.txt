cmake_minimum_required(VERSION 3.00)

if(DEFINED ENV{NGAGESDK})
    SET(NGAGESDK $ENV{NGAGESDK})
    set(CMAKE_TOOLCHAIN_FILE ${NGAGESDK}/cmake/ngage-toolchain.cmake)
else()
    message(FATAL_ERROR "The environment variable NGAGESDK needs to be defined.")
endif()

project(demokit C CXX)

include(SDL)

# Use CMake or Visual Studio to enable these settings.
option(INSTALL_EKA2L1 "Install app for EKA2L1" OFF)

set(UID1 0x1000007a) # KExecutableImageUidValue, e32uid.h
set(UID2 0x100039ce) # KAppUidValue16, apadef.h

set(GCC_COMN_DEFS -D__SYMBIAN32__ -D__GCC32__ -D__EPOC32__ -D__MARM__ -D__MARM_ARMI__)
set(GCC_MODE_DEFS -DNDEBUG -D_UNICODE)
set(GCC_DEFS      ${GCC_COMN_DEFS} ${GCC_MODE_DEFS})

set(demokit_static_libs
    ${CMAKE_CURRENT_BINARY_DIR}/libSDL.a)

set(demokit_libs
    ${EPOC_PLATFORM}/gcc/lib/gcc-lib/thumb-epoc-pe/2.9-psion-98r2/interwork/libgcc.a
    ${CMAKE_CURRENT_BINARY_DIR}/libdbgprint.a
    ${EPOC_LIB}/egcc.lib
    ${EPOC_LIB}/euser.lib
    ${EPOC_LIB}/estlib.lib
    ${EPOC_LIB}/ws32.lib
    ${EPOC_LIB}/hal.lib
    ${EPOC_LIB}/efsrv.lib
    ${EPOC_LIB}/scdv.lib)

add_subdirectory(fire)
add_subdirectory(plasma)
add_subdirectory(stars)
add_subdirectory(tunnel)
