%{

#include <stdlib.h>
#include <stdio.h>

int yylex();
int yyerror(char *);

%}
 
%union { int i; char *s;}
 
%token<i> INT 
%token<s> ID TMENOS BOOLEAN ARITHOP CONDOP RELOP PROGRAM EXTERN WHILE BOOL INTEGER IF ELSE THEN VOID RETURN

%left '<' '>' "==" '+' '*' '/' '%'
%left "&&"
%left "||"
%left '!'
%left '-'
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

return_stmt: RETURN expr
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

expr: terminal              
    | expr2 expr 
    | '(' expr ')' 
;

expr2: terminal ARITHOP    
     | terminal '-'    
     | terminal RELOP
     | terminal CONDOP
     | '-'                 
     | '!'
;

terminal: ID                
        | method_call 
        | literal
;

literal: INT 
       | BOOLEAN
;
%%
