%{

#include <stdlib.h>
#include <stdio.h>

int yylex();
int yyerror(char *);


%}
 
%union { int i; char *s;}
 
%token<i> INT TTRUE TFALSE
%token<s> ID 

%left '<' '>' "=="
%left '*' '/' '%'
%left '+' '-'
%left "&&"
%left "||"


%%
program: "program" '{' var_decls method_decls '}' { } ;   

var_decls: var_decl var_decls { }
        | 
;

var_decl: type ides ';' { };

ides: ID ',' ides { }
    | ID { }
;

method_decls: method_decl method_decls { }
            |  
;

method_decl : taip ID '(' typeides ')' block { }
            | taip ID '(' typeides ')' "extern" ';' { }
;

taip: type { } 
    |  
;

typeides: type ID typeides2 { } 
        | 
;

typeides2: ',' type ID typeides2 { }
        | 
;

block: '{' var_decls statements '}' { } ;

statements: statement statements { }
          |  
;

type: "integer" { }
    | "bool"  { }
;

statement: ID '=' expr ';' { }
         | method_call ';' { }
         | "if" '(' expr ')' "then" block elss { }
         | "while" expr block { }
         | "return" expr ';' { }
         | "return"  ';' { }
         | ';' { }
         | block { }
;

elss: "else" block { }
    | 
;

method_call: ID '(' exprs ')' { } ;

exprs: expr expr2 { }
     |  
;

expr2: ',' expr expr2 { }
     | 
;

expr: ID { }
    | method_call { }
    | literal { }
    | expr bin_op expr { }
    | '-' expr { }
    | '!' expr { } 
    | '(' expr ')' { } 
;

bin_op: arith_op { }
      | rel_op { }
      | cond_op { }
;

arith_op: '+' | '-' | '*' | '/' | '%' ;

rel_op: '<' | '>' | "==" ;

cond_op: "&&" | "||" ;

literal: integer_literal { }
        | bool_literal { }
;

bool_literal: "true" { }
            | "false" { }
;
integer_literal: digit integer_literal { }
               | digit;


digit:INT;

 
%%