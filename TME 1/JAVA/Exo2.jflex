/*
	Generer l'analyseur lexical :   jflex Exo2.jflex
	Compiler avec :                 javac Exo2.java
	Executer avec :                 java Exo2
*/

/* (I) codes utilisateur */

class Token {
      int    id;
      Object valeur_associee;

      Token (int id) {
      	    this.id         = id;
	    valeur_associee = null;
      }
      
      Token (int id, Object valeur_associee) {
      	    this.id              = id;
	    this.valeur_associee = valeur_associee;
      }

      int getId () {
      	  return id;
      }

      Object getValeur () {
      	  return valeur_associee;
      }
}


%%
          /* (II) Options et declarations */

%class Exo2
%unicode
%line
%column
%type Token

%{
static final int ID_FIN     = 0;
static final int ID_RE1     = 1;
static final int ID_RE2     = 2;
static final int ID_RE3     = 3;
static final int ID_RE4     = 4;
static final int ID_RE5     = 5;
static final int ID_RE6     = 6;
static final int ID_RE7     = 7;
static final int ID_RE8     = 8;
static final int ID_RE9     = 9;
static final int ID_RE10    = 10;
static final int ID_RE11    = 11;
static final int ID_RE12    = 12;
static final int ID_RE13    = 13;
static final int ID_RE14    = 14;
static final int ID_INCONNU = 15;
%}

%{
public static void main(String argv[]) {
  Exo2 analyseur = new Exo2(new java.io.InputStreamReader(System.in));

  try {
    Token lu = analyseur.yylex();

    while (lu.getId() != YYEOF) {
      switch (lu.getId()) {
        case ID_FIN :
	  System.exit(0);
	case ID_INCONNU :
	  System.out.println("Expression rationnelle inconue " +
	  		     lu.getValeur());
          break;
	default :
	  System.out.println("Expression rationnelle RE" +
	  		     lu.getId() + " : " + lu.getValeur());
      }
      lu = analyseur.yylex();
    }
  } catch (Exception e) {}
}
%}

SEPARATEUR = [ \n\t]

RE1 =	[bB][eE][gG][iI][nN]
RE2 =	(0|1)+
RE3 =	0[0-7]*
RE4 =	-?(\.[0-9]+|[0-9]+\.|[0-9]+|[0-9]+\.[0-9]+)([eE][\+\-]?[0-9]+)?
RE5 =	[a-z]*1[a-z]*2[a-z]*3[a-z]*4[a-z]*
RE6 =	[e-z]*a[e-z]*b[e-z]*c[e-z]*d[e-z]*
RE7 =	[abd-z][a-z]*
RE8 =	([a-z][0-9])+
RE9 =	([a-df-z]|ee)+
RE10 =	(ee)?([a-df-z]+(ee)?)+|ee
RE11 =	"/*"([^*]*|"*"+[^*/]+)*"*"+"/"
RE12 =	[ac-z]+|[b-z]+
RE13 =	[a-df-zA-DF-Z]+|[a-df-zA-DF-Z]*(e|E)[a-df-zA-DF-Z]*
RE14 =	[d-z]*a?[d-z]*b?[d-z]*c?[d-z]*


%%
			/* (III) r�gles d'analyse et actions */

{SEPARATEUR}+ {}

{RE1} {
  return new Token(ID_RE1, new String(yytext()));
}

{RE2} {
  return new Token(ID_RE2, new String(yytext()));
}

{RE3} {
  return new Token(ID_RE3, new String(yytext()));
}

{RE4} {
  return new Token(ID_RE4, new String(yytext()));
}

{RE5} {
  return new Token(ID_RE5, new String(yytext()));
}

{RE6} {
  return new Token(ID_RE6, new String(yytext()));
}

{RE7} {
  return new Token(ID_RE7, new String(yytext()));
}

{RE8} {
  return new Token(ID_RE8, new String(yytext()));
}

{RE9} {
  return new Token(ID_RE9, new String(yytext()));
}

{RE10} {
  return new Token(ID_RE10, new String(yytext()));
}

{RE11} {
  return new Token(ID_RE11, new String(yytext()));
}

{RE12} {
  return new Token(ID_RE12, new String(yytext()));
}

{RE13} {
  return new Token(ID_RE13, new String(yytext()));
}

{RE14} {
  return new Token(ID_RE14, new String(yytext()));
}

.+ {
  return new Token(ID_INCONNU, new String(yytext()));
}

<<EOF>> {
  return new Token(ID_FIN);
}

