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
		int row, col; string error_context;
		error_pos(int r, int c, string err_ctx)
			: row(r), col(c), error_context(err_ctx)
		{}
	};
	vector<error_pos> error_line_nos;
	#include <nlohmann/json.hpp>
	#include <sstream>

	std::stringstream error_context;
	// disable for now, enable via cmd line option 
	// if needed
	bool enable_progress_report = false; 
%}

%define api.value.type {std::string}

%token CSV_FIELD
%token QUOTED_CSV_FIELD
%token DOUBLE_QUOTE
%token MISPLACED_QUOTED_FIELD
%token MISPLACED_QUOTED_FIELD_NEWL

%%

input: 
	record '\n' {
		int total_len = 0;
		//for (int i =0; i < csv_record.size(); ++i) {
		//	cout << ' ' << csv_record[i] ;
		//	total_len += csv_record[i].length();
		//	if (total_len >= 70) {
		//		cout << endl;
		//		total_len = 0;
		//	}
		//}
		expected_fields2 = csv_record.size();
		//cout << endl << "total fields: " << expected_fields2 << endl;
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
	| record MISPLACED_QUOTED_FIELD_NEWL {
		cout << "got input = record MISPLACED_QUOTED_FIELD_NEWL" << endl;
		expected_fields2 = csv_record.size();
		csv_record.resize(0);
		header_mode2 = false;
	}
	//| input record ',' '\n' {
	//	cout<< "parsed record with empty last field" << endl;
	//}
	| input MISPLACED_QUOTED_FIELD_NEWL {
		cout << "got input = input MISPLACED_QUOTED_FIELD_NEWL" << endl;
	}
	| input record '\n' {

		++num_lines2;
		if (csv_record.size() != expected_fields2) {
			for (int i =0; i < csv_record.size(); ++i) {
				if (i+1 <= expected_fields2) { 
					error_context 
						<< ' ' << header_row_map2[i+1] 
						<< " -> "
						<< '|' << csv_record[i] << '|' ;
				} else {
					error_context 
						<< "out of header range: " << i + 1
						<< '|' << csv_record[i] << '|' ;
				}
			}
			error_context << endl;
			error_context << "ERROR line: "
				<< num_lines2
				<< " parser expected_fields2: " 
				<< expected_fields2 
				<< ", actual : " << csv_record.size()
				<< endl;
			error_line_nos.push_back(
				error_pos(num_lines2, csv_record.size(),
				error_context.str()));
		} else {
			all_csv_records.push_back(csv_record);
		}
		csv_record.resize(0);
		//cout << "new rec: " << ", num_lines2: " << num_lines2
		//	<< ", num_fields2: " << num_fields2
		//	<< endl;
		if (enable_progress_report) {
			if (num_lines2 % 10 == 0 ) {
				cout << '+';
			} else {
				cout << '.';
			}
			if (num_lines2 % 70 == 0) {
				cout << " " << num_lines2 << endl;
			}
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
		error_line_nos.push_back( error_pos(num_lines2, num_fields2, error_context.str()));
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
	| record MISPLACED_QUOTED_FIELD {
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
	| QUOTED_CSV_FIELD  {
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
	error_line_nos.push_back( error_pos(num_lines2, num_fields2, s));
	printf ("%s ERROR line: %d, field : %d\n", s, num_lines2, num_fields2);
}

extern  void csv2_lex_clean_up() ;
extern bool initialise_yylex_from_file(string file_name) ;
int main(int argc, char * argv[])
{
	if (argc > 1) {
		initialise_yylex_from_file(argv[1]);
	}

	int status = yyparse();
	if (status != 0) return 37;
	//cout << endl << "num_lines2: "  << num_lines2 << endl;
	//cout << "expected_fields: "  << expected_fields2 << endl;
	//cout << "Total errors: " << error_line_nos.size() << endl;
	using json = nlohmann::json;
	json error_op;
	if (error_line_nos.size() > 0 ) { 
		//cout << "Detailed errors: " << endl;
		for (int i = 0; i < error_line_nos.size(); ++i) {
			error_pos error_pos = error_line_nos[i];
			json an_error_pos = { 
				{"line", error_pos.row} , 
				{"field", error_pos.col },
				{"context", error_pos.error_context}
			};
			error_op.push_back(an_error_pos);
			//cout 
			//	<< "line: "      << error_pos.row
			//	<< ", n_field: " << error_pos.col << endl;
		}
		//cout << "End of error report" << endl;
	}

	 /* For non-reentrant C scanner only. */
	//yy_delete_buffer(YY_CURRENT_BUFFER);
	//yy_init = 1;
	csv2_lex_clean_up();
	//cout << "Successfully parsed records: " << all_csv_records.size() << endl;
	json json_op;
	for (int i = 0; i < all_csv_records.size(); ++i) {
		const vector<string>& v = all_csv_records[i];
		//string row = "row_" + i;
		//json_op[row] = v;
		//for (int j = 0; j < v.size() - 1; ++j) {
		//	cout << v[j] << "|";
		//}
		//cout << v[v.size()-1] << endl;
		//json arr = json::array(v);
		json_op.push_back(v); 
	}
	json header_op;
	for (int i = 1; i<= expected_fields2; ++i)  {
		header_op.push_back(header_row_map2[i]) ;
	}


	json parsed_data;
	parsed_data["header"] =  header_op;
	parsed_data["parsed_data"] =  json_op;
	parsed_data["expected_fields"] = expected_fields2;
	parsed_data["errors"] = error_op;
	parsed_data["total_records"] = num_lines2;
	parsed_data["total_errors"] = error_line_nos.size() ;
	parsed_data["successfully_parsed"] = all_csv_records.size()  ;
	cout 
		//<< "JSON format: " << endl
		<< parsed_data.dump(4) << endl;
	return 0;
}

