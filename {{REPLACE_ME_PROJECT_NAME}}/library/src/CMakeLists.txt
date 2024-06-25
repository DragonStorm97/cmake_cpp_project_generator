set(LIB_NAME {{REPLACE_ME_LIB_NAME}})
# set(LIB_NAME ${CMAKE_PROJECT_NAME}_library)

# Whenever this glob's value changes, cmake will rerun and update the build with
# the new/removed files.
if({{REPLACE_ME_PROJECT_NAME}}_ENABLE_GLOBS)
  file(
    GLOB_RECURSE
    SOURCES
    CONFIGURE_DEPENDS
    "*.cpp")
else()
  set(SOURCES "${LIB_NAME}.cpp")
endif()

add_library(${LIB_NAME} STATIC ${SOURCES})

set_target_properties(${LIB_NAME} PROPERTIES CXX_EXTENSIONS OFF)
target_compile_features(${LIB_NAME} PUBLIC cxx_std_{{REPLACE_ME_STD_VERSION}})
target_compile_options(${LIB_NAME} PRIVATE ${SANITIZER_FLAGS} ${DEFAULT_COMPILER_OPTIONS_AND_WARNINGS})
target_link_libraries(${LIB_NAME} PRIVATE ${SANITIZER_FLAGS})
target_include_directories(${LIB_NAME} PUBLIC ${PROJECT_SOURCE_DIR}/include/${CMAKE_PROJECT_NAME})
target_include_directories(${LIB_NAME} PUBLIC ${PROJECT_SOURCE_DIR}/${CMAKE_PROJECT_NAME}/library/include)
