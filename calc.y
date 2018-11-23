%{
    #include <stdio.h>
    #include <math.h>
	#include <string.h>

	#include "dict.h"
	
    void yyerror(char *);
    int yylex(void);
	void exit(int);

	Dict_f varibles;

%}


%union {
	int ival;
	float fval;
	char* id;
}

%token<ival> INTEGER
%token<fval> FLOAT

%token VARIABLE_NAME
%token KEYWORD_VAR
%token KEYWORD_QUIT

%left '+' '-' '*' '/' '^'

%type<fval> float_expression
%type<fval> assignment
%type<fval> variable_declaration
%type<id> VARIABLE_NAME

%%

program:
    program statement '\n'
    | /* NULL */
    ;
statement:
	| assignment				{ printf("Result: %f\n\n", $1); }
	| float_expression    		{ printf("Result: %f\n\n", $1); }
	| variable_declaration  	{ printf("Variable declared: %f\n\n", $1); }
	| KEYWORD_QUIT				{ printf("Bye!\n"); exit(0); }
    ;
float_expression:
	FLOAT
	| INTEGER 								{ $$ = (float)$1; }
	| VARIABLE_NAME 						{ $$ = DictSearch(varibles, $1); }
	| '+' float_expression        			{ $$ = $2; }
	| '-' float_expression        			{ $$ = -$2; }
    | float_expression '+' float_expression { $$ = $1 + $3; }
    | float_expression '-' float_expression { $$ = $1 - $3; }
    | float_expression '*' float_expression { $$ = $1 * $3; }
    | float_expression '/' float_expression { $$ = $1 / $3; }
    | float_expression '^' float_expression { $$ = pow($1, $3); }
    | '(' float_expression ')'        		{ $$ = $2; }
	;
variable_declaration:
	KEYWORD_VAR VARIABLE_NAME '=' float_expression 	{ DictInsert(varibles, $2, $4); $$ = $4; }
	;
assignment:
	VARIABLE_NAME '=' float_expression  		{ $$ = DictAlter(varibles, $1, $3); }
	;

%%

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}
int main(void) {

	varibles = DictCreate();

    yyparse();
}