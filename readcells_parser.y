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

%start mcel
%%
mcel:
	| cluster
;

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
	| CLASS INTEGER
	{
		printf("CLASS: %d\n",$2);
	};

cluster:
	| CLUSTER INTEGER name newline corners newline asps newline class orientations newline softpins newline instance
	{
		printf("cluster ID: %d\n",$2);
	};

connect:
	CONNECT;

corners:
	| CORNERS
	INTEGER
	INTEGER
	INTEGER
	INTEGER
	INTEGER
	INTEGER
	INTEGER
	INTEGER
	INTEGER
	INTEGER
	INTEGER
	INTEGER
	INTEGER

	| CORNERS
	INTEGER
	INTEGER
	INTEGER
	INTEGER
	INTEGER
	INTEGER
	INTEGER
	INTEGER
	INTEGER;

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
	| INSTANCE STRING newline corners newline asps newline class orientations newline softpins
	{
		printf("instance name: %s\n",$2);
	}
	| instance instance
	| instance newline;

keepout:
	KEEPOUT;

layer:
	LAYER;

name:
	| NAME STRING
	{
		printf("name: %s\n",$2);
	};

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
	| ORIENTATIONS INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER;

pad:
	PAD;

padgroup:
	PADGROUP;

permute:
	PERMUTE;

softpins:
	| SOFTPIN name signal
	| SOFTPIN name signal newline softpins
;
pins:
	| PIN name signal
	| PIN name signal newline pins
;

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
	| SIGNAL STRING
	{
		printf("signal: %s\n",$2);
	};

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

