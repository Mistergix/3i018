/*
	Generer l'analyseur lexical :   jflex Exo1.jflex
	Compiler avec :                 javac Exo1.java
	Executer avec :                 java Exo1
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

%class Exo1
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
static final int ID_INCONNU = 6;
%}

%{
public static void main(String argv[]) {
  Exo1 analyseur = new Exo1(new java.io.InputStreamReader(System.in));

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

RE1		= (0|1)*
RE2		= (0*|1*)*
RE3		= 0(0|1)*0
RE4		= 0*10*10*10*
RE5		= ([^xyz \n\t]*xyz[^xyz \n\t]*)*


%%
			/* (III) r�gles d'analyse et actions */

[ \t\n]+ {}

{RE4} { /* cas particulier avant le cas plus general */
  return new Token(ID_RE4, new String(yytext()));
}

{RE3} { /* le cas particulier avant le cas plus general */
  return new Token(ID_RE3, new String(yytext()));
}

{RE1} { /* le cas plus general */
  return new Token(ID_RE1, new String(yytext()));
}

/* = RE1
{RE2} {
  return new Token(ID_RE2, new String(yytext()));
}
*/

{RE5} {
  return new Token(ID_RE5, new String(yytext()));
}

<<EOF>> {
  return new Token(ID_FIN);
}

.+ {
  return new Token(ID_INCONNU, new String(yytext()));
}

