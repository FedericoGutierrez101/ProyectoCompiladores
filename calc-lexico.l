%{

#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#include "calc-sintaxis.tab.h"
int yyparse();

%}

%option noyywrap
%option yylineno

letter [a-zA-Z]
digit [0-9]

%%

{digit}+                          { yylval.i = atoi(yytext);
                                printf("INT : %d\n",atoi(yytext)); 
                                return INT;}

"&&"                            { printf("AND: %s\n",yytext);
                                return AND; }

"||"                            { printf("OR: %s\n",yytext);
                                return OR; }

"=="                           { printf("EQUAL: %s\n",yytext);
                                return EQUAL; }

"Program"                       { printf("PROGRAM: %s\n",yytext);
                                return PROGRAM; }

"integer"                       { printf("INTEGER: %s\n",yytext);
                                return INTEGER; }

"bool"                          { printf("BOOL: %s\n",yytext);
                                return BOOL; }

"extern"                        { printf("EXTERN: %s\n",yytext);
                                return EXTERN; }

"while"                        { printf("WHILE: %s\n",yytext);
                                return WHILE; }

"return"                       { printf("RETURN: %s\n",yytext);
                                return RETURN; }

"if"                          { printf("IF: %s\n",yytext);
                                return IF; }

"then"                        { printf("THEN: %s\n",yytext);
                                return THEN; }

"else"                        { printf("ELSE: %s\n",yytext);
                                return ELSE; }

"void"                        { printf("VOID: %s\n",yytext);
                                return VOID; }

"true"                        { printf("BOOLEAN TRUE: %s\n",yytext);
                               return BTRUE; }

"false"                       { printf("BOOLEAN FALSE: %s\n",yytext);
                               return BFALSE; }

{letter}({letter}|{digit}|_)* { yylval.s=(char *) malloc(sizeof(yytext)*yyleng);
                                strcpy(yylval.s,yytext);
                                printf("ID : %s\n",yytext);
                                return ID;}

[;()={},-<>+/*%]               { printf("SYMBOL: %s\n",yytext);
                                 return *yytext;}

[/][*][^*]*[*]+([^*/][^*]*[*]+)*[/]       { /* Nada */ }
[/][*]                                    { yy_fatal_error("comentario sin terminar"); }

"//".*\n                       {/* comentario */}

.|\n                          ; /* ignore all the rest */

%%

void yyerror(){
	printf("%s%d\n","-> SINTAX ERROR at line: ",yylineno);
}

int main(int argc,char *argv[]){
	++argv,--argc;
	if (argc > 0)
		yyin = fopen(argv[0],"r");
	else
		yyin = stdin;

	yyparse();

}
