%{
#include <map>
#include <string>
#include <iostream>
#include "csv.tab.h"
int num_lines = 0, num_fields = 1, num_quoted_fields = 0;
//char buffer[8192];
//extern "C" int yylex();

using std::map;
using std::string;
using std::cout;
using std::endl;

string buffer;
std::map<int, std::string> header_row_map;
bool header_mode = false;
int expected_fields = 0;
bool in_quoted_field_mode = false;
bool in_misplaced_quoted_field_mode = false;

%}

%option noyywrap
%array

%x quoted_field
%x misplaced_quote_field

%%

[^",\r\n][^",\r\n]*\" {
	printf("BEGIN misplaced_quote_field quote0: |%s|, field_no: %d\n", yytext, num_fields);
	string field(yytext);
	//map<int,string>::const_iterator  index = header_row_map.find(num_fields);
	//if (index == header_row_map.end()) {
	//	header_row_map[num_fields] = field;
	//	header_mode = true;
	//} else {
	//	//cout << "field: " << index->second << ", data: "
	//	//	<< field << endl; 
	//}
	//yylval = field;
	//return CSV_FIELD;
	buffer = field;
	//cout << "got misplaced_quote_field: " << buffer << endl;
	if (in_quoted_field_mode) {
		cout << "trying to enter misplaced_quoted_field mode when quoted_field_mode";
	} else { 
		BEGIN(misplaced_quote_field);
		in_misplaced_quoted_field_mode = true;
	}
}

<misplaced_quote_field>[^,\r\n]*, {
	string field(yytext);
	cout << "terminating misplaced_quote_field: yytext " << yytext << endl;
	if (field.length() > 1) {
		buffer += field.substr(0, field.length()-1);
	}
	cout << "terminating misplaced_quote_field: " << buffer << endl;
	yylval = buffer; buffer = "";
	BEGIN(INITIAL);
	unput(',');
	in_misplaced_quoted_field_mode = false;
	return MISPLACED_QUOTED_FIELD;
}




	/*
	<misplaced_quote_field>, {
		cout << "terminated misplaced_quote_field with a , (comma)" << endl;
	}
	[^",\r\n]* /, {
		string field(yytext);
		map<int,string>::const_iterator  index = header_row_map.find(num_fields);
		if (index == header_row_map.end()) {
			header_row_map[num_fields] = field;
			header_mode = true;
		} else {
			//cout << "field: " << index->second << ", data: "
			//	<< field << endl; 
		}
		yylval = field;
		return CSV_FIELD;
	}
	*/

[^,"\r\n]* {
	printf("CSV_FIELD got field: |%s|, field_no: %d\n", yytext, num_fields);
	string field(yytext);
	map<int,string>::const_iterator  index = header_row_map.find(num_fields);
	if (index == header_row_map.end()) {
		header_row_map[num_fields] = field;
		header_mode = true;
	} else {
		//cout << "field: " << index->second << ", data: "
		//	<< field << endl; 
	}
	if (in_quoted_field_mode) {
		// ignore
	} else {
		yylval = field;
		return CSV_FIELD;
	}
}

\"      {
	if (yytext[0]=='"') {
		cout << "beginning of a quoted field - going into quoted field state: yytext " 
			<< yytext
			<< endl;
		BEGIN(quoted_field);
		in_quoted_field_mode = true;
	}
	//return DOUBLE_QUOTE;
}

<quoted_field>[^,"\r\n]* {
	//strcpy(buffer+strlen(buffer), yytext);
	buffer += string(yytext);
	cout << "quoted_field : extending match: " << buffer << endl;
}

<quoted_field>"\"\"" {
	printf("<quoted_field> got an escaped double quote inside a csv field: yytext: |%s|, buffer: %s\n",
			yytext, buffer.c_str());
	//strcpy(buffer + strlen(buffer), "\"\"");
	string yytext_str(yytext);
	if (yytext_str == "\"\"") {
		buffer += yytext_str;
	} else {
		// ignore
	}
}

<quoted_field>\n {
	printf("found a newline in a quoted field\n");
	//strcpy(buffer + strlen(buffer), "\n");
	buffer += string(yytext);
}

<quoted_field>\r {
	printf("found a carriage return in a quoted field\n");
	//strcpy(buffer + strlen(buffer), "\r");
	buffer += string(yytext);
}

<quoted_field>, {
	printf("found a comma in a quoted field\n");
	//strcpy(buffer + strlen(buffer), ",");
	buffer += string(yytext);
}

<quoted_field>\" {
	map<int,string>::const_iterator  index = header_row_map.find(num_fields);
	string field(buffer);
	if (index == header_row_map.end()) {
		header_row_map[num_fields] = field;
		header_mode = true;
	} else {
		//cout << "field: " << index->second << ", data: "
		//	<< field << endl; 
	}
	string yytext_str (yytext);
	printf("<quoted_field> got a QUOTED_CSV_FIELD field: %s, yytext: |%s|, len yytext: %ld\n",
		buffer.c_str(), yytext, yytext_str.length());
	cout << " yytext[0] == '\"'" << (yytext[0] == '"') << endl;
	if (yytext[0] == '"')  {
		BEGIN(INITIAL);
		++num_quoted_fields;
		yylval = buffer;
		buffer[0] = '\0';
		buffer = "";
		in_quoted_field_mode = false;
		printf("coming out of quoted field mode\n");
		return QUOTED_CSV_FIELD;
	} // else just continue reading stuff otherwise
}

,	{
	++num_fields;
	printf("field separator #f %d, #n %d\n", num_fields, num_lines);
	return ',';
}

	/*
	<<EOF>> {
		static int once = 0;
		cout << "flex - returning NEWL on EOF" << endl;
		return once++ ? 0 : '\n';
	}
	*/

\r\n|\n\r|\r|\n {
	++num_lines;
	//printf("total fields :%d\n", num_fields);
	if (header_mode) {
		expected_fields = num_fields;
		header_mode = false;
	} else if (expected_fields != num_fields) {
		//printf("line_no: %d , num_fields: %d  not matcing != expected_fields  : %d \n",
		//	num_lines, num_fields, expected_fields);
	}
	
	num_fields = 1;
	//printf("new Record no:%d\n", num_lines);
	return '\n';
} 

%%

void csv2_lex_clean_up() {
	yy_delete_buffer(YY_CURRENT_BUFFER);
	yy_init = 1;
}

bool initialise_yylex_from_file(string file_name) {
	yyin = fopen( file_name.c_str(), "r" );
	if ( ! yyin ) {
	      cout << "unable to open file: " << file_name << endl;
	      exit(1);
	}
     
	yypush_buffer_state(yy_create_buffer( yyin, YY_BUF_SIZE ));
	BEGIN(INITIAL);
	return true;
}

//int main() {
//        yylex();
//        //printf( "# of lines = %d, # of chars = %d\n", num_lines, num_fields );
//	printf("parsed: num_lines: %d, num_fields: %d, num_quoted_fields: %d\n",
//		num_lines, num_fields, num_quoted_fields);
//}

