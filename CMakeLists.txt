cmake_minimum_required(VERSION 3.26)
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

project("{{REPLACE_ME_PROJECT_NAME}}" LANGUAGES CXX)

# Check if the project is the top-level project
set({{REPLACE_ME_PROJECT_NAME}}_IS_TOP_LEVEL_PROJECT FALSE)
if(CMAKE_CURRENT_SOURCE_DIR STREQUAL CMAKE_SOURCE_DIR)
  set({{REPLACE_ME_PROJECT_NAME}}_IS_TOP_LEVEL_PROJECT TRUE)
endif()

# Generate compile_commands.json
if({{REPLACE_ME_PROJECT_NAME}}_IS_TOP_LEVEL_PROJECT)
  set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
  option({{REPLACE_ME_PROJECT_NAME}}_ENABLE_CATCH2_TESTS "Enable Tests for {{REPLACE_ME_PROJECT_NAME}}" ON)
  option({{REPLACE_ME_PROJECT_NAME}}_ENABLE_GLOBS "Enable GLOB sourcing for {{REPLACE_ME_PROJECT_NAME}}" ON)
  # create a symbolic link to the compile_commands file:
  file(
    CREATE_LINK
    ${CMAKE_BINARY_DIR}/compile_commands.json
    compile_commands.json
    COPY_ON_ERROR
    SYMBOLIC)
  # we only include the app in top-level builds
  add_subdirectory(${CMAKE_PROJECT_NAME}/app/src)
else()
  # disable tests if we're a sub-project
  set({{REPLACE_ME_PROJECT_NAME}}_ENABLE_CATCH2_TESTS FALSE)
  # enable globs if we're a sub-project?
  set({{REPLACE_ME_PROJECT_NAME}}_ENABLE_GLOBS TRUE)
endif()

add_subdirectory(${CMAKE_PROJECT_NAME}/library/src)

# adjust or override some CMake defaults
include(cmake/OverrideCMakeDefaults.cmake)

# default compiler options and warnings
include(cmake/DefaultCompilerOptionsAndWarnings.cmake)

# static analyzers
include(cmake/StaticAnalyzers.cmake)

# sanitizers
include(cmake/Sanitizers.cmake)

# Catch2 v3
if({{REPLACE_ME_PROJECT_NAME}}_ENABLE_CATCH2_TESTS)
  # enable testing with CTest
  include(CTest)
  find_package(Catch2 QUIET)
  if(NOT Catch2_FOUND)
    include(FetchContent)
    FetchContent_Declare(
      Catch2
      GIT_REPOSITORY https://github.com/catchorg/Catch2.git
      GIT_TAG devel)
    FetchContent_MakeAvailable(Catch2)
    list(APPEND CMAKE_MODULE_PATH ${Catch2_SOURCE_DIR}/extras)
  endif()
  include(Catch)
endif()

if({{REPLACE_ME_PROJECT_NAME}}_ENABLE_CATCH2_TESTS)
  include(cmake/AddCatch2Tests.cmake)
  add_subdirectory(${CMAKE_PROJECT_NAME}/library/tests)
  add_subdirectory(${CMAKE_PROJECT_NAME}/app/tests)
endif()
