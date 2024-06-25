set(APP_NAME {{REPLACE_ME_APP_NAME}})

# Whenever this glob's value changes, cmake will rerun and update the build with
# the new/removed files.
if({{REPLACE_ME_PROJECT_NAME}}_ENABLE_GLOBS)
  file(
    GLOB_RECURSE
    SOURCES
    CONFIGURE_DEPENDS
    "*.cpp")
else()
  set(SOURCES "${APP_NAME}.cpp")
endif()
set(SOURCES ${SOURCES})

add_executable(${APP_NAME} ${SOURCES})

# include the library:
target_include_directories(${APP_NAME} PUBLIC ${PROJECT_SOURCE_DIR}/${CMAKE_PROJECT_NAME}/library/include)
target_link_directories(${APP_NAME} PRIVATE ${PROJECT_SOURCE_DIR}/${CMAKE_PROJECT_NAME}/library/src)
target_link_libraries(${APP_NAME} PRIVATE {{REPLACE_ME_LIB_NAME}})

target_link_libraries(${APP_NAME} PRIVATE ${SANITIZER_FLAGS})
target_include_directories(${APP_NAME} PUBLIC ${PROJECT_SOURCE_DIR}/include/${CMAKE_PROJECT_NAME})
target_include_directories(${APP_NAME} PUBLIC ${PROJECT_SOURCE_DIR}/${CMAKE_PROJECT_NAME}/app/include)

set_target_properties(${APP_NAME} PROPERTIES CXX_EXTENSIONS OFF)
target_compile_features(${APP_NAME} PUBLIC cxx_std_{{REPLACE_ME_STD_VERSION}})
target_compile_options(${APP_NAME} PRIVATE ${SANITIZER_FLAGS} ${DEFAULT_COMPILER_OPTIONS_AND_WARNINGS})
