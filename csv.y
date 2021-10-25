%{
	#include <stdio.h>
	int yylex(void);
	void yyerror(char const *);
	#include <string>
	#include <vector>
	#include <map>
	#include <bitset>
	using std::string;
	using std::vector;
	using std::map;
	vector<string> csv_record;
	vector<vector<string>> all_csv_records;
	#include <iostream>
	#include <utility>
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
	//#include <nlohmann/json.hpp>
	#include <sstream>

	//std::stringstream error_context;
	// disable for now, enable via cmd line option 
	// if needed
	bool enable_progress_report = false; 
	bool has_last_bad_header = false; 
%}

%define api.value.type {std::string}

%token CSV_FIELD
%token QUOTED_CSV_FIELD
%token DOUBLE_QUOTE

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
	//printf ("%s ERROR line: %d, field : %d\n", s, num_lines2, num_fields2);
}

extern  void csv2_lex_clean_up() ;
extern bool initialise_yylex_from_file(string file_name) ;

// https://stackoverflow.com/questions/1031645/how-to-detect-utf-8-in-plain-c
string rectify_utf8(const string& a_str)
{
    //const char * a_string = a_str.c_str();
    string duplicate(a_str);
    if(!duplicate.length() > 0)
        return 0;

    //const unsigned char * bytes = (const unsigned char *)a_string;
    int i = 0;
    while(i < duplicate.length())
    {
        if( (// ASCII
             // use bytes[0] <= 0x7F to allow ASCII control characters
                duplicate[i] == 0x09 ||
                duplicate[i] == 0x0A ||
                duplicate[i] == 0x0D ||
                (0x20 <= duplicate[i] && duplicate[i] <= 0x7E)
            )
        ) {
            i += 1;
            continue;
        }

        if( (// non-overlong 2-byte
                (0xC2 <= duplicate[i+ 0] && duplicate[i+0] <= 0xDF) &&
		(i+1 < duplicate.length()) &&
                (0x80 <= duplicate[i+1] && duplicate[i+1] <= 0xBF)
            )
        ) {
            i += 2;
            continue;
        }

        if( (// excluding overlongs
                duplicate[i+0] == 0xE0 &&
		(i + 1 < duplicate.length()) &&
                (0xA0 <= duplicate[i+1] && duplicate[i+1] <= 0xBF) &&
		(i + 2 < duplicate.length()) &&
                (0x80 <= duplicate[i+2] && duplicate[i+2] <= 0xBF)
            ) ||
            (// straight 3-byte
                ((0xE1 <= duplicate[i+0] && duplicate[i+0] <= 0xEC) ||
                    duplicate[i+0] == 0xEE ||
                    duplicate[i+0] == 0xEF) &&
		(i + 1 < duplicate.length()) &&
                (0x80 <= duplicate[i+1] && duplicate[i+1] <= 0xBF) &&
		(i + 2 < duplicate.length()) &&
                (0x80 <= duplicate[i+2] && duplicate[i+2] <= 0xBF)
            ) ||
            (// excluding surrogates
                duplicate[0] == 0xED &&
                (0x80 <= duplicate[i+1] && duplicate[i+1] <= 0x9F) &&
                (0x80 <= duplicate[i+2] && duplicate[i+2] <= 0xBF)
            )
        ) {
            i += 3;
            continue;
        }

        if( (// planes 1-3
                duplicate[i+0] == 0xF0 &&
		(i + 1 < duplicate.length()) &&
                (0x90 <= duplicate[i+1] && duplicate[i+1] <= 0xBF) &&
		(i + 2 < duplicate.length()) &&
                (0x80 <= duplicate[i+2] && duplicate[i+2] <= 0xBF) &&
		(i + 3 < duplicate.length()) &&
                (0x80 <= duplicate[i+3] && duplicate[i+3] <= 0xBF)
            ) ||
            (// planes 4-15
                (0xF1 <= duplicate[i+0] && duplicate[i+0] <= 0xF3) &&
		(i + 1 < duplicate.length()) &&
                (0x80 <= duplicate[i+1] && duplicate[i+1] <= 0xBF) &&
		(i + 2 < duplicate.length()) &&
                (0x80 <= duplicate[i+2] && duplicate[i+2] <= 0xBF) &&
		(i + 3 < duplicate.length()) &&
                (0x80 <= duplicate[i+3] && duplicate[i+3] <= 0xBF)
            ) ||
            (// plane 16
                duplicate[i+0] == 0xF4 &&
		(i + 1 < duplicate.length()) &&
                (0x80 <= duplicate[i+1] && duplicate[i+1] <= 0x8F) &&
		(i + 2 < duplicate.length()) &&
                (0x80 <= duplicate[i+2] && duplicate[i+2] <= 0xBF) &&
		(i + 3 < duplicate.length()) &&
                (0x80 <= duplicate[i+3] && duplicate[i+3] <= 0xBF)
            )
        ) {
            i += 4;
            continue;
        }

        //return 0;
	duplicate[i] = '_'; i += 1;
    }

    return duplicate;
}

struct StringCodePageAnalysisResult {
	int n_utf8_longer_than_1byte = 0;
	int n_wincp1252 = 0;
	int n_iso_8859_1 = 0;
	string rectified;
	StringCodePageAnalysisResult(): 
		n_utf8_longer_than_1byte(0),
		n_wincp1252(0),
		n_iso_8859_1(0),
		rectified()
	{}

	StringCodePageAnalysisResult(
		int p_n_utf8_longer_than_1byte,
		int p_n_wincp1252,
		int p_n_iso_8859_1,
		string p_rectified
	): 
		n_utf8_longer_than_1byte(p_n_utf8_longer_than_1byte),
		n_wincp1252(p_n_wincp1252),
		n_iso_8859_1(p_n_iso_8859_1),
		rectified(p_rectified)
	{}
};

string print_csv_as_json(
	const StringCodePageAnalysisResult & total_cp_res,
	const vector<vector<string>> & all_csv_records,
	const std::map<int, std::string> & header_row_map2,
	int expected_fields2,
	const vector<error_pos> & error_line_nos
	);

// todo - these globals need to disappear
//int n_utf8_longer_than_1byte = 0;
//int n_wincp1252 = 0;
//int n_iso_8859_1 = 0;
StringCodePageAnalysisResult json_print(std::string const & s)
{
	StringCodePageAnalysisResult res ;
	using std::cout;
	using std::endl;
	std::stringstream ss;
	int no_errors = 0;
	int len = s.length();
	for (int i = 0; i < len; ++i) {
		// control characters
		// cout << "s["<< i << "]: "
		// 	<< (std::bitset<8>(s[i]))
		// 	<< " (s[i  ] & 0b11110000): "
		// 	<< (std::bitset<8>(s[i  ] & 0b11110000) )
		// 	<< ", ((s[i  ] & 0b11110000) >> 4) : "
		// 	<< std::bitset<8>((s[i  ] & 0b11110000) >> 4) 
		// 	<< ", ((s[i  ] & 0b11110000) >> 4 == 0b1110): "
		// 	<< ((s[i  ] & 0b11110000) >> 4 == 0b1110)
		// 	<< endl;
		// if (i + 1 < len) {
		// 	cout << "s["<< i+1 << "]: "
		// 		<< (std::bitset<8>(s[i+1])) << endl;
		// 	unsigned char c1 = s[i+1] & 0b10111111;
		// 	cout << "c1: " << (std::bitset<8>(c1)) << endl;
		// 	cout << " (c1 >> 6 == 0b10): " <<  ( (c1 >> 6) == 0b10) << endl;
		// }
		// if (i + 2 < len) {
		// 	cout << "s["<< i+2 << "]: "
		// 		<< (std::bitset<8>(s[i+2])) << endl;
		// 	unsigned char c2 = s[i+2] & 0b10111111;
		// 	cout << "c2: " << (std::bitset<8>(c2)) << endl;
		// 	cout << " (c2 >> 6 == 0b10): " <<  ( (c2 >> 6) == 0b10) << endl;
		// 	//s[i+2] 
		// }
		// if (i + 3 < len) {
		// 	cout << "s["<< i+3 << "]: "
		// 		<< (std::bitset<8>(s[i+3])) << endl;
		// 	unsigned char c3 = s[i+2] & 0b10111111;
		// 	cout << "c3: " << (std::bitset<8>(c3)) << endl;
		// 	cout << " (c3 >> 6 == 0b10): " <<  ( (c3 >> 6) == 0b10) << endl;
		// }
		// unsigned char ch = s[i] & 0b1110000;
		// cout << " bitwise and with 0b11011111 "	<< (ch) << endl;

		if ( ((s[i  ] & 0b11111000) >> 3) == 0b11110 && 
			    i + 3 < len &&
			    ((s[i+1] & 0b11000000) >> 6) == 0b10 &&
			    ((s[i+2] & 0b11000000) >> 6) == 0b10 &&
			    ((s[i+3] & 0b11000000) >> 6) == 0b10 
				) {
			//cout << "4 byte unicode point" << endl;
			ss << s[i] << s[i+1] << s[i+2] << s[i+3];
			i+=3;
			++res.n_utf8_longer_than_1byte;
		}

		else if ( ((s[i  ] & 0b11110000) >> 4) == 0b1110 && 
			    i + 2 < len &&
			    ((s[i+1] & 0b11000000) >> 6) == 0b10 &&
			    ((s[i+2] & 0b11000000) >> 6) == 0b10 
				) {
			// 3 byte unicode character
			//cout << "3 byte unicode" << endl;
			ss << s[i] << s[i+1] << s[i+2];
			i+=2;
			++res.n_utf8_longer_than_1byte;
		}

		else if (   ((s[i  ] & 0b11100000) >> 5) == 0b110 && 
			    i + 1 < len &&
			    ((s[i+1] & 0b11000000) >> 6) == 0b10
				) {
			// 2 byte unicode character
			//cout << "2 byte unicode" << endl;
			ss << s[i] << s[i+1];
			i+=1;
			++res.n_utf8_longer_than_1byte;
		}

		else if (s[i] >= 0 && s[i] < 32) {
			// control characters
			// some control chars need special handling
			// https://www.cs.cmu.edu/~pattis/15-1XX/common/handouts/ascii.html
			// https://www.json.org/json-en.html
			//cout << "ascii control char: " << s[i] << endl;
			if        (s[i] ==  8) { // backspace
				ss << "\\b"; 
			} else if (s[i] ==  9) { // tab
				ss << "\\t";
			} else if (s[i] == 10) { // linefeed
				ss << "\\n";
			} else if (s[i] == 12) { // form feed
				ss << "\\f";
			} else if (s[i] == 13) { // carriage return
				ss << "\\r";
			} else {
				ss << s[i];
			}
		} else if (s[i] >= 32 && s[i] <= 127) {
			//cout << "std ascii" << endl;
			//cout << "ascii printable char: |" << s[i] << "|" << endl;
			// todo - bring back later
			if (s[i] == '"' || s[i] == '\\' || s[i] == '/') {
				ss << "\\" << s[i];
			} else {
				ss << s[i];
			}
		}

		// else if ( ((s[i  ] & 0b11111011) >> 2) == 0b111110 && 
		// 	    i + 4 < len &&
		// 	    ((s[i+1] & 0b10111111) >> 6) == 0b10 &&
		// 	    ((s[i+2] & 0b10111111) >> 6) == 0b10 &&
		// 	    ((s[i+3] & 0b10111111) >> 6) == 0b10 &&
		// 	    ((s[i+4] & 0b10111111) >> 6) == 0b10 
		// 		) {
		// 	cout << "5 byte unicode" << endl;
		// 	ss << s[i] << s[i+1] << s[i+2] << s[i+3];
		// 	i+=4;
		// } 

		else 
		{
			// non unicode character
			//cout << "else clause non-utf8 char: " << (std::bitset<8>(s[i])) << endl;
			unsigned char ch = (unsigned char) s[i];
			if (ch >= 127 && ch <= 159) {
				++res.n_wincp1252;
			} else if (ch >= 160 && ch <= 255) {
				++res.n_iso_8859_1; // note: all iso part of wincp1252
			}
			//ss << s[i] << s[i+1] << s[i+2] << s[i+3];
			ss << s[i];
		}
	}
	//string res2 = ss.str();
	res.rectified = ss.str();
	return res;
}

string print_error_info(const vector<error_pos> & error_line_nos) {
	std::stringstream res;
	if (error_line_nos.size() > 0) {
		res << "\"errors\"" << ':' << "[";
		for (int i = 0; i < error_line_nos.size() - 1; ++i) {
			const error_pos & ep = error_line_nos[i];
			res << "{";
			res
				<< "\"line\" : " << ep.row << "," << endl
				<< "\"field\" : " << ep.col << "," << endl
				<< "\"context\" : \"";
			StringCodePageAnalysisResult result = json_print(ep.error_context);
			res << result.rectified << "\"";
			res << "}," << endl;
		}
		{
			const error_pos & ep = error_line_nos[error_line_nos.size()-1];
			res << "{";
			res
				<< "\"line\" : " << ep.row << "," << endl
				<< "\"field\" : " << ep.col << "," << endl
				<< "\"context\" : \"";
			StringCodePageAnalysisResult result = json_print(ep.error_context);
			res << result.rectified << "\"";
			res << "}" << endl;
		}

		res << "]";
	}
	return res.str();
}

int main(int argc, char * argv[])
{
	if (argc > 1) {
		initialise_yylex_from_file(argv[1]);
	}

	int status = yyparse();
	//cout << "Parse finished" << endl;
	if (status != 0) return 37;
	extern int semi_colon_count;
	if (semi_colon_count > 0) {
		// cout << "input file has semicolons:" 
		// 	<< semi_colon_count
		// 	<< "num_lines: " << num_lines2 << endl;
		if (semi_colon_count > num_lines2 ) {
			//cout << "Exiting - this is a semicolon terminated file mostly" <<endl;
			return 41;
		}
	}
	// cout << endl << "num_lines2: "  << num_lines2 << endl;
	// cout << "expected_fields: "  << expected_fields2 << endl;
	// cout << "Total errors: " << error_line_nos.size() << endl;
	//using json = nlohmann::json;
	//json error_op;
	//if (error_line_nos.size() > 0 ) { 
	//	//cout << "Detailed errors: " << endl;
	//	for (int i = 0; i < error_line_nos.size(); ++i) {
	//		error_pos error_pos = error_line_nos[i];
	//		json an_error_pos = { 
	//			{"line", error_pos.row} , 
	//			{"field", error_pos.col },
	//			{"context", error_pos.error_context}
	//		};
	//		error_op.push_back(an_error_pos);
	//		//cout 
	//		//	<< "line: "      << error_pos.row
	//		//	<< ", n_field: " << error_pos.col << endl;
	//	}
	//	//cout << "End of error report" << endl;
	//}

	 /* For non-reentrant C scanner only. */
	//yy_delete_buffer(YY_CURRENT_BUFFER);
	//yy_init = 1;
	csv2_lex_clean_up();
	StringCodePageAnalysisResult total_cp_res;
	//cout << "Successfully parsed records: " << all_csv_records.size() << endl;
	//json json_op;
	// todo - extract out as a method
	//vector<vector<string> > json_escaped_records = json_escape_records(all_csv_records);

	vector<vector<string> > json_escaped_records;
	json_escaped_records.reserve(all_csv_records.size());
	for (int i = 0; i < all_csv_records.size(); ++i) {
		const vector<string>& v = all_csv_records[i];
		//cout << "line " << i + 1 << ", v.size(): " << v.size() << endl;
		//string row = "row_" + i;
		//json_op[row] = v;
		//for (int j = 0; j < v.size() - 1; ++j) {
		//	cout << v[j] << "|";
		//}
		// bool all_ok = true;
		int all_lengths = 0;
		for (int j = 0; j < v.size() ; ++j) {
			//cout << "|" << v[j] << "|" << endl;
			if (v[j].length() > 0) {
				//string rectified = rectify_utf8(v[j]);
				//if (v[j] == rectified)  {
				//	rectified_vec.push_back(rectified);
				//} else {
				//	cout << "line no : " << i + 2 << " has a utf8 issue: " << rectified << endl; 
				//	rectified_vec.push_back(rectified);
				//}
				all_lengths += v[j].length();
			}
		}
		// //cout << "line no:" << i + 2 <<  ", all_lengths: " << all_lengths << endl;
		if (all_lengths > 0) {
			vector<string> rectified_vec; 
			rectified_vec.reserve(v.size());
			for (int j = 0; j < v.size() ; ++j) {
				//cout << v[j] << "|";
				if (v[j].length() > 0) {
					//string rectified = rectify_utf8(v[j]);
					StringCodePageAnalysisResult result = json_print(v[j]);
					total_cp_res.n_utf8_longer_than_1byte += result.n_utf8_longer_than_1byte;
					total_cp_res.n_wincp1252 += result.n_wincp1252;
					total_cp_res.n_iso_8859_1 += result.n_iso_8859_1;
					string rectified = result.rectified;

					//if (no_errors > 0)  {
					//	cout << "line no : " << i + 2 << " has a utf8 issue, compare: " << endl
					//		<< v[j] << endl
					//		<< "vs" << endl
					//		<< rectified << endl; 
					//	rectified_vec.push_back(rectified);
					//} else {
					//	rectified_vec.push_back(rectified);
					//}
					rectified_vec.push_back(rectified);
				} else {
					rectified_vec.push_back("");
				}
			}
			json_escaped_records.push_back(rectified_vec);
		} else {
			//cout << "line no : " << i + 2 << " all fields are empty not adding "  << endl; 
		}
		//cout << v[v.size()-1] << endl;
		//json arr = json::array(v);
		//json_op.push_back(v);
		//if (all_ok) json_op.push_back(v); 
		//else cout << "skipping non-utf:" << i << endl;
		//if (rectified_vec.size() > 0) {
		//	json_op.push_back(rectified_vec);
		//}
	}
	//json header_op;
	//for (int i = 1; i<= expected_fields2; ++i)  {
	//	header_op.push_back(header_row_map2[i]) ;
	//}

	string csv_as_json = print_csv_as_json(total_cp_res, 
		json_escaped_records, header_row_map2, 
		expected_fields2, error_line_nos);
	cout //<< "\"csv_as_json\" : "
		<< csv_as_json << endl;



	//json parsed_data;
	//parsed_data["header"] =  header_op;
	////parsed_data["parsed_data"] =  json_op;
	//parsed_data["expected_fields"] = expected_fields2;
	////parsed_data["errors"] = error_op;
	//parsed_data["total_records"] = num_lines2;
	//parsed_data["total_errors"] = error_line_nos.size() ;
	//parsed_data["successfully_parsed"] = all_csv_records.size()  ;
	//parsed_data["n_utf8_longer_than_1byte"] = total_cp_res.n_utf8_longer_than_1byte  ;
	//parsed_data["n_iso_8859_1"] = total_cp_res.n_iso_8859_1  ;
	//parsed_data["n_wincp1252"] = total_cp_res.n_wincp1252  ;
	//cout 
	//	//<< "JSON format: " << endl
	//	<< parsed_data.dump(4) << endl;
	return 0;
}

string print_key_value(map<string, int> & kv) {
	std::stringstream ss;
	map<string, int>::const_iterator ci = kv.begin();
	map<string, int>::const_iterator ci_end = kv.end();
	map<string, int>::const_iterator last_but_one = --ci_end;

	for (; ci != last_but_one; ++ci) {
		ss
			<< '"' << ci->first << '"'
			<< " : "
			<< ci->second
			<< ","
			<< endl;
	}
	ss
		<< '"' << last_but_one->first << '"'
		<< " : "
		<< last_but_one->second  ;

	return ss.str();
}

string print_array(const string key, const vector<string> & v) {
	//cout << "print_array v.size(): " << v.size() << endl;
	std::stringstream ss;
	ss
		<< '"' << key << '"'
			<< " : "
			<< " [ " << endl;

	for (int i = 0; i < v.size()-1; ++i) {
		ss << "    " << '"' << v[i] << '"' << ',' << endl;
	}
	ss << "    " << '"' << v[v.size()-1] << '"' << endl;
	ss << " ] " << endl;
	return ss.str();
}

string print_array(const vector<string>& v)
{
	//cout << "print_array v.size(): " << v.size() << endl;
	std::stringstream ss;
	if (v.size() > 0) {
		ss << " [ " << endl;

		for (int i = 0; i < v.size() - 1 ; ++i) {
			ss << "    " << '"' << v[i] << '"' << ',' << endl;
		}
		ss << "    " << '"' << v[v.size()-1] << '"' << endl;
		ss << " ] " ;
	} else {
		ss << "[]";
	}
	return ss.str();
}

string print_parsed_data(
	const vector<vector<string>> & all_csv_records)
{
	std::stringstream ss;
	ss << '"' << "parsed_data" << '"' << ':' << '[' << endl;
	if (all_csv_records.size() > 0) {
		bool should_print_comma = (all_csv_records.size() >= 2) ? true : false;
		bool has_output_one_row = false;
		for (int i = 0; i < all_csv_records.size()-1; ++i) {
			if (all_csv_records[i].size() > 0) {
				if (all_csv_records[i].size() > 0 && should_print_comma && has_output_one_row) {
					ss << ",";
				}
				if (all_csv_records[i].size() > 0 ) {
					ss << print_array(all_csv_records[i]) << endl;
					has_output_one_row = true;
				}
			}
		}
		if (all_csv_records[all_csv_records.size()-1].size() > 0 && should_print_comma && has_output_one_row) {
			ss << ",";
		}
		if (all_csv_records[all_csv_records.size()-1].size() > 0) {
			ss << print_array(all_csv_records[all_csv_records.size()-1]);
		}
	}
	ss << ']' ;
	return ss.str();
}


vector<string> convert_header_to_vec( 
	const std::map<int, std::string> & header_row_map2)
{
	vector<string> v;
	v.reserve(header_row_map2.size());
	for (map<int, string>::const_iterator ci = header_row_map2.begin(); 
		ci != header_row_map2.end(); ++ci) {
		//cout << ci->first << ":" << ci->second << endl;
		v.push_back(ci->second);
	}
	return v;
}

string print_csv_as_json(
	const StringCodePageAnalysisResult & total_cp_res,
	const vector<vector<string>> & all_csv_records,
	const std::map<int, std::string> & header_row_map2,
	int expected_fields2,
	const vector<error_pos> & error_line_nos
	)
{
	std::stringstream res;
	map<string, int> analysis_kv;
	analysis_kv["expected_fields"] = expected_fields2;
	analysis_kv["n_iso_8859_1"] = total_cp_res.n_iso_8859_1;
	analysis_kv["n_utf8_longer_than_1byte"] = total_cp_res.n_utf8_longer_than_1byte;
	analysis_kv["n_wincp1252"] = total_cp_res.n_wincp1252;
	analysis_kv["total_records"] = num_lines2;
	analysis_kv["total_errors"] = error_line_nos.size() ;
	analysis_kv["successfully_parsed"] = all_csv_records.size()  ;
	string analysis_res = 
		print_key_value(analysis_kv);
	
	// step 0 - declare our inferences
	res
		<< "{" << endl
		<< analysis_res;
	// step 1 - print the headers
	vector<string> headers_in_order = 
		convert_header_to_vec(header_row_map2);	 
	res
		<< "," << endl
		<< print_array("header", headers_in_order)
		;

	// step 2 - print the body
	res 
		<< "," << endl
		<< print_parsed_data(all_csv_records);
	// step 3 - print the summary chars
	// step 4 - print the errors
	if (error_line_nos.size() > 0) {
		res << ", " << print_error_info(error_line_nos);
	}

	res
		<< "}"
		<< endl;
	return res.str();
}

