%{
#include "readcells_parser.h"
extern int yylineno;
%}

blanks		[ \t]+
newline		[\n]+
integer		[0-9]+
float			({integer}+[.]{integer}*)|({integer}*[.]{integer}+)
string		[_a-zA-Z0-9<>:$]+|[_a-zA-Z<>:$]+[.]

%%
addequiv			return ADDEQUIV;
asplb				return ASPLB;
aspub				return ASPUB;
at				return AT;
cellgroup			return CELLGROUP;
class				return CLASS;
cluster				return CLUSTER;
connect				return CONNECT;
corners				return CORNERS;
current				return CURRENT;
equiv				return EQUIV;
fixed				return FIXED;
from				return FROM;
hardcell			return HARDCELL;
instance			return INSTANCE;
keepout				return KEEPOUT;
layer				return LAYER;
name				return NAME;
neighborhood			return NEIGHBORHOOD;
no_layer_change			return NO_LAYER_CHANGE;
nonfixed			return NONFIXED;
nopermute			return NOPERMUTE;
orient				return ORIENT;
orientations			return ORIENTATIONS;
pad				return PAD;
padgroup 			return PADGROUP;
permute				return PERMUTE;
pin				return PIN;
pin_group			return PINGROUP;
power				return POWER;
restrict			return RESTRICT;
side				return SIDE;
sidespace			return SIDESPACE;
signal				return SIGNAL;
softcell			return SOFTCELL;
softpin				return SOFTPIN;
supergroup			return SUPERGROUP;
timing				return TIMING;

{newline}+			{yylineno++; return NEWLINE;}
{blanks}+			{};
{integer}+			{yylval.ival = atoi(yytext); return INTEGER;};
{string}+			{yylval.sval = yytext; return STRING;}
{float}+			{yylval.fval = atof(yytext); return FLOAT;}
