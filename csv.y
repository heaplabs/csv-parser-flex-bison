%{
	#include <stdio.h>
	int yylex(void);
	void yyerror(char const *);
	#include <string>
	using std::string;
%}

%define api.value.type union
%token <string*> CSV_FIELD

%%

input: 
	  line
	| input line
	;

line:
	| CSV_FIELD '\n'
	| CSV_FIELD ',' line
	;

%%

/* Called by yyparse on error. */
void yyerror (char const *s)
{
	fprintf (stderr, "%s\n", s);
}

int main()
{
	return yyparse();
}

