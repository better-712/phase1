result:main.cpp driver.cpp parser.cpp lexer.cpp
    g++ -o result main.cpp driver.cpp parser.cpp lexer.cpp
parser.cpp:parser.y
    bison -o parser.cpp parser.y
lexer.cpp:lexer.l
    flex -o lexer.cpp lexer.l
