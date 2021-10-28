%{
	#include "common_defs.h"
	#include <stdio.h>
	int yylex(void);
	//void yyerror(char const *);

	#include <string>
	#include <vector>
	#include <map>
	#include <bitset>
	using std::string;
	using std::vector;
	using std::map;

	//vector<string> csv_record;
	//vector<vector<string>> all_csv_records;
	#include <iostream>
	#include <utility>
	using std::cout;
	using std::endl;

	void yyerror ( vector<string> & csv_record, 
		vector<vector<string>> & all_csv_records,
		int &num_fields2,
		int &num_lines2,
		std::map<int, std::string> & header_row_map2,
		bool &header_mod2 ,
		int &expected_filds2,
		vector<error_pos> & error_line_nos,
		bool &enable_proress_report,
		bool &has_last_bad_header,
		char const *s );

	//int num_fields2 = 0, num_lines2 = 0;
	//std::map<int, std::string> header_row_map2;
	//bool header_mode2 = true;
	//int expected_fields2 = 0;

	//vector<error_pos> error_line_nos;
	//#include <nlohmann/json.hpp>
	#include <sstream>

	//std::stringstream error_context;
	// disable for now, enable via cmd line option 
	// if needed
	//bool enable_progress_report = false; 
	//bool has_last_bad_header = false; 
%}

%define api.prefix {tab_separated_values_}
%define parse.lac full
%define parse.error verbose

%define lr.type ielr

%define api.value.type {std::string}

%parse-param 	{vector<string> & csv_record} 
		{vector<vector<string>> & all_csv_records}
		{int &num_fields2} 
		{int &num_lines2}
		{std::map<int, std::string> & header_row_map2}
		{bool &header_mode2 }
		{int &expected_fields2}
		{vector<error_pos> & error_line_nos}
		{bool &enable_progress_report}
		{bool &has_last_bad_header}

%token TABSV_FIELD
%token TABSV_QUOTED_FIELD

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
		vector<int> bad_headers ;
		std::stringstream error_context;
		for (int i = 0; i < csv_record.size(); ++i) {
			if (csv_record[i].size() == 0) {
				error_context << "header field of len 0 at position i=" << i << endl;
				bad_headers.push_back(i);
			}
		}
		// we'll do only 1 optimisation
		// - IF there is only 1 bad header
		// -    AND it is the last header
		// - THEN we drop it
		if (bad_headers.size () == 1 && bad_headers[0] == csv_record.size()-1) {
			std::stringstream error_context;
			error_context << "resetting expected_fields2: from " << csv_record.size()
				<< " to " << csv_record.size() - 1 << endl;
			expected_fields2 = csv_record.size() - 1;
			error_line_nos.push_back(
				error_pos(num_lines2, csv_record.size(),
				error_context.str()));
			has_last_bad_header = true;
			// the header_row_map2 already has the empty last field pushed
			// we're going to delete it (i.e. clean it up)
			std::map<int, std::string> ::iterator iterator_last = header_row_map2.end();
			--iterator_last;
			header_row_map2.erase(iterator_last);
		} else {
			expected_fields2 = csv_record.size();
		}
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
	//| input record ',' '\n' {
	//	cout<< "parsed record with empty last field" << endl;
	//}
	| input record '\n' {

		++num_lines2;
		if (csv_record.size() != expected_fields2) {
			//cout << "error: csv_record.size " << csv_record.size() 
			//	<< ", expected_fields2: " << expected_fields2
			//	<< endl;
			std::stringstream error_context;
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
			error_context.clear();
		} else {
			//cout << "parsed record: " ;
			//for (int i = 0; i < csv_record.size(); ++i ) {
			//	cout << ", " << csv_record[i] ;
			//}
			//cout << endl;
			all_csv_records.push_back(csv_record);
		}
		csv_record.resize(0);
		// cout << "new rec: " << ", num_lines2: " << num_lines2
		// 	<< ", num_fields2: " << num_fields2
		// 	<< ", no_errors: " << error_line_nos.size()
		// 	<< endl;
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
	//| input error '\n' { 
	//	error_line_nos.push_back( error_pos(num_lines2, num_fields2, error_context.str()));
	//	num_fields2 = 0;
	//	++num_lines2;
	//	csv_record.resize(0);
	//	cout << "ERROR: " << endl;
	//	yyerrok; 
	//}
	| input error  { 
		if (num_fields2 == expected_fields2) {
			all_csv_records.push_back(csv_record);
		} else {
			std::stringstream error_context;
			error_context << "missing final linefeed";
			error_line_nos.push_back( error_pos(num_lines2, num_fields2, error_context.str()));
		}
		num_fields2 = 0;
		++num_lines2;
		csv_record.resize(0);
		//error_context.clear();
		//cout << "ERROR: " << endl;
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
	| record '\t' csv_field {
		//csv_record.push_back($3);
		//++ num_fields2;
		//if (header_mode2) {
		//	header_row_map2[num_fields2] = $1;
		//}
	}
	;

csv_field:
	%empty {
		//cout << " not pushing last field as it's empty:"
		//	<< ", num_fields2: " << num_fields2
		//	<< ", expected_fields2: " << expected_fields2
		//	<< endl;
		if (!header_mode2 && has_last_bad_header && (num_fields2  == expected_fields2)) {
			// dont even push this field
			//cout << " not pushing last field as it's empty and we skipped the last header which was also empty:"
			//	<< ", num_fields2: " << num_fields2
			//	<< ", expected_fields2: " << expected_fields2
			//	<< endl;
		} else {
			csv_record.push_back(string(""));
		}
		++ num_fields2;
		if (header_mode2) {
			header_row_map2[num_fields2] = string("");
		}
	}
	| TABSV_FIELD {
		csv_record.push_back($1);
		++ num_fields2;
		if (header_mode2) {
			header_row_map2[num_fields2] = $1;
		}
	}
	| TABSV_QUOTED_FIELD  {
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

