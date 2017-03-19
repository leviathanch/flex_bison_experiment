%{
#include <stdio.h>
extern char *yytext;
extern int yylineno;
%}

%union {
	int ival;
	float fval;
	char *sval;
}

%token ADDEQUIV
%token ASPLB
%token ASPUB
%token AT
%token CELLGROUP
%token CLASS
%token CLUSTER
%token CONNECT
%token CORNERS
%token CURRENT
%token EQUIV
%token FIXED
%token FROM
%token HARDCELL
%token INSTANCE
%token KEEPOUT
%token LAYER
%token NAME
%token NEIGHBORHOOD
%token NO_LAYER_CHANGE
%token NONFIXED
%token NOPERMUTE
%token ORIENT
%token ORIENTATIONS
%token PAD
%token PADGROUP
%token PERMUTE
%token PIN
%token PINGROUP
%token POWER
%token RESTRICT
%token SIDE
%token SIDESPACE
%token SIGNAL
%token SOFTCELL
%token SOFTPIN
%token SUPERGROUP
%token TIMING

%token INTEGER
%token FLOAT
%token STRING

%type<ival> INTEGER
%type<fval> FLOAT
%type<sval> STRING

%start mcel
%%
mcel:
	| cluster
;

cluster:
	CLUSTER INTEGER NAME STRING
	{
		printf("ID: %d\n",$2);
		printf("Name: %s\n",$4);
	};
corners:
	CORNERS INTEGER
	{
	};

%%

int yyerror(char *s) {
	printf("error: %s at %s, line %d\n", s, yytext, yylineno);
}

int main(void) {
	yyparse();
}

