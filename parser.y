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
  #include <string>
  #include <vector>
  #include <stdint.h>
  #include <cmath>
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
%token <Info *> INT
%token <Info *> FLOAT
%token <Info *> CHAR
%token <Info *> TYPE ID
%token <Info *> STRUCT IF ELSE WHILE RETURN
%token <Info *> ASSIGN
%token <Info *> DOT SEMI COMMA
%token <Info *> EQ LE LT GE GT NE
%token <Info *> PLUS MINUS MUL DIV
%token <Info *> AND OR NOT
%token <Info *> LP RP LC RC LB RB
%token <Info *> ERROR


%%
list:INT{std::cout<<"hhhhhhhhhh"<<std::endl;}
    |FLOAT
    |CHAR
    |TYPE
    |ID
    |STRUCT
    |IF
    |ELSE
    |WHILE
    |RETURN
    |ASSIGN
    |DOT
    |SEMI
    |COMMA
    |LP
    |RP
    |LC
    |RC
    |LB
    |RB
    |AND
    |OR

%%
/*Parser实现错误处理接口*/
void Marker::Parser::error(const location_type &l,const std::string& message){
  std::cout<<"msg:"<<message
           <<", error happened at: "<<l.begin<<std::endl;
}
