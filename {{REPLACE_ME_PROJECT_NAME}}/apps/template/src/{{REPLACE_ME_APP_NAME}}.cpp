#include "{{REPLACE_ME_APP_NAME}}.hpp"
#include "{{REPLACE_ME_LIB_NAME}}.hpp"
#include "{{REPLACE_ME_PROJECT_NAME}}.hpp"
#include <iostream>
#include <string>

#include "raylib.h"
#include <cmath>
#if defined(PLATFORM_WEB)
#include <emscripten.h>
#endif

void UpdateDrawFrame()
{
  const double time = GetTime();

  BeginDrawing();

  ClearBackground(Color{
      .r = static_cast<unsigned char>((sin(time * 3.14 * .25) + 1) / 2 * 0xff),
      .g = static_cast<unsigned char>((sin((time + 3.14) * 3.14 * .25) + 1) / 2 * 0xff),
      .b = static_cast<unsigned char>((sin((time + 3.14 / 2) * 3.140 * .25) + 1) / 2 * 0xff),
      .a = 255});

  EndDrawing();
}

int main()
{
  const auto val = libfunc() + appfunc();
  std::cout << "Hello, World! " << val << std::endl;

  InitWindow(640, 480, "Hello, Raylib");

#if defined(PLATFORM_WEB)
  // emscripten_set_main_loop_arg(&UpdateDrawFrame, &parm, 60, 1);
  emscripten_set_main_loop(UpdateDrawFrame, 60, 1);
#else
  SetTargetFPS(60);

  bool should_quit = false;
  while (!should_quit) {
    if (WindowShouldClose() || IsKeyPressed(KEY_ESCAPE)) {
      should_quit = true;
    }
    UpdateDrawFrame();
  }
#endif

  CloseWindow();
  return val;
}
