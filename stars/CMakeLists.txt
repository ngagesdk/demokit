set(UID3 0x10005b99) # stars UID

set(SRC_DIR "${CMAKE_CURRENT_SOURCE_DIR}")

set(stars_sources
    "${SRC_DIR}/stars.c")

add_library(stars STATIC ${stars_sources})

build_exe_static(stars exe ${UID1} ${UID2} ${UID3} "${demokit_static_libs}" "${demokit_libs}")

if(INSTALL_APP)
    install_file(stars.exe stars ${CMAKE_CURRENT_BINARY_DIR} stars.exe ${MMC_DRIVE_LETTER})
endif()

if(INSTALL_EKA2L1)
    copy_file(stars.exe ${CMAKE_CURRENT_BINARY_DIR} ${EKA2L1_E_DRIVE} stars.exe)
endif()

add_dependencies(
    stars.exe
    stars)

add_dependencies(
    stars
    SDL)

target_compile_definitions(
    stars
    PUBLIC
    __EXE__
    ${GCC_DEFS}
    UID1=${UID1}
    UID2=${UID2}
    UID3=${UID3})

target_include_directories(
    stars
    PUBLIC
    ${SRC_DIR}
    ${SDL_INC_DIR}
    ${DBGPRINT_INC_DIR})
