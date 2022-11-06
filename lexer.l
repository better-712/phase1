/* file: lexer.h*/

%{
  #include <iostream>
  #include <cerrno>
  #include <climits>
  #include <cstdlib>
  #include <string>

  #include "parser.hpp"  //包含由parser.y生成的头文件
  #include "scanner.h"   //包含yyFlexLexer子类的头文件
  #include "location.hh" //包含位置调试信息头文件


  #undef  YY_DECL
  #define YY_DECL int Marker::Scanner::yylex( Marker::Parser::semantic_type * const lval, Marker::Parser::location_type *location )

  using token = Marker::Parser::token;
  
  #define YY_USER_ACTION loc.step();loc.columns (yyleng); 
  
  #define yyterminate() return( token::END )
%}



%option debug
%option nodefault
%option yylineno
%option yyclass="Marker::Scanner"
/* 支持调试 */
%option noyywrap 
%option c++

DIGIT                   [0-9]
ID                      [a-zA-Z_][0-9a-zA-Z_]*

DECIMAL_INT             ([1-9]{DIGIT}{0,9}|0)
HEX_INT                 0[xX]([1-9A-Fa-f][0-9A-Fa-f]*|0)

CHAR                    '.'
HEX_CHAR                '\\x[0-9A-Fa-f][0-9A-Fa-f]'

FLOAT                   {DIGIT}+"."{DIGIT}*

%%
%{
  yylval = lval;
%}

{DECIMAL_INT} {
	//std::cout << "DECIMAL_INT" << std::endl;
    yylval->build<Info*>(new Info(std::string(yytext), yylineno));
    return token::INT;
}

{HEX_INT} {
	//std::cout << "HEX_INT" << std::endl;
    yylval->build<Info*>(new Info(std::string(yytext), yylineno));
    return token::INT;
}

{CHAR}|{HEX_CHAR} {
	//std::cout << "{CHAR}|{HEX_CHAR}" << std::endl;
	  yylval->build<Info*>(new Info(std::string(yytext), yylineno));
    return token::CHAR;
}

{FLOAT} {
	//std::cout << "FLOAT" << std::endl;
    yylval->build<Info*>(new Info(std::string(yytext), yylineno));
    return token::FLOAT;
}

{ID} {
	//std::cout << "ID" << std::endl;
    yylval->build<Info*>(new Info(std::string(yytext), yylineno));
    return token::ID;
}

int|float|char {        // reserved type
	//std::cout << "int|float|char" << std::endl;
    yylval->build<Info*>(new Info(std::string(yytext), yylineno));
    return token::TYPE;
}

"struct" {             // reserved key word
	//std::cout << "struct" << std::endl;
    yylval->build<Info*>(new Info(std::string(yytext), yylineno));
    return token::STRUCT;
}

"if" {             // reserved key word
	//std::cout << "if" << std::endl;
    yylval->build<Info*>(new Info(std::string(yytext), yylineno));
    return token::IF;
}

"else" {             // reserved key word
	//std::cout << "else" << std::endl;
    yylval->build<Info*>(new Info(std::string(yytext), yylineno));
    return token::ELSE;
}

"while" {             // reserved key word
	//std::cout << "while" << std::endl;
    yylval->build<Info*>(new Info(std::string(yytext), yylineno));
    return token::WHILE;
}

"return" {             // reserved key word
	//std::cout << "return" << std::endl;
    yylval->build<Info*>(new Info(std::string(yytext), yylineno));
    return token::RETURN;
}


"." {
	//std::cout << "DOT" << std::endl;
	yylval->build<Info*>(new Info(std::string(yytext), yylineno));
    return token::DOT;
}

";" {
	//std::cout << "SEMI" << std::endl;
	yylval->build<Info*>(new Info(std::string(yytext), yylineno));
	return token::SEMI;
}

"," {
	//std::cout << "COMMA" << std::endl;
	yylval->build<Info*>(new Info(std::string(yytext), yylineno));
	return token::COMMA;
}

"=" {
	//std::cout << "ASSIGN" << std::endl;
	yylval->build<Info*>(new Info(std::string(yytext), yylineno));
	return token::ASSIGN;
}

"<" {
	//std::cout << "LT" << std::endl;
	yylval->build<Info*>(new Info(std::string(yytext), yylineno));
    return token::LT;
}

"<=" {
	//std::cout << "LE" << std::endl;
	yylval->build<Info*>(new Info(std::string(yytext), yylineno));
    return token::LE;
}

">" {
	//std::cout << "GT" << std::endl;
	yylval->build<Info*>(new Info(std::string(yytext), yylineno));
    return token::GT;
}

">=" {
	//std::cout << "GE" << std::endl;
	yylval->build<Info*>(new Info(std::string(yytext), yylineno));
    return token::GE;
}

"!=" {
	//std::cout << "NE" << std::endl;
	yylval->build<Info*>(new Info(std::string(yytext), yylineno));
    return token::NE;
}

"==" {
	//std::cout << "EQ" << std::endl;
	yylval->build<Info*>(new Info(std::string(yytext), yylineno));
	return token::EQ;
}

"+" {
	//std::cout << "PLUS" << std::endl;
	yylval->build<Info*>(new Info(std::string(yytext), yylineno));
	return token::PLUS;
}

"-" {
	//std::cout << "MINUS" << std::endl;
	yylval->build<Info*>(new Info(std::string(yytext), yylineno));
	return token::MINUS;
}

"*" {
	//std::cout << "MUL" << std::endl;
	yylval->build<Info*>(new Info(std::string(yytext), yylineno));
	return token::MUL;
}

"/" {
	//std::cout << "DIV" << std::endl;
	yylval->build<Info*>(new Info(std::string(yytext), yylineno));
	return token::DIV;
}

"&&" {
	//std::cout << "AND" << std::endl;
	yylval->build<Info*>(new Info(std::string(yytext), yylineno));
	return token::AND;
}

"||" {
	//std::cout << "OR" << std::endl;
	yylval->build<Info*>(new Info(std::string(yytext), yylineno));
	return token::OR;
}

"!" {
	//std::cout << "NOT" << std::endl;
	yylval->build<Info*>(new Info(std::string(yytext), yylineno));
    return token::NOT;
}

"("|")" {
	//std::cout << "LPRP" << std::endl;
	yylval->build<Info*>(new Info(std::string(yytext), yylineno));
	return yytext[0] == '(' ? token::LP : token::RP;
}

"["|"]" {
    //std::cout << "LBRB" << std::endl;
    yylval->build<Info*>(new Info(std::string(yytext), yylineno));
    return yytext[0] == '[' ? token::LB : token::RB;
}

"{"|"}" {
    //std::cout << "LCRC" << std::endl;
    yylval->build<Info*>(new Info(std::string(yytext), yylineno));
    return yytext[0] == '{' ? token::LC : token::RC;
}

[ \r\t\n]+ {
   
}

. {
    yylval->build<Info*>(new Info(std::string(yytext), yylineno));
    return token::ERROR;
}

%%
//这里可以放一些C或者C++代码
