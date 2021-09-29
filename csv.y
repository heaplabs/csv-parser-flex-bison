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
	vector<vector<string>> all_csv_records;
	#include <iostream>
	using std::cout;
	using std::endl;

	int num_fields2 = 0, num_lines2 = 0;
	std::map<int, std::string> header_row_map2;
	bool header_mode2 = true;
	int expected_fields2 = 0;
	struct error_pos {
		int row, col;
		error_pos(int r, int c): row(r), col(c)
		{}
	};
	vector<error_pos> error_line_nos;
%}

%define api.value.type {std::string}

%token CSV_FIELD
%token QUOTED_CSV_FIELD
%token DOUBLE_QUOTE

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
	//| input record ',' '\n' {
	//	cout<< "parsed record with empty last field" << endl;
	//}
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
		all_csv_records.push_back(csv_record);
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
		//cout << "parsed a record" << endl;

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
	| input error '\n' { 
		error_line_nos.push_back( error_pos(num_lines2, num_fields2));
		num_fields2 = 0;
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
	| DOUBLE_QUOTE QUOTED_CSV_FIELD  {
		csv_record.push_back($1);
		++ num_fields2;
		if (header_mode2) {
			header_row_map2[num_fields2] = $1;
		}
	}
	/*
	| CSV_FIELD error '"' {
		cout << "ERROR field QUOTE  num_lines2 " 
			<< num_lines2 
			<< ", num_fields2: "
			<< num_fields2
			<< endl;
		yyerrok;
	}
	| CSV_FIELD error ',' {
		cout << "ERROR field COMMA  num_lines2 " 
			<< num_lines2 
			<< ", num_fields2: "
			<< num_fields2
			<< endl;
		yyerrok;
	}
	*/
	;

/*
record:
      	 %empty {
	 	cout << "got an empty field" << endl;
		csv_record.push_back(string(""));
		++ num_fields2;
		if (header_mode2) {
			header_row_map2[num_fields2] = string("");
		}
	}
      |  CSV_FIELD {
		csv_record.push_back($1);
		++ num_fields2;
		if (header_mode2) {
			header_row_map2[num_fields2] = $1;
		}
	}
      |  DOUBLE_QUOTE QUOTED_CSV_FIELD {
		csv_record.push_back($2);
		++ num_fields2;
		if (header_mode2) {
			header_row_map2[num_fields2] = $1;
		}
	}
      |  record ',' CSV_FIELD {
		csv_record.push_back($3);
		++ num_fields2;
		if (header_mode2) {
			header_row_map2[num_fields2] = $1;
		}
	}
      |  record ',' DOUBLE_QUOTE QUOTED_CSV_FIELD {
		csv_record.push_back($3);
		++ num_fields2;
		if (header_mode2) {
			header_row_map2[num_fields2] = $3;
		}
		//cout << "syntax error in file - misplaced double quotes around"  << $3 << endl;
      	    //yyerrok;
	}
	//
      |  record ',' DOUBLE_QUOTE CSV_FIELD {
		csv_record.push_back($4);
		++ num_fields2;
		if (header_mode2) {
			header_row_map2[num_fields2] = $1;
		}
	}
      }
      |  record CSV_FIELD {
		csv_record.push_back($2);
		++ num_fields2;
		if (header_mode2) {
			header_row_map2[num_fields2] = $2;
		}
		cout << "syntax error in file - misplaced double quotes around" << endl;
      	    yyerrok;
      }
	//
      ;
*/

%%

/* Called by yyparse on error. */
void yyerror (char const *s)
{
	printf ("%s ERROR line: %d, field : %d\n", s, num_lines2, num_fields2);
}

extern  void csv2_lex_clean_up() ;
int main()
{
	int status = yyparse();
	cout << endl << "num_lines2: "  << num_lines2 << endl;
	cout << "expected_fields2: "  << expected_fields2 << endl;

	for (int i = 0; i < error_line_nos.size(); ++i) {
		error_pos error_pos = error_line_nos[i];
		cout 
			<< "line: "      << error_pos.row
			<< ", n_field: " << error_pos.col << endl;
	}

	 /* For non-reentrant C scanner only. */
	//yy_delete_buffer(YY_CURRENT_BUFFER);
	//yy_init = 1;
	csv2_lex_clean_up();
	cout << "parsed records: " << endl;
	for (int i = 0; i < all_csv_records.size(); ++i) {
		const vector<string>& v = all_csv_records[i];
		for (int j = 0; j < v.size() - 1; ++j) {
			cout << v[j] << "|";
		}
		cout << v[v.size()-1] << endl;
	}

}

