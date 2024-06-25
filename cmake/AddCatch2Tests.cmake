# TODO: add docstring

function(add_catch2_tests app_name is_lib)
  if({{REPLACE_ME_PROJECT_NAME}}_ENABLE_CATCH2_TESTS)
    set(test_name ${app_name}_tests)
    if({{REPLACE_ME_PROJECT_NAME}}_ENABLE_GLOBS)
      file(
        GLOB_RECURSE
        sources
        CONFIGURE_DEPENDS
        "*.cpp")
    else()
      set(sources "${test_name}.cpp")
    endif()

    add_executable(${test_name} ${sources})

    set_target_properties(${test_name} PROPERTIES CXX_EXTENSIONS OFF)
    target_compile_features(${test_name} PUBLIC cxx_std_{{REPLACE_ME_STD_VERSION}})
    target_compile_options(${test_name} PRIVATE ${DEFAULT_COMPILER_OPTIONS_AND_WARNINGS})

    # Add library as dependency
    target_include_directories(${test_name} PUBLIC ${PROJECT_SOURCE_DIR}/include/${CMAKE_PROJECT_NAME})
    target_link_libraries(${test_name} PRIVATE {{REPLACE_ME_LIB_NAME}})
    target_include_directories(${test_name} PUBLIC ${PROJECT_SOURCE_DIR}/${CMAKE_PROJECT_NAME}/library/include)

    # add the app as a dependency if it's not the library
    if(NOT IS_LIB)
      target_include_directories(${test_name} PUBLIC ${PROJECT_SOURCE_DIR}/${CMAKE_PROJECT_NAME}/apps/${app_name}/include)
    endif()

    target_link_libraries(${test_name} PRIVATE Catch2::Catch2WithMain)

    catch_discover_tests(${test_name} LABEL ${app_name})

  endif()
endfunction()
