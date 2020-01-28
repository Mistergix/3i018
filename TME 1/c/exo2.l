/* -*- mode: C; -*-
 * lex -oexo2.c exo2.l
 * gcc -o exo2 exo2.c -ll
 * ./exo2
 */
%{

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

enum _token {
  TYPE_a, TYPE_b, TYPE_c, TYPE_d, TYPE_e, TYPE_f, TYPE_g, TYPE_h, TYPE_i,
  TYPE_j, TYPE_k, TYPE_l, TYPE_m, TYPE_n, FIN
};

long yylval;

%}

SEPARATEUR      [ \n\t]

Ra	[bB][eE][gG][iI][nN]
Rb	(0|1)+
Rc	0[0-7]*
Rd	-?(\.[0-9]+|[0-9]+\.|[0-9]+|[0-9]+\.[0-9]+)([eE][\+\-]?[0-9]+)?
Re	[a-z]*1[a-z]*2[a-z]*3[a-z]*4[a-z]*
Rf	[e-z]*a[e-z]*b[e-z]*c[e-z]*d[e-z]*
Rg	[abd-z][a-z]*
Rh	([a-z][0-9])+
Ri	([a-df-z]|ee)+
Rj	(ee)?([a-df-z]+(ee)?)+|ee
Rk	"/*"([^*]*|"*"+[^*/]+)*"*"+"/"
Rl	[ac-z]+|[b-z]+
Rm	[a-df-zA-DF-Z]+|[a-df-zA-DF-Z]*(e|E)[a-df-zA-DF-Z]*
Rn	[d-z]*a?[d-z]*b?[d-z]*c?[d-z]*

%%

{SEPARATEUR}+ {}

{Ra} {
  yylval = (long)strdup( yytext);
  return(TYPE_a);
}

{Rb} {
  yylval = (long)strdup( yytext);
  return(TYPE_b);
}

{Rc} {
  yylval = (long)strdup( yytext);
  return(TYPE_c);
}

{Rd} {
  yylval = (long)strdup(yytext);
  return(TYPE_d);
}

{Re} {
  yylval = (long)strdup( yytext);
  return(TYPE_e);
}

{Rf} {
  yylval = (long)strdup( yytext);
  return(TYPE_f);
}

{Rg} {
  yylval = (long)strdup( yytext);
  return(TYPE_g);
}

{Rh} {
  yylval = (long)strdup( yytext);
  return(TYPE_h);
}

{Rj} {	/* Warning repéré par lex : plus particulier que Ri.
	   A mettre donc devant Ri */
  yylval = (long)strdup( yytext);
  return(TYPE_j);
}

{Ri} {
  yylval = (long)strdup( yytext);
  return(TYPE_i);
}

{Rk} {
  yylval = (long)strdup( yytext);
  return(TYPE_k);
}

{Rl} {
  yylval = (long)strdup( yytext);
  return(TYPE_l);
}

{Rm} {
  yylval = (long)strdup( yytext);
  return(TYPE_m);
}

{Rn} {
  yylval = (long)strdup( yytext);
  return(TYPE_n);
}

<<EOF>> {
  return(FIN);
}

%%

int main (void) {

  for (;;) {

    switch (yylex()) {
    case TYPE_a :
      printf("Expression Rationnelle Ra pour %s.\n", (char *)yylval);
      break;
    case TYPE_b :
      printf("Expression Rationnelle Rb pour %s.\n", (char *)yylval);
      break;
    case TYPE_c :
      printf("Expression Rationnelle Rc pour %s.\n", (char *)yylval);
      break;
    case TYPE_d :
      printf("Expression Rationnelle Rd pour %s.\n", (char *)yylval);
      break;
    case TYPE_e :
      printf("Expression Rationnelle Re pour %s.\n", (char *)yylval);
      break;
    case TYPE_f :
      printf("Expression Rationnelle Rf pour %s.\n", (char *)yylval);
      break;
    case TYPE_g :
      printf("Expression Rationnelle Rg pour %s.\n", (char *)yylval);
      break;
    case TYPE_h :
      printf("Expression Rationnelle Rh pour %s.\n", (char *)yylval);
      break;
    case TYPE_i :
      printf("Expression Rationnelle Ri pour %s.\n", (char *)yylval);
      break;
     case TYPE_j :
      printf("Expression Rationnelle Rj pour %s.\n", (char *)yylval);
      break;
    case TYPE_k :
      printf("Expression Rationnelle Rk pour %s.\n", (char *)yylval);
      break;
    case TYPE_l :
      printf("Expression Rationnelle Rl pour %s.\n", (char *)yylval);
      break;
    case TYPE_m :
      printf("Expression Rationnelle Rm pour %s.\n", (char *)yylval);
      break;
    case TYPE_n :
      printf("Expression Rationnelle Rn pour %s.\n", (char *)yylval);
      break;
    case FIN :
      printf("Il n'y a plus rien à lire.\n");
      return 0;
      break;
    default:;
    }
  }
}

