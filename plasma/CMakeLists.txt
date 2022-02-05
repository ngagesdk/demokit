set(UID3 0x10005b98) # plasma UID

set(SRC_DIR "${CMAKE_CURRENT_SOURCE_DIR}")

set(plasma_sources
    "${SRC_DIR}/plasma.c"
    "${SRC_DIR}/plasmpal.c")

add_library(plasma STATIC ${plasma_sources})

build_exe_static(plasma exe ${UID1} ${UID2} ${UID3} "${demokit_static_libs}" "${demokit_libs}")

if(INSTALL_APP)
    install_file(plasma.exe stars ${CMAKE_CURRENT_BINARY_DIR} plasma.exe ${MMC_DRIVE_LETTER})
endif()

if(INSTALL_EKA2L1)
    copy_file(plasma.exe ${CMAKE_CURRENT_BINARY_DIR} ${EKA2L1_E_DRIVE} plasma.exe)
endif()

add_dependencies(
    plasma.exe
    plasma)

add_dependencies(
    plasma
    SDL)

target_compile_definitions(
    plasma
    PUBLIC
    __EXE__
    ${GCC_DEFS}
    UID1=${UID1}
    UID2=${UID2}
    UID3=${UID3})

target_include_directories(
    plasma
    PUBLIC
    ${SRC_DIR}
    ${SDL_INC_DIR})
