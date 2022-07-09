%{
#include "tokens.h"
int num_lines = 1;
%}

%option noyywrap

white [ \t]+
digitos [0-9]
caracteres [a-zA-Z]
caracteres_especiais [,;:()\[\]\{\}+\-\|\*\/<>=!&%#^\.$]
negate [^'*/']

%%

"\n" {num_lines++;} 

{white} { }
{digitos}+ { return TK_LIT_INT;}
{digitos}+"."({digitos}+|{digitos}+("E"|"e"){digitos}+) { return TK_LIT_FLOAT;}
"-"{digitos}+ { return TK_LIT_INT;}
"-"{digitos}+"."({digitos}+|{digitos}+("E"|"e"){digitos}+) { return TK_LIT_FLOAT;}
"\""({caracteres}|{digitos}|{caracteres_especiais}|" "|"_")+"\"" { return TK_LIT_STRING;}
"'"({caracteres}|{digitos}|{caracteres_especiais})"'" { return TK_LIT_CHAR;}
"true" { return TK_LIT_TRUE;}
"false" { return TK_LIT_FALSE;}

{caracteres_especiais} {int ascii = (int) yytext[0]; return ascii;}
"//"(.*)|"/*"((\*+[^/*])|([^*]))*\**"*/" { int controle = 0; while(yytext[controle] != '\0'){ if(yytext[controle] == '\n'){num_lines++;} controle++;};}

"int" {return TK_PR_INT;}
"float" {return TK_PR_FLOAT;}
"bool" {return TK_PR_BOOL;}
"char" {return TK_PR_CHAR;}
"string" {return TK_PR_STRING;}
"if" {return TK_PR_IF;}
"then" {return TK_PR_THEN;}
"else" {return TK_PR_ELSE;}
"while" {return TK_PR_WHILE;}
"do" {return TK_PR_DO;}
"input" {return TK_PR_INPUT;}
"outp" {return TK_PR_OUTPUT;}
"return" {return TK_PR_RETURN;}
"const" {return TK_PR_CONST;}
"static" {return TK_PR_STATIC;}
"foreach" {return TK_PR_FOREACH;}
"for" {return TK_PR_FOR;}
"switch" {return TK_PR_SWITCH;}
"case" {return TK_PR_CASE;}
"break" {return TK_PR_BREAK;}
"continue" {return TK_PR_CONTINUE;}
"class" {return TK_PR_CLASS;}
"private" {return TK_PR_PRIVATE;}
"public" {return TK_PR_PUBLIC;}
"protected" {return TK_PR_PROTECTED;}
"end" {return TK_PR_END;}
"default" {return TK_PR_DEFAULT;}

"<=" {return TK_OC_LE;}
">=" {return TK_OC_GE;}
"==" {return TK_OC_EQ;}
"!=" {return TK_OC_NE;}
"&&" {return TK_OC_AND;}
"||" {return TK_OC_OR;}
">>" {return TK_OC_SL;}
"<<" {return TK_OC_SR;}

({caracteres}|"_")(({caracteres}|{digitos})*) { return TK_IDENTIFICADOR;}

. { return TOKEN_ERRO;}

%%

int get_line_number (void){
	return num_lines;
}
