%{
	#include <stdio.h>
	int yylex(void);
	void yyerror(char const *);
	#include <string>
	#include <vector>
	using std::string;
	using std::vector;
	vector<string> csv_record;
	#include <iostream>
	using std::cout;
	using std::endl;

	int num_fields2 = 0, num_lines2 = 0;
%}

%define api.value.type {std::string}

%token CSV_FIELD

%%

input: 
	record '\n' {
		for (int i =0; i < csv_record.size(); ++i) {
			cout << ' ' << csv_record[i] ;
		}
		cout << endl;
		csv_record.resize(0);
		++num_lines2;
		cout << "new rec: " << ", num_lines2: " << num_lines2
			<< ", num_fields2: " << num_fields2
			<< endl;
		num_fields2 = 0;
	}
	| input record '\n' {
		for (int i =0; i < csv_record.size(); ++i) {
			cout << ' ' << csv_record[i] ;
		}
		cout << endl;
		csv_record.resize(0);
		++num_lines2;
		cout << "new rec: " << ", num_lines2: " << num_lines2
			<< ", num_fields2: " << num_fields2
			<< endl;
		num_fields2 = 0;
	}
	//| input record {
	//	for (int i =0; i < csv_record.size(); ++i) {
	//		cout << ' ' << csv_record[i] ;
	//	}
	//	cout << endl;
	//	csv_record.resize(0);
	//	++num_lines2; 
	//	cout << "new rec: " << ", num_lines2: " << num_lines2
	//		<< ", num_fields2: " << num_fields2
	//		<< endl;
	//	num_fields2 = 0;
	//}
	//| '\n' record {
	//	for (int i =0; i < csv_record.size(); ++i) {
	//		cout << ' ' << csv_record[i] ;
	//	}
	//	cout << endl;
	//}
	| error '\n' { yyerrok; }
	;

record:
	| CSV_FIELD {
		csv_record.push_back($1);
		++ num_fields2;
	}
	| record ',' CSV_FIELD {
		csv_record.push_back($3);
		++ num_fields2;
	}
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

