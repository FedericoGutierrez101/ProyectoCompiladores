%{

#include <stdlib.h>
#include <stdio.h>
#include "utils/bitree.h"

int yylex();
int yyerror(char *);

nodeSt* symboltable;

%}
 
%union { int i; char *s; struct nodeTree *tn;}
 
%token<i> INT TTRUE TFALSE
%token<s> ID 
%token TINT TBOOL 
%token RETURN

%type<tn> VALUE expr decl stmt stmts decls prog return returns
%type<i> type

%left '+'  
%left '*'

 
%%
program: '{' var_decls method_decls '}' { } ;   

var_decls: var_decl var_decls { }
        | void
;

var_decl: type ides ';' { };

ides: id ',' ides { }
    | id { }
;

method_decls: method_decl method_decls { }
            | void 
;

method_decl : taip id '(' typeides ')' block { }
            | taip id '(' typeides ')' extern ; { }
;

taip: type { } 
    | void 
;

typeides: type id typeides2 { } 
        | void
;

typeides2: ',' type id typeides2 { }
        | void
;

block: '{' var_decls statements '}' { } ;

statements: statament statements { }
          | void 
;

type: integer { }
    | bool  { }
;

statement: id '=' expr ';' { }
         | method_call ';' { }
         | if '(' expr ')' then block elss { }
         | while expr block { }
         | return expr ';' { }
         | return void ';' { }
         | ;
         | block { }
;

elss: else block { }
    | void
;

method_call: id '(' exprs ')' { } ;

exprs: expr exprs2 { }
     | void 
;

expr2: ',' expr expr2 { }
     | void
;

expr: id { }
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

rel_op: '<' | '>' | '==' ;

cond_op: '&&' | '||' ;

literal: integer_litearal { }
        | bool_literal { }
;

integer_literal: digit integer_literal { }
               | digit;


digit: 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 ;

 
%%