/*
	Generer l'analyseur lexical :   jflex Q7.jflex
	Compiler avec :                 javac Q7.java
	Executer avec :                 java Q7
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

%class Q7
%unicode
%line
%column
%type Token

%{
static final int ID_FIN     = 0;
static final int ID_IDENT     = 1;
static final int ID_ENTIER     = 2;
static final int ID_INCONNU     = 3;
static final int ID_ARITH     = 4;
%}

%{
public static void main(String argv[]) {
  Q7 analyseur = new Q7(new java.io.InputStreamReader(System.in));

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
	case ID_ENTIER :
	  System.out.println(lu.getValeur( )  + " entier" );
          break;
case ID_ARITH :
	  System.out.println(lu.getValeur( )  + " expression" );
          break;
case ID_IDENT :
	  System.out.println(lu.getValeur( )  + " id");
          break;
	default :
System.out.println(lu.getValeur( )  + " INTERDIT" );
	  System.exit(0);
      }
      lu = analyseur.yylex();
    }
  } catch (Exception e) {}
}
%}

SEPARATEUR = [ \n\t]
ENTIER = -?[0-9]+
IDENT = [a-zA-Z][a-zA-Z0-9]*
ARITH = [\+\-\*\/\(\)]

%%
			/* (III) r�gles d'analyse et actions */

{SEPARATEUR}+ {}

{ENTIER} {
  return new Token(ID_ENTIER, new String(yytext()));
}

{IDENT} {
  return new Token(ID_IDENT, new String(yytext()));
}

{ARITH} {
  return new Token(ID_ARITH, new String(yytext()));
}

<<EOF>> {
  return new Token(ID_FIN);
}

.+ {
  return new Token(ID_INCONNU, new String(yytext()));
}

