%{
#include <map>
#include <string>
#include <iostream>
#include <algorithm>
#include "common_defs.h"
#include "semicolon-separated-values.tab.h"

using std::map;
using std::string;
using std::cout;
using std::endl;

struct LexerSpecificVars {
	string buffer;
	std::map<int, std::string> header_row_map;
	bool header_mode = false;
	int expected_fields = 0;
	int semi_colon_count = 0;
	int tab_count = 0;
	int comma_count = 0;
	int num_lines = 0, num_fields = 1, num_quoted_fields = 0;
	LexerSpecificVars() :
		buffer(), header_row_map(), header_mode (false),
		expected_fields (0), semi_colon_count (0),
		tab_count(0), comma_count(0),
		num_lines(0), num_fields(1), num_quoted_fields(0)
	{
	}
};

struct LexerSpecificVars lexerSpecificVars;

// string buffer;
// std::map<int, std::string> header_row_map;
// bool header_mode = false;
// int expected_fields = 0;
// int semi_colon_count = 0;
// int tab_count = 0;
// int comma_count = 0;
// int num_lines = 0, num_fields = 1, num_quoted_fields = 0;

%}

%option noyywrap 8bit
%array
%option prefix="semicolon_separated_values_"

%x quoted_field

%%

[^";\r\n][^;\r\n]*\" {
	//printf("CSV_FIELD got field with misplaced double quote0: |%s|, field_no: %d\n", yytext, num_fields);
	string field(yytext);
	map<int,string>::const_iterator  index = lexerSpecificVars.header_row_map.find(lexerSpecificVars.num_fields);
	if (index == lexerSpecificVars.header_row_map.end()) {
		lexerSpecificVars.header_row_map[lexerSpecificVars.num_fields] = field;
		lexerSpecificVars.header_mode = true;
	} else {
		//cout << "field: " << index->second << ", data: "
		//	<< field << endl; 
	}
	lexerSpecificVars.semi_colon_count += std::count(field.begin(), field.end(), ';');
	lexerSpecificVars.tab_count += std::count(field.begin(), field.end(), '\t');
	lexerSpecificVars.comma_count += std::count(field.begin(), field.end(), ',');
	semicolon_separated_values_lval = field;
	return SEMICOLONSV_FIELD;
}

[^";\r\n][^;\r\n]*/; {
	//printf("CSV_FIELD got field with misplaced double quote1: |%s|, field_no: %d\n", yytext, lexerSpecificVars.num_fields);
	string field(yytext);
	map<int,string>::const_iterator  index = lexerSpecificVars.header_row_map.find(lexerSpecificVars.num_fields);
	if (index == lexerSpecificVars.header_row_map.end()) {
		lexerSpecificVars.header_row_map[lexerSpecificVars.num_fields] = field;
		lexerSpecificVars.header_mode = true;
	} else {
		//cout << "field: " << index->second << ", data: "
		//	<< field << endl; 
	}
	lexerSpecificVars.semi_colon_count += std::count(field.begin(), field.end(), ';');
	lexerSpecificVars.tab_count += std::count(field.begin(), field.end(), '\t');
	lexerSpecificVars.comma_count += std::count(field.begin(), field.end(), ',');
	semicolon_separated_values_lval = field;
	return SEMICOLONSV_FIELD;
}

 	/* warning rule cant be matched because of my changes */ 
[^;\r\n"]+\" {
	//printf("CSV_FIELD got field with misplaced double quote2: |%s|, field_no: %d\n", yytext, lexerSpecificVars.num_fields);
	string field(yytext);
	map<int,string>::const_iterator  index = lexerSpecificVars.header_row_map.find(lexerSpecificVars.num_fields);
	if (index == lexerSpecificVars.header_row_map.end()) {
		lexerSpecificVars.header_row_map[lexerSpecificVars.num_fields] = field;
		lexerSpecificVars.header_mode = true;
	} else {
		//cout << "field: " << index->second << ", data: "
		//	<< field << endl; 
	}
	lexerSpecificVars.semi_colon_count += std::count(field.begin(), field.end(), ';');
	lexerSpecificVars.tab_count += std::count(field.begin(), field.end(), '\t');
	lexerSpecificVars.comma_count += std::count(field.begin(), field.end(), ',');
	semicolon_separated_values_lval = field;
	return SEMICOLONSV_FIELD;
}

[^;\r\n"]* {
	//printf("got field: |%s|, field_no: %d\n", yytext, lexerSpecificVars.num_fields);
	string field(yytext);
	map<int,string>::const_iterator  index = lexerSpecificVars.header_row_map.find(lexerSpecificVars.num_fields);
	if (index == lexerSpecificVars.header_row_map.end()) {
		lexerSpecificVars.header_row_map[lexerSpecificVars.num_fields] = field;
		lexerSpecificVars.header_mode = true;
	} else {
		//cout << "field: " << index->second << ", data: "
		//	<< field << endl; 
	}
	lexerSpecificVars.semi_colon_count += std::count(field.begin(), field.end(), ';');
	lexerSpecificVars.tab_count += std::count(field.begin(), field.end(), '\t');
	lexerSpecificVars.comma_count += std::count(field.begin(), field.end(), ',');
	semicolon_separated_values_lval = field;
	return SEMICOLONSV_FIELD;
}

\"      {
	BEGIN(quoted_field);
}

<quoted_field>[^;"\r\n]* {
	//strcpy(buffer+strlen(buffer), yytext);
	lexerSpecificVars.buffer += string(yytext);
}

<quoted_field>"\"\"" {
	//printf("got a double quote inside a csv field");
	//strcpy(buffer + strlen(buffer), "\"\"");
	lexerSpecificVars.buffer += string(yytext);
}

<quoted_field>\n {
	//printf("found a newline in a quoted field\n");
	//strcpy(buffer + strlen(buffer), "\n");
	lexerSpecificVars.buffer += string(yytext);
}

<quoted_field>\r {
	//printf("found a carriage return in a quoted field\n");
	//strcpy(buffer + strlen(buffer), "\r");
	lexerSpecificVars.buffer += string(yytext);
}

<quoted_field>; {
	//printf("found a comma in a quoted field\n");
	//strcpy(buffer + strlen(buffer), ",");
	lexerSpecificVars.buffer += string(yytext);
}

<quoted_field>\" {
	map<int,string>::const_iterator  index = lexerSpecificVars.header_row_map.find(lexerSpecificVars.num_fields);
	string field(lexerSpecificVars.buffer);
	if (index == lexerSpecificVars.header_row_map.end()) {
		lexerSpecificVars.header_row_map[lexerSpecificVars.num_fields] = field;
		lexerSpecificVars.header_mode = true;
	} else {
		//cout << "field: " << index->second << ", data: "
		//	<< field << endl; 
	}
	BEGIN(INITIAL);
	//printf("got a quoted field: %s\n", buffer.c_str());
	++lexerSpecificVars.num_quoted_fields;
	lexerSpecificVars.semi_colon_count += std::count(field.begin(), field.end(), ';');
	lexerSpecificVars.tab_count += std::count(field.begin(), field.end(), '\t');
	lexerSpecificVars.comma_count += std::count(field.begin(), field.end(), ',');
	semicolon_separated_values_lval = lexerSpecificVars.buffer;
	lexerSpecificVars.buffer[0] = '\0';
	lexerSpecificVars.buffer = "";
	return SEMICOLONSV_QUOTED_FIELD;
}

;	{
	++lexerSpecificVars.num_fields;
	++lexerSpecificVars.semi_colon_count;
	//printf("field separator: %d\n", lexerSpecificVars.num_fields);
	return ';';
}

	/*
	<<EOF>> {
		static int once = 0;
		cout << "flex - returning NEWL on EOF" << endl;
		return once++ ? 0 : '\n';
	}
	*/

\r\n|\n\r|\r|\n {
	++lexerSpecificVars.num_lines;
	//printf("total fields :%d\n", lexerSpecificVars.num_fields);
	if (lexerSpecificVars.header_mode) {
		lexerSpecificVars.expected_fields = lexerSpecificVars.num_fields;
		lexerSpecificVars.header_mode = false;
	} else if (lexerSpecificVars.expected_fields != lexerSpecificVars.num_fields) {
		//printf("line_no: %d , lexerSpecificVars.num_fields: %d  not matcing != expected_fields  : %d \n",
		//	lexerSpecificVars.num_lines, lexerSpecificVars.num_fields, expected_fields);
	}
	
	lexerSpecificVars.num_fields = 1;
	//printf("new Record no:%d\n", lexerSpecificVars.num_lines);
	return '\n';
} 

%%

void semicolonsv2_lex_clean_up() {
	yy_delete_buffer(YY_CURRENT_BUFFER);
	yy_init = 1;
}

bool initialise_semicolon_lex_from_file(string file_name) {
	semicolon_separated_values_in = fopen( file_name.c_str(), "r" );
	if ( ! semicolon_separated_values_in ) {
	      cout << "unable to open file: " << file_name << endl;
	      exit(1);
	}
	unsigned char buffer[100] ; // for the byte order mark
	for (int i = 0; i < 100; ++i) {
		buffer[i] = 0;
	}
	int n_read = fread(buffer, sizeof(char), 3, semicolon_separated_values_in);
	unsigned char ch1 = buffer[0], ch2 = buffer[1], ch3 = buffer[2];
	//printf("%x %x %x\n", buffer[0], buffer[1], buffer[2]);
	if (ch1 == 0xef && ch2 == 0xbb && ch3 == 0xbf) {
		// got the byte order mark so we skip over those
		// 3 bytes
		//cout << "skipping over byte order mark" << endl;
	} else {
		//cout << "rewinding to start of file - no byte order mark" << endl;
		fseek(semicolon_separated_values_in, 0, SEEK_SET);
	}
     
	semicolon_separated_values_push_buffer_state(semicolon_separated_values__create_buffer( semicolon_separated_values_in, YY_BUF_SIZE ));
	BEGIN(INITIAL);
	return true;
}

//int main() {
//        yylex();
//        //printf( "# of lines = %d, # of chars = %d\n", lexerSpecificVars.num_lines, lexerSpecificVars.num_fields );
//	printf("parsed: lexerSpecificVars.num_lines: %d, lexerSpecificVars.num_fields: %d, lexerSpecificVars.num_quoted_fields: %d\n",
//		lexerSpecificVars.num_lines, lexerSpecificVars.num_fields, lexerSpecificVars.num_quoted_fields);
//}

