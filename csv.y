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
		int total_len = 0;
		for (int i =0; i < csv_record.size(); ++i) {
			cout << ' ' << csv_record[i] ;
			total_len += csv_record[i].length();
			if (total_len >= 70) {
				cout << endl;
				total_len = 0;
			}
		}
		expected_fields2 = csv_record.size();
		cout << endl << "total fields: " << expected_fields2 << endl;
		csv_record.resize(0);
		//++num_lines2; // dont count the header row
		//cout << ".";
		//if (num_lines2 % 70 == 0) {
		//	cout << " " << num_lines2 << endl;
		//}
		//cout << "new rec: " << ", num_lines2: " << num_lines2
		//	<< ", num_fields2: " << num_fields2
		//	<< endl;
		//num_fields2 = 0;
		header_mode2 = false;
		//cout << "header row, expected_fields2:" << expected_fields2 << endl;
	}
	| input record '\n' {

		++num_lines2;
		if (csv_record.size() != expected_fields2) {
			for (int i =0; i < csv_record.size(); ++i) {
				if (i+1 <= expected_fields2) { 
					cout 
						<< ' ' << header_row_map2[i+1] 
						<< " -> "
						<< '|' << csv_record[i] << '|' ;
				} else {
					cout 
						<< "out of header range: " << i + 1
						<< '|' << csv_record[i] << '|' ;
				}
			}
			cout << endl;
			cout << "ERROR line: "
				<< num_lines2
				<< " parser expected_fields2: " 
				<< expected_fields2 
				<< ", actual : " << csv_record.size()
				<< endl;
		}
		csv_record.resize(0);
		//cout << "new rec: " << ", num_lines2: " << num_lines2
		//	<< ", num_fields2: " << num_fields2
		//	<< endl;
		if (num_lines2 % 10 == 0 ) {
			cout << '+';
		} else {
			cout << '.';
		}
		if (num_lines2 % 70 == 0) {
			cout << " " << num_lines2 << endl;
		}
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
		csv_record.resize(0);
		cout << "ERROR: " << endl;
		yyerrok; 
	}
	;

record:
	csv_field {
		//csv_record.push_back($1);
		//++ num_fields2;
		//if (header_mode2) {
		//	header_row_map2[num_fields2] = $1;
		//}
	}
	| record ',' csv_field {
		//csv_record.push_back($3);
		//++ num_fields2;
		//if (header_mode2) {
		//	header_row_map2[num_fields2] = $1;
		//}
	}
	;

csv_field:
	%empty {
		csv_record.push_back(string(""));
		++ num_fields2;
		if (header_mode2) {
			header_row_map2[num_fields2] = string("");
		}
	}
	| CSV_FIELD {
		csv_record.push_back($1);
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
	fprintf (stderr, "%s ERROR line: %d \n", s, num_lines2);
}

int main()
{
	int status = yyparse();
	cout << endl << "num_lines2: "  << num_lines2 << endl;
	cout << "expected_fields2: "  << expected_fields2 << endl;

}

