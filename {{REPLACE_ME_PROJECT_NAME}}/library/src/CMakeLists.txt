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

# Note: for header-only libraries change all PUBLIC flags to INTERFACE and create an interface
# target: add_library(${PROJECT_NAME} INTERFACE)

add_library(${LIB_NAME} STATIC ${SOURCES})

if({{REPLACE_ME_PROJECT_NAME}}_ENABLE_RAYLIB)
  #set(raylib_VERBOSE 1)
  target_link_libraries(${LIB_NAME} raylib)

  # Web Configurations
  if(${PLATFORM} STREQUAL "Web")
    # Tell Emscripten to build an example.html file.
    set_target_properties(${LIB_NAME} PROPERTIES SUFFIX ".html")
    target_link_options(${LIB_NAME} PUBLIC "-sUSE_GLFW=3")
    # copy binaries to release folder
    add_custom_command(
      TARGET ${LIB_NAME} POST_BUILD
      # COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE_DIR:${LIB_NAME}>/${LIB_NAME}.html ${PROJECT_SOURCE_DIR}/release/raw/${LIB_NAME}/${LIB_NAME}.html
      COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE_DIR:${LIB_NAME}>/${LIB_NAME}.js ${PROJECT_SOURCE_DIR}/release/raw/${LIB_NAME}/${LIB_NAME}.js
      COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE_DIR:${LIB_NAME}>/${LIB_NAME}.wasm ${PROJECT_SOURCE_DIR}/release/raw/${LIB_NAME}/${LIB_NAME}.wasm
      COMMENT "Release ${LIB_NAME}/${LIB_NAME}.html, ${LIB_NAME}.js, and ${LIB_NAME}.wasm"
      DEPENDS ${LIB_NAME})
  endif()

  # Checks if OSX and links appropriate frameworks (Only required on MacOS)
  if(APPLE)
    target_link_libraries(${LIB_NAME} "-framework IOKit")
    target_link_libraries(${LIB_NAME} "-framework Cocoa")
    target_link_libraries(${LIB_NAME} "-framework OpenGL")
  endif()
endif()

set_target_properties(${LIB_NAME} PROPERTIES CXX_EXTENSIONS OFF)
target_compile_features(${LIB_NAME} PUBLIC cxx_std_{{REPLACE_ME_STD_VERSION}})
target_compile_options(${LIB_NAME} PRIVATE ${SANITIZER_FLAGS} ${DEFAULT_COMPILER_OPTIONS_AND_WARNINGS})
target_link_libraries(${LIB_NAME} PRIVATE ${SANITIZER_FLAGS})
target_include_directories(${LIB_NAME} PUBLIC ${PROJECT_SOURCE_DIR}/include/${CMAKE_PROJECT_NAME})
target_include_directories(${LIB_NAME} PUBLIC ${PROJECT_SOURCE_DIR}/${CMAKE_PROJECT_NAME}/library/include)

# TODO: look into the BUILD/INSTALL_INTERFACT macros:
# target_include_directories(
#   ${PROJECT_NAME} PUBLIC $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>
#                          $<INSTALL_INTERFACE:include/${PROJECT_NAME}-${PROJECT_VERSION}>
# )

# copy binaries to release folder
add_custom_command(
  TARGET ${LIB_NAME} POST_BUILD
  COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:${LIB_NAME}> ${PROJECT_SOURCE_DIR}/release/raw/${LIB_NAME}/$<TARGET_FILE_NAME:${LIB_NAME}>
  # COMMAND ${CMAKE_COMMAND} -E tar "cfv" "${PROJECT_SOURCE_DIR}/release/${LIB_NAME}.zip" --format=zip  -- ${PROJECT_SOURCE_DIR}/release/raw/${LIB_NAME}/
  COMMENT "Release ${LIB_NAME}/${LIB_NAME}"
  DEPENDS ${LIB_NAME})


