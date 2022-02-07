set(UID3 0x10005b97) # fire UID

set(SRC_DIR "${CMAKE_CURRENT_SOURCE_DIR}")

set(fire_sources
    "${SRC_DIR}/fire.c"
    "${SRC_DIR}/firepal.c")

add_library(fire STATIC ${fire_sources})

build_exe_static(fire exe ${UID1} ${UID2} ${UID3} "${demokit_static_libs}" "${demokit_libs}")

if(INSTALL_EKA2L1)
    copy_file(fire.exe ${CMAKE_CURRENT_BINARY_DIR} ${EKA2L1_E_DRIVE} fire.exe)
endif()

add_dependencies(
    fire.exe
    fire)

add_dependencies(
    fire
    SDL)

target_compile_definitions(
    fire
    PUBLIC
    __EXE__
    ${GCC_DEFS}
    UID1=${UID1}
    UID2=${UID2}
    UID3=${UID3})

target_include_directories(
    fire
    PUBLIC
    ${SRC_DIR}
    ${SDL_INC_DIR})
