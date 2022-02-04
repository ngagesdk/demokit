set(UID3 0x10005b9a) # tunnel UID

set(SRC_DIR "${CMAKE_CURRENT_SOURCE_DIR}")

set(tunnel_sources
    "${SRC_DIR}/tunnel.c")

add_library(tunnel STATIC ${tunnel_sources})

build_exe_static(tunnel exe ${UID1} ${UID2} ${UID3} "${demokit_static_libs}" "${demokit_libs}")

if(INSTALL_APP)
    install_file(tunnel.exe stars ${CMAKE_CURRENT_BINARY_DIR} tunnel.exe ${MMC_DRIVE_LETTER})
endif()

if(INSTALL_EKA2L1)
    copy_file(tunnel.exe ${CMAKE_CURRENT_BINARY_DIR} ${EKA2L1_E_DRIVE} tunnel.exe)
endif()

add_dependencies(
    tunnel.exe
    tunnel)

add_dependencies(
    tunnel
    SDL)

target_compile_definitions(
    tunnel
    PUBLIC
    __EXE__
    ${GCC_DEFS}
    UID1=${UID1}
    UID2=${UID2}
    UID3=${UID3})

target_include_directories(
    tunnel
    PUBLIC
    ${SRC_DIR}
    ${SDL_INC_DIR}
    ${DBGPRINT_INC_DIR})
