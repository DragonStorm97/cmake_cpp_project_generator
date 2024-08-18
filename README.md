# C++ Project Template

Basically just this: [catch2-examples](https://github.com/Toxe/catch2-examples)

## To-Do

- Update setup.sh
  - REPLACE_ME_PROJECT_NAME
  - REPLACE_ME_APP_NAME
  - REPLACE_ME_LIB_NAME
  - REPLACE_ME_STD_VERSION
  - Single vs multi-binary test output
  - Some menu for adding more project libraries?
  - Some menu for adding more dependencies?
  - Some way to set output directory
- make [fetchcontent-able](https://www.foonathan.net/2022/06/cmake-fetchcontent/)
- Refine cicd workflow preset
- update cicd build-and-test workflow to use a matrix
- CPack/Packaging workflow
- Extra Libraries (toggled with flags, and using emscripten ports where possible)
- Ability to add more libraries? (maybe one primary shared library,
  then multiple private, or remove public include and have each library be shared?
  BAD might accidentally make libraries depend on each other)
- Actually enable the sanitizers/StaticAnalyzers in builds
  - clang-tidy?
  - cppcheck?
- CMAKE_PROJECT_NAME(top level project name) vs PROJECT_NAME(name given with the project setting)!
- PLATFORM (from raylib): `enum_option(PLATFORM "Desktop;Web;Android;Raspberry Pi;DRM;SDL" "Platform to build for.")`

## Features

- src as lib or app
  - have the templates in `src/REPLACE_ME_LIB_NAME` and `src/REPLACE_ME_APP_NAME`
  - `include/` folder
- GitHub Actions Workflow
- compile_commands.json (make sure it's generated) OR clang options file
- make `app` folder actually be `apps` folder, then build them each as independent executables!
- Add emscripten as a dependency if PLATFORM==Web

## CMake vars

- `{{REPLACE_ME_PROJECT_NAME}}_ENABLE_RAYLIB`
- `{{REPLACE_ME_PROJECT_NAME}}_ENABLE_GLOBS`
  Set if we just want to use the default templated CMakeLists.txt to glob all source files under their directory.
- `{{REPLACE_ME_PROJECT_NAME}}_ENABLE_CATCH2_TESTS`
- `{{REPLACE_ME_PROJECT_NAME}}_ENABLE_FLECS`

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
- `cmake --build ./build/default`
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
