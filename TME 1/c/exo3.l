/* -*- mode: C; -*-
 * lex -oexo3.c exo3.l
 * gcc -o exo3 exo3.c -ll
 * ./exo2
 */

%x COND_COMMENTAIRE

%{

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

enum _token {
  TYPE_BEGIN, TYPE_BINAIRE, TYPE_OCTAL, TYPE_FLOTTANT, TYPE_1234, TYPE_abcd,
  FIN
};

long yylval;
int  nb_lignes = 0;
char chaine[1024];

%}

BEGIN		[bB][eE][gG][iI][nN]
BINAIRE		(0|1)+
OCTAL		0[0-7]*
FLOTTANT	-?(\.[0-9]+|[0-9]+\.|[0-9]+|[0-9]+\.[0-9]+)([eE][\+\-]?[0-9]+)?
RE1234		[a-z]*1[a-z]*2[a-z]*3[a-z]*4[a-z]*
REabcd		[e-z]*a[e-z]*b[e-z]*c[e-z]*d[e-z]*

SEPARATEUR	[ \t]

%%

\n { nb_lignes++; }

{SEPARATEUR}+ {}

{BEGIN} {
  yylval = (long)strdup( yytext);
  return(TYPE_BEGIN);
}

{BINAIRE} {
  yylval = (long)strdup( yytext);
  return(TYPE_BINAIRE);
}

{OCTAL} {
  yylval = (long)strdup( yytext);
  return(TYPE_OCTAL);
}

{FLOTTANT} {
  yylval = (long)strdup( yytext);
  return(TYPE_FLOTTANT);
}

{RE1234} {
  yylval = (long)strdup( yytext);
  return(TYPE_1234);
}

{REabcd} {
  yylval = (long)strdup( yytext);
  return(TYPE_abcd);
}

\/\*				{ chaine[0]='\0';
				  strcat(chaine, yytext);
				  BEGIN(COND_COMMENTAIRE);
				}
<COND_COMMENTAIRE>\n		{ strcat(chaine, yytext); nb_lignes++; }
<COND_COMMENTAIRE>[^*\n]+	{ strcat(chaine, yytext); }
<COND_COMMENTAIRE>"*"+[^\/\n]*	{ strcat(chaine, yytext); }
<COND_COMMENTAIRE>\**"*/"	{ strcat(chaine, yytext);
				  printf("Commentaire : %s.\n", chaine);
				  BEGIN(INITIAL);
				}

<<EOF>> {
  return(FIN);
}

%%


int main (void) {
  for (;;) {
    switch (yylex()) {
    case TYPE_BEGIN :
      printf("Expression Rationnelle BEGIN pour %s.\n", (char *)yylval);
      break;
    case TYPE_BINAIRE :
      printf("Expression Rationnelle BINAIRE pour %s.\n", (char *)yylval);
      break;
    case TYPE_OCTAL :
      printf("Expression Rationnelle OCTAL pour %s.\n", (char *)yylval);
      break;
    case TYPE_FLOTTANT :
      printf("Expression Rationnelle FLOTTANT pour %s.\n", (char *)yylval);
      break;
    case TYPE_1234 :
      printf("Expression Rationnelle 1234 pour %s.\n", (char *)yylval);
      break;
    case TYPE_abcd :
      printf("Expression Rationnelle abcd pour %s.\n", (char *)yylval);
      break;
    case FIN :
      printf("Nombre de lignes = %d.\nIl n'y a plus rien a lire.\n",
	     nb_lignes);
      return 0;
      break;
    default:;
    }
  }
}

