/* -*- mode: C; -*-
 * lex -oexo1.c exo1.l
 * gcc -o exo1 exo1.c -ll
 * ./exo1
 */
%{

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

enum _token {
    TYPE_A, TYPE_B, TYPE_C, TYPE_D, TYPE_E, FIN
};

long yylval;

%}

REA		(0|1)*
REB		(0*|1*)*
REC		0(0|1)*0
RED		0*10*10*10*
REE		([^xyz \n\t]*xyz[^xyz \n\t]*)*
SEPARATEUR	[ \n\t]

%%

{SEPARATEUR}+ {}

{REE} {	/* Langage ne contenant x, y et z que colle xyz */
  yylval = (long)strdup( yytext);
  return(TYPE_E);
}

{RED} {	/* Langage des binaires contenant exactement toujours 3 fois 1 */
  yylval = (long)strdup( yytext);
  return(TYPE_D);
}

{REC} {	/* Langage des binaires avec un 0 au debut et a la fin */
  yylval = (long)strdup( yytext);
  return(TYPE_C);
}

{REA} {	/* Langage des binaires */
  yylval = (long)strdup( yytext);
  return(TYPE_A);
}

{REB} {	/* ne passe jamais par ici, car meme motif que A. Detecte par Lex */
  yylval = (long)strdup( yytext);
  return(TYPE_B);
}

<<EOF>> {
  return(FIN);
}

%%

int main (void) {
  for (;;) {
    switch (yylex()) {
    case TYPE_A :
      printf("Expression Rationnelle (0|1)* pour %s.\n", (char *)yylval);
      break;
    case TYPE_B :
      printf("Expression Rationnelle (0*|1*)* pour %s.\n", (char *)yylval);
      break;
    case TYPE_C :
      printf("Expression Rationnelle 0(0|1)*0 pour %s.\n", (char *)yylval);
      break;
    case TYPE_D :
      printf("Expression Rationnelle 0*10*10*10* pour %s.\n", (char *)yylval);
      break;
    case TYPE_E :
      printf("Expression Rationnelle ([^xyz \\n\\t]*xyz[^xyz \\n\\t]*)* pour %s.\n", (char *)yylval);
      break;
    case FIN :
      printf("Il n'y a plus rien à lire.\n");
      return 0;
      break;
    default:;
    }
  }
}

