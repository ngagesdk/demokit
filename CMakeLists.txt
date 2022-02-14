cmake_minimum_required(VERSION 3.00)

if(DEFINED ENV{NGAGESDK})
    SET(NGAGESDK $ENV{NGAGESDK})
    set(CMAKE_TOOLCHAIN_FILE ${NGAGESDK}/cmake/ngage-toolchain.cmake)
else()
    message(FATAL_ERROR "The environment variable NGAGESDK needs to be defined.")
endif()

project(demokit C CXX)

include(SDL)
include(dbgprint)

# Use CMake or Visual Studio to enable these settings.
option(INSTALL_EKA2L1 "Install app for EKA2L1" OFF)
# The following options are mutual exclusive.
option(BUILD_FIRE     "Build fire demo"        ON)
option(BUILD_PLASMA   "Build plasma demo"      OFF)
option(BUILD_STARS    "Build stars demo"       OFF)
option(BUILD_TUNNEL   "Build tunnel demo"      OFF)

set(UID1 0x1000007a) # KExecutableImageUidValue, e32uid.h
set(UID2 0x100039ce) # KAppUidValue16, apadef.h

set(GCC_COMN_DEFS -D__SYMBIAN32__ -D__GCC32__ -D__EPOC32__ -D__MARM__ -D__MARM_ARMI__)
set(GCC_MODE_DEFS -DNDEBUG -D_UNICODE)
set(GCC_DEFS      ${GCC_COMN_DEFS} ${GCC_MODE_DEFS})

set(demokit_static_libs
    ${CMAKE_CURRENT_BINARY_DIR}/libSDL.a)

set(demokit_libs
    ${CMAKE_CURRENT_BINARY_DIR}/libdbgprint.a
    ${EPOC_PLATFORM}/gcc/lib/gcc-lib/arm-epoc-pe/2.9-psion-98r2/libgcc.a
    ${EPOC_LIB}/egcc.lib
    ${EPOC_LIB}/euser.lib
    ${EPOC_LIB}/estlib.lib
    ${EPOC_LIB}/ws32.lib
    ${EPOC_LIB}/hal.lib
    ${EPOC_LIB}/efsrv.lib
    ${EPOC_LIB}/scdv.lib
    ${EPOC_LIB}/gdi.lib)

set(SRC_DIR "${CMAKE_CURRENT_SOURCE_DIR}")

if(BUILD_PLASMA)
    set(demokit_exe plasma)
    set(UID3 0x10005b98) # plasma UID
    set(demokit_sources
        "${SRC_DIR}/plasma/plasma.c"
        "${SRC_DIR}/plasma/plasmpal.c")

elseif(BUILD_STARS)
    set(demokit_exe stars)
    set(UID3 0x10005b9a) # stars UID
    set(demokit_sources
        "${SRC_DIR}/stars/stars.c")

elseif(BUILD_TUNNEL)
    set(demokit_exe tunnel)
    set(UID3 0x10005b99) # tunnel UID
    set(demokit_sources
        "${SRC_DIR}/tunnel/tunnel.c")

else() #(BUILD_FIRE)
    set(demokit_exe fire)
    set(UID3 0x10005b97) # fire UID
    set(demokit_sources
        "${SRC_DIR}/fire/fire.c"
        "${SRC_DIR}/fire/firepal.c")
endif()

add_library(${demokit_exe} STATIC ${demokit_sources})
build_exe_static(${demokit_exe} exe ${UID1} ${UID2} ${UID3} "${demokit_static_libs}" "${demokit_libs}")

if(INSTALL_EKA2L1)
    copy_file(${demokit_exe}.exe ${CMAKE_CURRENT_BINARY_DIR} ${EKA2L1_E_DRIVE} ${demokit_exe}.exe)
endif()

add_dependencies(
    ${demokit_exe}.exe
    ${demokit_exe})

add_dependencies(
    ${demokit_exe}
    SDL)

target_compile_definitions(
    ${demokit_exe}
    PUBLIC
    __EXE__
    CAP_SPEED=0
    ${GCC_DEFS}
    UID1=${UID1}
    UID2=${UID2}
    UID3=${UID3})

target_compile_options(
    ${demokit_exe}
    PUBLIC
    -O3)

target_include_directories(
    ${demokit_exe}
    PUBLIC
    ${SRC_DIR}
    ${SDL_INC_DIR})
