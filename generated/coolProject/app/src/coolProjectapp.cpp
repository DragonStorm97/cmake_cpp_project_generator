#include "coolProject.hpp"
#include "coolProjectapp.hpp"
#include "libcoolProject.hpp"
#include <iostream>

int main()
{
  const auto val = libfunc() + appfunc();
  std::cout<<"Hello, World! "<<val<<std::endl;
  return val;
}

