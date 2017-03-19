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
%token NEWLINE

%type<ival> INTEGER
%type<fval> FLOAT
%type<sval> STRING

%type<sval> name

%start mcel
%%

mcel:
	cluster
;

cluster:
	| CLUSTER INTEGER name corners
	| CLUSTER INTEGER name asplb
	| CLUSTER INTEGER name aspub
	{
		printf("cluster ID: %d\n",$2);
	};

name:
	NAME STRING
	{
		printf("name: %s\n",$2);
	};

corners:
	newline CORNERS INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER asplb
	newline CORNERS INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER aspub
	{
		printf("corners %d %d %d %d %d %d %d %d %d\n", $3, $4, $5, $6, $7, $8, $9, $10, $11);
	};

asplb:
	| newline ASPLB FLOAT aspub
	| ASPLB FLOAT class;

aspub:
	| newline ASPUB FLOAT asplb
	| ASPUB FLOAT class;

class:
	newline CLASS INTEGER orientations;

orientations: ORIENTATIONS INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER softpin;

softpin:
	| newline SOFTPIN name signal

signal:
	| SIGNAL STRING softpin
	{
		printf("signal: %s\n",$2);
	};

newline: NEWLINE;

%%

int yyerror(char *s) {
	printf("error: %s at %s, line %d\n", s, yytext, yylineno);
}

int main(int argc,char *argv[]) {
	extern FILE *yyin;
	if(argc>0) {
		yyin = fopen ( argv[1],"r");
		if(yyin) {
			yyparse();
			fclose(yyin);
		} else {
			printf("File %s can not be opened! Exiting!\n",argv[1]);
			return -1;
		}
	} else {
		printf("No file name given! Exiting!\n");
		return -1;
	}
	return 0;
}

