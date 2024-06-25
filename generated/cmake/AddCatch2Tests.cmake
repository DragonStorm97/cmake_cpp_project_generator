# TODO: add docstring

function(add_catch2_tests app_name is_lib)
  if(coolProject_ENABLE_CATCH2_TESTS)
    set(test_name ${app_name}_tests)
    if(coolProject_ENABLE_GLOBS)
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
    target_compile_features(${test_name} PUBLIC cxx_std_20)
    target_compile_options(${test_name} PRIVATE ${DEFAULT_COMPILER_OPTIONS_AND_WARNINGS})

    # Add library as dependency
    target_include_directories(${test_name} PUBLIC ${PROJECT_SOURCE_DIR}/include/${CMAKE_PROJECT_NAME})
    target_link_libraries(${test_name} PRIVATE libcoolProject)
    target_include_directories(${test_name} PUBLIC ${PROJECT_SOURCE_DIR}/${CMAKE_PROJECT_NAME}/library/include)

    # add the app as a dependency if it's not the library
    if(NOT IS_LIB)
      target_include_directories(${test_name} PUBLIC ${PROJECT_SOURCE_DIR}/${CMAKE_PROJECT_NAME}/app/include)
    endif()

    target_link_libraries(${test_name} PRIVATE Catch2::Catch2WithMain)

    if(IS_LIB)
      catch_discover_tests(${test_name} TEST_PREFIX ${app_name} LABEL "LIB")
    else()
      catch_discover_tests(${test_name} TEST_PREFIX ${app_name} LABEL "app")
    endif()

  endif()
endfunction()
