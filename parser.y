/* file: parser.y */

/* 使用指令％skeleton "lalr1.cc"选择C++解析器的骨架 */
%skeleton "lalr1.cc"

/* 指定bison的版本 */
%require "3.0.4"

%define api.namespace {Marker} //声明命名空间与下面声明的类名结合使用 Marker::Parser::  在scanner.l中有体现
%define parser_class_name { Parser }
%define api.token.constructor
%define api.value.type variant //使得类型与token定义可以使用各种复杂的结构与类型
%define parse.assert  //开启断言功能
%defines  //生成各种头文件  location.hh position.hh  parser.hpp
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
    class Scanner;
    class Driver;
  }
}

%code top
{
  /*尽可能放在parser.cpp靠近头部的地方，与requires相似*/
  #include <iostream>
  #include "scanner.h"
  #include "parser.hpp"
  #include "driver.h"
  #include "location.hh"

  /*注意：这里的参数由%parse-param决定*/
  static Marker::Parser::symbol_type yylex(Marker::Scanner& scanner,Marker::Driver &driver){
    return scanner.nextToken();
  }
  using namespace Marker;
}

/*定义parser传给scanner的参数*/
%lex-param { Marker::Scanner& scanner }
%lex-param { Marker::Driver& driver }

/*定义driver传给parser的参数*/
%parse-param { Marker::Scanner& scanner }
%parse-param { Marker::Driver& driver }

%locations
//%define parse-trace

/*详细显示错误信息*/
%define parse.error verbose

/*通过Marker::Parser::make_XXX(loc)给token添加前缀*/
%define api.token.prefix {TOKEN_}

%token <string>RPAREN
%token <string>IDENTIFIER
%token <float>NUMBER

%token EOL
%token END 0
%token PLUS MINUS MUL DIV

%left PLUS "+"
%left MINUS "-"
%left MUL "*"
%left DIV "/"


%type <float> Exp calclist 

%start calclist

%%
calclist: %empty{}
    | calclist Exp EOL{cout << "=" << $1 << "\n>";}
        ;

Exp : NUMER {$$=$1;}
    | Exp PLUS Exp{ $$ = $1 + $3; }
    | Exp MINUS Exp{ $$ = $1 - $3; }
    | Exp MUL Exp{ $$ = $1 * $3; }
    | Exp DIV Exp{ $$ = $1 / $3; }
    ;

%%
/*Parser实现错误处理接口*/
void Marker::Parser::error(const Marker::location& location,const std::string& message){
  std::cout<<"msg:"<<message
           <<", error happened at: "<<location<<std::endl;
}
