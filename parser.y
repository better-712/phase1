/* file: parser.y */

/* 使用指令％skeleton "lalr1.cc"选择C++解析器的骨架 */
%skeleton "lalr1.cc"

/* 指定bison的版本 */
%require "3.0.4"

%defines  //生成各种头文件  location.hh position.hh  parser.hpp
%define api.namespace {Marker} //声明命名空间与下面声明的类名结合使用 Marker::Parser::  在scanner.l中有体现
%define parser_class_name { Parser }


%code requires
{
  /*requires中的内容会放在YYLTYPE与YYSTPYPE定义前*/
  #include <iostream>
  #include <string>
  #include <vector>
  #include <stdint.h>
  #include <cmath>
  using namespace std;

  namespace Marker { /*避免包含头文件时冲突*/
    class Info;
    class Scanner;
    class Driver;
  }
}


/*定义parser传给scanner的参数*/
%lex-param { Marker::Scanner& scanner }
%lex-param { Marker::Driver& driver }

/*定义driver传给parser的参数*/
%parse-param { Marker::Scanner& scanner }
%parse-param { Marker::Driver& driver }

%code top
{
  #include <fstream>
  #include <iostream>
  #include "scanner.h"
  #include "parser.hpp"
  #include "driver.h"
  #include "location.hh"
  

#undef yylex
#define yylex scanner.yylex

}


%define api.value.type variant //使得类型与token定义可以使用各种复杂的结构与类型
%define parse.assert  //开启断言功能
%language "C++"
%locations


/*详细显示错误信息*/
%define parse.error verbose




%token               END    0     "end of file"
%token <Scan_Info *> INT
%token <Scan_Info *> FLOAT
%token <Scan_Info *> CHAR
%token <Scan_Info *> TYPE ID
%token <Scan_Info *> STRUCT IF ELSE WHILE RETURN
%token <Scan_Info *> ASSIGN
%token <Scan_Info *> DOT SEMI COMMA
%token <Scan_Info *> EQ LE LT GE GT NE
%token <Scan_Info *> PLUS MINUS MUL DIV
%token <Scan_Info *> AND OR NOT
%token <Scan_Info *> LP RP LC RC LB RB
%token <Scan_Info *> ERROR

%%

%%
/*Parser实现错误处理接口*/
void Marker::Parser::error(const Marker::location& location,const std::string& message){
  std::cout<<"msg:"<<message
           <<", error happened at: "<<location<<std::endl;
}
