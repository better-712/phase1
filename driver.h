// file:driver.h
// Created by cmp on 2020/5/11.
//

#ifndef FLEX_BISON_DRIVER_H
#define FLEX_BISON_DRIVER_H

#include <iostream>
#include "scanner.h"
#include "parser.hpp"

namespace Marker {
  class Driver {
  private:
    Parser parser;
    Scanner scanner;
  public:
    Driver():scanner{nullptr}, parser{nullptr}{};
    virtual ~Driver();

    void parse(const char *filename);

    virtual ~Driver();
  };
} /*Marker */
#endif //FLEX_BISON_DRIVER_H
