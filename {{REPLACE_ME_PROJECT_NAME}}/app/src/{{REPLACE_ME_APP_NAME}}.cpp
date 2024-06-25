#include "{{REPLACE_ME_PROJECT_NAME}}.hpp"
#include "{{REPLACE_ME_APP_NAME}}.hpp"
#include "{{REPLACE_ME_LIB_NAME}}.hpp"
#include <iostream>

int main()
{
  const auto val = libfunc() + appfunc();
  std::cout<<"Hello, World! "<<val<<std::endl;
  return val;
}

