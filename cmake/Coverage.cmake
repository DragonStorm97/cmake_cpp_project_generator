function(enable_coverage APP_NAME)
  if({{REPLACE_ME_PROJECT_NAME}}_ENABLE_COVERAGE AND CMAKE_BUILD_TYPE STREQUAL "Debug")
    if(NOT ${PLATFORM} STREQUAL "Web")
      if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU" OR CMAKE_CXX_COMPILER_ID MATCHES ".*Clang")
        target_compile_options(${APP_NAME} PRIVATE -finstrument-functions -O0 -pg --coverage)
        target_link_libraries(${APP_NAME} PRIVATE --coverage)
      endif()
    endif()
  endif()
endfunction()
