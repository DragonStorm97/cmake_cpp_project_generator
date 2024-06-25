# C++ Project Template

Basically just this: [catch2-examples](https://github.com/Toxe/catch2-examples)

## To-Do

- Update setup.sh
  - REPLACE_ME_PROJECT_NAME
  - REPLACE_ME_APP_NAME
  - REPLACE_ME_LIB_NAME
  - REPLACE_ME_STD_VERSION
  - Single vs multi-binary test output
  - src as lib or app
    - have the templates in `src/REPLACE_ME_LIB_NAME` and `src/REPLACE_ME_APP_NAME`
  - `include/` folder
  - Some menu for adding more project libraries?
  - Some menu for adding more dependencies?
  - Some way to set output directory
- `src` CMakeLists.txt
- `tests` CMakeLists.txt
- GitHub Actions Workflow
- compile_commands.json (make sure it's generated) OR clang options file
- make [fetchcontent-able](https://www.foonathan.net/2022/06/cmake-fetchcontent/)
- make `app` folder actually be `apps` folder, then build them each as independent executables!

## CMake vars

- {{REPLACE_ME_PROJECT_NAME}}\_ENABLE_GLOBS
  Set if we just want to use the default templated CMakeLists.txt to glob all source files under their directory.
- {{REPLACE_ME_PROJECT_NAME}}\_ENABLE_CATCH2_TESTS

## Tests

Tests are run as one executable for app and another for library.

<!--TODO: make them separate executables? https://github.com/Toxe/catch2-examples/blob/master/src/catch2v3/multiple_test_files/CMakeLists.txt but with that glob?-->

## Source

## Gitea/GitHub Actions (Workflow)

[with CTest](https://github.com/ENCCS/catch2-demo/blob/main/.github/workflows/test.yml)

## Building and Compiling

- `./setup.sh`
- `cmake --preset=default -DCMAKE_BUILD_TYPE=Debug -DENABLE_CATCH2_TESTS=ON -DENABLE_GLOBS=ON`
  add {{REPLACE_ME_PROJECT_NAME}}\_ before the opts
- `ninja -C build/default -j 24`
- cd build/default && ctest -C Debug --output-on-failure --verbose

## Project Structure

- `include/project_name`
  The public include folder for the library
  - `project_name`
    - `app`
      The main executable for the project (Could just be a demo app for the library)
      - `include`
        private includes for the App.
      - `src`
        App source files.
      - `tests`
        Catch2 test sources for the App.
    - `library`
      The main library for the project.
      - `include`
        private includes for the Lib.
      - `src`
        Lib source files.
      - `tests`
        Catch2 test sources for the Lib.
