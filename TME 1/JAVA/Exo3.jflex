/*
	Generer l'analyseur lexical :   jflex Exo3.jflex
	Compiler avec :                 javac Exo3.java
	Executer avec :                 java Exo3
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

%class Exo3
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

String chaine;
%}

%{
public static void main(String argv[]) {
  Exo3 analyseur = new Exo3(new java.io.InputStreamReader(System.in));

  try {
    Token lu = analyseur.yylex();

    while (lu.getId() != YYEOF) {
      switch (lu.getId()) {
        case ID_FIN :
	  System.exit(0);
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

RE1 = [bB][eE][gG][iI][nN]
RE2 = (0|1)+
RE3 = 0[0-7]*
RE4 = -?(\.[0-9]+|[0-9]+\.|[0-9]+|[0-9]+\.[0-9]+)([eE][\+\-]?[0-9]+)?
RE5 = [a-z]*1[a-z]*2[a-z]*3[a-z]*4[a-z]*
RE6 = [e-z]*a[e-z]*b[e-z]*c[e-z]*d[e-z]*

%xstate COND_COMMENTAIRE


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

<<EOF>> {
  return new Token(ID_FIN);
}

\/\* {
  System.out.println("Debut commentaire :");
  yybegin(COND_COMMENTAIRE);
  chaine = "/*";
}

<COND_COMMENTAIRE>\n		{ chaine = chaine + yytext(); }
<COND_COMMENTAIRE>[^*\n]+	{ chaine = chaine + yytext(); }
<COND_COMMENTAIRE>"*"+[^\/\n]]*	{ chaine = chaine + yytext(); }
<COND_COMMENTAIRE>\**"*/"	{
				  chaine = chaine + yytext();
				  System.out.println(chaine);
				  System.out.println("Fin de commentaire.");
				  yybegin(YYINITIAL);
				}

