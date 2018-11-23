    /* calculator */
%{
    #include "calc.tab.h"
    #include <math.h>
    #include <stdlib.h>
    void yyerror(char *);
%}

%%

var {
    return KEYWORD_VAR;
}

(quit)|(exit)|(bye) {
    return KEYWORD_QUIT;
}

[a-zA-Z]+[0-9]*[a-zA-Z]* {
    yylval.id = strdup(yytext);
    return VARIABLE_NAME;
}

[1-9][0-9]* { 
    yylval.ival = atoi(yytext);
    return INTEGER;
}

[1-9][0-9]*\.[0-9]+ 	{
    yylval.fval = atof(yytext);
    return FLOAT;
}

[-+*/^()=;\n] { 
    return *yytext; 
}

[ \t]   ; /* skip whitespace */

.          {
    yyerror("Unknown Character");
}

%%

int yywrap(void) {
    return 1;
}