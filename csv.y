%{
	#include <stdio.h>
	int yylex(void);
	void yyerror(char const *);
	#include <string>
	#include <vector>
	#include <map>
	using std::string;
	using std::vector;
	using std::map;
	vector<string> csv_record;
	#include <iostream>
	using std::cout;
	using std::endl;

	int num_fields2 = 0, num_lines2 = 0;
	std::map<int, std::string> header_row_map2;
	bool header_mode2 = true;
	int expected_fields2 = 0;
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
		expected_fields2 = csv_record.size();
		csv_record.resize(0);
		++num_lines2;
		cout << "new rec: " << ", num_lines2: " << num_lines2
			<< ", num_fields2: " << num_fields2
			<< endl;
		num_fields2 = 0;
		header_mode2 = false;
		cout << "got header row" << endl;
	}
	| input record '\n' {
		for (int i =0; i < csv_record.size(); ++i) {
			cout << ' ' << csv_record[i] ;
		}
		cout << endl;
		if (csv_record.size() != expected_fields2) {
			cout << "ERROR line: "
				<< num_lines2
				<< " parser expected_fields2: " 
				<< expected_fields2 
				<< ", actual : " << csv_record.size()
				<< endl;
		}
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
	| error '\n' { 
		++num_lines2;
		//csv_record.resize(0);
		yyerrok; 
	}
	;

record:
	| CSV_FIELD {
		csv_record.push_back($1);
		++ num_fields2;
		if (header_mode2) {
			header_row_map2[num_fields2] = $1;
		}
	}
	| record ',' CSV_FIELD {
		csv_record.push_back($3);
		++ num_fields2;
		if (header_mode2) {
			header_row_map2[num_fields2] = $1;
		}
	}
	;

%%

/* Called by yyparse on error. */
void yyerror (char const *s)
{
	fprintf (stderr, "%s line: %d \n", s, num_lines2);
}

int main()
{
	int status = yyparse();
	cout << "num_lines2: "  << num_lines2 << endl;
	cout << "num_fields2: "  << num_fields2 << endl;

}

