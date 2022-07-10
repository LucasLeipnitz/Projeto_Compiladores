%{
#include <stdio.h>
int yylex(void);
void yyerror (char const *s);
%}

%start programa
%token TK_PR_INT
%token TK_PR_FLOAT
%token TK_PR_BOOL
%token TK_PR_CHAR
%token TK_PR_STRING
%token TK_PR_IF
%token TK_PR_THEN
%token TK_PR_ELSE
%token TK_PR_WHILE
%token TK_PR_DO
%token TK_PR_INPUT
%token TK_PR_OUTPUT
%token TK_PR_RETURN
%token TK_PR_CONST
%token TK_PR_STATIC
%token TK_PR_FOREACH
%token TK_PR_FOR
%token TK_PR_SWITCH
%token TK_PR_CASE
%token TK_PR_BREAK
%token TK_PR_CONTINUE
%token TK_PR_CLASS
%token TK_PR_PRIVATE
%token TK_PR_PUBLIC
%token TK_PR_PROTECTED
%token TK_PR_END
%token TK_PR_DEFAULT
%token TK_OC_LE
%token TK_OC_GE
%token TK_OC_EQ
%token TK_OC_NE
%token TK_OC_AND
%token TK_OC_OR
%token TK_OC_SL
%token TK_OC_SR
%token TK_LIT_INT
%token TK_LIT_FLOAT
%token TK_LIT_FALSE
%token TK_LIT_TRUE
%token TK_LIT_CHAR
%token TK_LIT_STRING
%token TK_IDENTIFICADOR
%token TOKEN_ERRO

%%

/*Recursão do programa*/
programa: lista;
lista: item lista | ;
item: variavel_global | funcao | chamada_func;

/*Auxiliares*/
tipo: TK_PR_INT | TK_PR_FLOAT | TK_PR_BOOL | TK_PR_CHAR | TK_PR_STRING ;
static: TK_PR_STATIC | ;
const: TK_PR_CONST | ;
vetor_global: '[' TK_LIT_INT ']' |  ;
vetor_indice: '[' expressao ']' | ;
parametro: const tipo TK_IDENTIFICADOR ;
literal: TK_LIT_INT | TK_LIT_FLOAT | TK_LIT_FALSE | TK_LIT_TRUE | TK_LIT_CHAR | TK_LIT_STRING ;
argumento: literal | TK_IDENTIFICADOR | expressao;

/*Definição de variáveis globais*/
variavel_global: static tipo lista_variaveis ';' ;
variavel: TK_IDENTIFICADOR vetor_global ;
lista_variaveis: variavel lista_variaveis_cauda ;
lista_variaveis_cauda: ',' lista_variaveis | ;

/*Definição de variáveis locais
	É parecido com C? (exemplo: int ab <= 1, c, abc <= 2 ;)
*/
variavel_local: static const tipo lista_variavel_local ';' ;
lista_variavel_local: TK_IDENTIFICADOR atribuicao lista_variavel_local_cauda ;
lista_variavel_local_cauda: ',' lista_variavel_local | ;
atribuicao: TK_OC_LE expressao | ;

/*Atribuição*/
atribuicao: TK_IDENTIFICADOR vetor_indice '=' expressao ';' ;

/*Entrada e saída*/
entrada: TK_PR_INPUT TK_IDENTIFICADOR ;
saida: TK_PR_OUTPUT TK_IDENTIFICADOR | TK_PR_OUTPUT literal ;
entrada_ou_saida: entrada ';' | saida ';' ;

/*Chamada de funções
	Pode receber literal? Pode receber vetor com indice?
*/
chamada_func: TK_IDENTIFICADOR '(' lista_argumentos ')' ';' ;
lista_argumentos: argumento lista_argumentos_cauda | ;
lista_argumentos_cauda: ',' argumento lista_argumentos_cauda | ;

/*Shift*/
shift: TK_IDENTIFICADOR vetor_indice shift_operador TK_LIT_INT;
shift_operador: TK_OC_SL | TK_OC_SR ;


/*Definição de funções*/
funcao: cabecalho corpo;
cabecalho: static tipo TK_IDENTIFICADOR '(' lista_parametros ')' ';' ;
corpo: ;
lista_parametros: parametro lista_parametros_cauda | ;
lista_parametros_cauda: ',' parametro lista_parametros_cauda | ;

/*Expressão*/
expressao : expressao_aritimetica | expressao_logica ;
expressao_aritimetica: literal ;
expressao_logica: literal ;


%%

void yyerror (char const *s){
	printf("error\n");
}
