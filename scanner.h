// file: scanner.h
// Created by cmp on 2020/5/11.
//

#ifndef FLEX_BISON_SCANNER_H
#define FLEX_BISON_SCANNER_H


#if !defined(yyFlexLexerOnce)

#include <FlexLexer.h>

#endif

#include "parser.hpp"
#include "location.hh"

namespace Marker {
  class Driver;

  class Scanner : public yyFlexLexer {
  private:
    /* data */
    Marker::Parser::semantic_type *yylval = nullptr;
    Marker::Parser::location_type *loc = nullptr;

  public:
    
    Scanner(std::istream *in) : yyFlexLexer(in){
    loc = new Marker::Parser::location_type();
    };

    using FlexLexer::yylex;
    virtual int yylex(Marker::Parser::semantic_type *const lval,
                       Marker::Parser::location_type *location);
    
  };
} 


#endif //FLEX_BISON_SCANNER_H
