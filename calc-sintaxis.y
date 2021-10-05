%{

#include <stdlib.h>
#include <stdio.h>

int yylex();
int yyerror(char *);

%}
 
%union { int i; char *s;}
 
%token<i> INT 
%token<s> ID PROGRAM EXTERN WHILE BOOL INTEGER IF ELSE THEN VOID RETURN BTRUE BFALSE AND OR EQUAL

%left '+' '-'
%left '*''/''%'
%left '!'
%left UNARY
%nonassoc '<''>'EQUAL
%left AND OR

%%
program: PROGRAM '{' var_decls method_decls '}'  
       | PROGRAM '{' method_decls '}' 
       | PROGRAM '{' var_decls '}' 
       | PROGRAM '{' '}' 
;  

var_decls: var_decls var_decl  
         | var_decl
;

var_decl: type ides ';' ;

ides: ID ',' ides           
    | ID 
;

method_decls: method_decls method_decl
            | method_decl
;

method_decl: type_void '(' typeides ')' method_decl_final 
           | type_void '(' ')' method_decl_final 
;

type_void: type ID 
        | VOID ID 
;

method_decl_final: block
                 | EXTERN ';'
;

typeides: type ID ',' typeides { } 
        | type ID
;

block: '{' var_decls statements '}' { } 
     | '{' statements '}' 
     | '{' var_decls '}' 
     | '{' '}' 
;

statements: statement statements { }
          | statement
;

type: INTEGER
    | BOOL 
;

statement: ID '=' expr ';' 
         | method_call ';' 
         | if_stmt
         | WHILE expr block 
         | return_stmt
         | block 
         | ';' 
;

return_stmt: RETURN expr ';'
           | RETURN ';'
;

if_stmt: IF '(' expr ')' THEN block
       | IF '(' expr ')' THEN block ELSE block
;

method_call: ID '(' exprs ')'
           | ID '(' ')' 
;

exprs: exprs ',' expr
     | expr 
;

expr: ID
| method_decl_final
| method_call
| literal
| expr_bin
| '-' expr %prec UNARY
| '!' expr %prec UNARY
| '(' expr ')'
;

expr_bin: expr '+' expr
        | expr '-' expr
        | expr '*' expr
        | expr '/' expr
        | expr '%' expr
        | expr '<' expr
        | expr '>' expr
        | expr EQUAL expr
        | expr AND expr
        | expr OR expr
        ;

literal: INT 
       | BTRUE
       | BFALSE
;
%%
