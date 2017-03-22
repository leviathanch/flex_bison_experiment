%{
#include <stdio.h>
extern char *yytext;
extern int yyget_lineno(void);
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

%start cluster
%%
addequiv:
	ADDEQUIV;

asps:
	| newline asps
	| aspub asplb
	| asplb aspub;

asplb:
	ASPLB FLOAT;

aspub:
	ASPUB FLOAT;

at:
	AT;

cellgroup:
	CELLGROUP;

class:
	| CLASS INTEGER;

cluster:
	| CLUSTER INTEGER name newline corners newline asps newline class orientations newline softpin newline instance newline pin;

connect:
	CONNECT;

corners:
	| CORNERS 	INTEGER nums;

nums:
	| INTEGER
	{printf("number %d\n",$1);}
	| INTEGER nums
	{printf("number %d\n",$1);}
;

current:
	CURRENT;

equiv:
	EQUIV;

fixed:
	FIXED;

from:
	FROM;

hardcell:
	HARDCELL;

instance:
	| INSTANCE STRING newline corners newline asps newline class orientations newline softpin
	| instance instance
	| instance newline;

keepout:
	KEEPOUT;

layer:
	LAYER;

name:
	| NAME STRING;

neighborhood:
	NEIGHBORHOOD;

no_layer_change:
	NO_LAYER_CHANGE;

nonfixed:
	NONFIXED;

nopermute:
	NOPERMUTE;

orient :
	ORIENT;

orientations:
	| ORIENTATIONS nums;

pad:
	PAD;

padgroup:
	PADGROUP;

permute:
	PERMUTE;

softpin:
	| SOFTPIN name signal
	| SOFTPIN name signal newline softpin;

pin:
	| PIN name signal;

pin_group:
	PINGROUP;

power:
	POWER;

restrict:
	RESTRICT;

side:
	SIDE;

sidespace:
	SIDESPACE;

signal:
	| SIGNAL STRING;

softcell:
	SOFTCELL;


supergroup:
	SUPERGROUP;

timing:
	TIMING;

newline:
	| newline newline
	| NEWLINE;

%%

int yyerror(char *s) {
	printf("error: %s at %s, line %d\n", s, yytext, yyget_lineno());
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

