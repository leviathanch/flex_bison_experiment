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
	| cluster
	| instance
	| softpin
	| corners
	| asplb
	| aspub
;

addequiv: ADDEQUIV;

asplb:
	| ASPLB FLOAT mcel;

aspub:
	| ASPUB FLOAT mcel;

at: AT;

cellgroup: CELLGROUP;

class:
	newline CLASS INTEGER orientations;

cluster:
	| CLUSTER INTEGER name mcel
	{
		printf("cluster ID: %d\n",$2);
	};

connect: CONNECT;

corners:
	| newline CORNERS INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER asplb
	| newline CORNERS INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER aspub
	| newline CORNERS INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER asplb
	| newline CORNERS INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER aspub
	| newline CORNERS INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER  INTEGER asplb
	| newline CORNERS INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER  INTEGER aspub
	{
		printf("corners %d %d %d %d %d %d %d %d %d\n", $3, $4, $5, $6, $7, $8, $9, $10, $11);
	};

current: CURRENT;

equiv: EQUIV;

fixed: FIXED;

from	: FROM;

hardcell: HARDCELL;

instance: newline INSTANCE STRING mcel;

keepout: KEEPOUT;

layer: LAYER;

name:
	| NAME STRING
	{
		printf("name: %s\n",$2);
	};

neighborhood: NEIGHBORHOOD;

no_layer_change: NO_LAYER_CHANGE;

nonfixed : NONFIXED;

nopermute : NOPERMUTE;

orient : ORIENT;

orientations: ORIENTATIONS INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER mcel;

pad : PAD;

padgroup : PADGROUP;

permute : PERMUTE;

pin : PIN;

pin_group : PINGROUP;

power : POWER;

restrict : RESTRICT;

side : SIDE;

sidespace : SIDESPACE;

signal:
	| SIGNAL STRING
	{
		printf("signal: %s\n",$2);
	};

softcell : SOFTCELL;

softpin:
	| newline SOFTPIN name signal mcel;

supergroup : SUPERGROUP;

timing : TIMING;

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
