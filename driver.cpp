// file: driver.cpp
// Created by cmp on 2020/5/11.
//

#include "driver.h"
#include <iostream>
#include <fstream>

using namespace Marker;
using namespace std;

Driver::Driver() : _scanner{nullptr}, _parser{nullptr} {

}

Driver::~Driver() {

}

void Driver::parse(const char *filename) {
  assert(filename != nullptr);
  std::ifstream in_file(filename);
  _scanner = new Scanner(in_file);
  _parser = new Parser(*_scanner, *this);
  _parser.parse();
}
