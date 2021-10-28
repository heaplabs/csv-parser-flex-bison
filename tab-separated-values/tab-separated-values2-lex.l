%{
#include <map>
#include <string>
#include <iostream>
#include <algorithm>
#include "common_defs.h"
#include "tab-separated-values.tab.h"

using std::map;
using std::string;
using std::cout;
using std::endl;

//struct LexerSpecificVars {
//	string buffer;
//	std::map<int, std::string> header_row_map;
//	bool header_mode = false;
//	int expected_fields = 0;
//	int semi_colon_count = 0;
//	int tab_count = 0;
//	int comma_count = 0;
//	int num_lines = 0, num_fields = 1, num_quoted_fields = 0;
//	LexerSpecificVars() :
//		buffer(), header_row_map(), header_mode (false),
//		expected_fields (0), semi_colon_count (0),
//		tab_count(0), comma_count(0),
//		num_lines(0), num_fields(1), num_quoted_fields(0)
//	{
//	}
//};

struct LexerSpecificVars tabLexerSpecificVars;

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
%option prefix="tab_separated_values_"

%x quoted_field

%%

[^"\t\r\n][^\t\r\n]*\" {
	printf("CSV_FIELD got field with misplaced double quote0: |%s|, field_no: %d\n", yytext, tabLexerSpecificVars.num_fields);
	string field(yytext);
	map<int,string>::const_iterator  index = tabLexerSpecificVars.header_row_map.find(tabLexerSpecificVars.num_fields);
	if (index == tabLexerSpecificVars.header_row_map.end()) {
		tabLexerSpecificVars.header_row_map[tabLexerSpecificVars.num_fields] = field;
		tabLexerSpecificVars.header_mode = true;
	} else {
		//cout << "field: " << index->second << ", data: "
		//	<< field << endl; 
	}
	tabLexerSpecificVars.semi_colon_count += std::count(field.begin(), field.end(), ';');
	tabLexerSpecificVars.tab_count += std::count(field.begin(), field.end(), '\t');
	tabLexerSpecificVars.comma_count += std::count(field.begin(), field.end(), ',');
	tab_separated_values_lval = field;
	return TABSV_FIELD;
}

[^"\t\r\n][^\t\r\n]*/\t {
	printf("CSV_FIELD got field with misplaced double quote1: |%s|, field_no: %d\n", yytext, tabLexerSpecificVars.num_fields);
	string field(yytext);
	map<int,string>::const_iterator  index = tabLexerSpecificVars.header_row_map.find(tabLexerSpecificVars.num_fields);
	if (index == tabLexerSpecificVars.header_row_map.end()) {
		tabLexerSpecificVars.header_row_map[tabLexerSpecificVars.num_fields] = field;
		tabLexerSpecificVars.header_mode = true;
	} else {
		//cout << "field: " << index->second << ", data: "
		//	<< field << endl; 
	}
	tabLexerSpecificVars.semi_colon_count += std::count(field.begin(), field.end(), ';');
	tabLexerSpecificVars.tab_count += std::count(field.begin(), field.end(), '\t');
	tabLexerSpecificVars.comma_count += std::count(field.begin(), field.end(), ',');
	tab_separated_values_lval = field;
	return TABSV_FIELD;
}

 	/* warning rule cant be matched because of my changes */ 
[^\t\r\n"]+\" {
	printf("CSV_FIELD got field with misplaced double quote2: |%s|, field_no: %d\n", yytext, tabLexerSpecificVars.num_fields);
	string field(yytext);
	map<int,string>::const_iterator  index = tabLexerSpecificVars.header_row_map.find(tabLexerSpecificVars.num_fields);
	if (index == tabLexerSpecificVars.header_row_map.end()) {
		tabLexerSpecificVars.header_row_map[tabLexerSpecificVars.num_fields] = field;
		tabLexerSpecificVars.header_mode = true;
	} else {
		//cout << "field: " << index->second << ", data: "
		//	<< field << endl; 
	}
	tabLexerSpecificVars.semi_colon_count += std::count(field.begin(), field.end(), ';');
	tabLexerSpecificVars.tab_count += std::count(field.begin(), field.end(), '\t');
	tabLexerSpecificVars.comma_count += std::count(field.begin(), field.end(), ',');
	tab_separated_values_lval = field;
	return TABSV_FIELD;
}

[^\t\r\n"]* {
	printf("got field: |%s|, field_no: %d\n", yytext, tabLexerSpecificVars.num_fields);
	string field(yytext);
	map<int,string>::const_iterator  index = tabLexerSpecificVars.header_row_map.find(tabLexerSpecificVars.num_fields);
	if (index == tabLexerSpecificVars.header_row_map.end()) {
		tabLexerSpecificVars.header_row_map[tabLexerSpecificVars.num_fields] = field;
		tabLexerSpecificVars.header_mode = true;
	} else {
		//cout << "field: " << index->second << ", data: "
		//	<< field << endl; 
	}
	tabLexerSpecificVars.semi_colon_count += std::count(field.begin(), field.end(), ';');
	tabLexerSpecificVars.tab_count += std::count(field.begin(), field.end(), '\t');
	tabLexerSpecificVars.comma_count += std::count(field.begin(), field.end(), ',');
	tab_separated_values_lval = field;
	return TABSV_FIELD;
}

\"      {
	BEGIN(quoted_field);
}

<quoted_field>[^\t"\r\n]* {
	//strcpy(buffer+strlen(buffer), yytext);
	tabLexerSpecificVars.buffer += string(yytext);
}

<quoted_field>"\"\"" {
	//printf("got a double quote inside a csv field");
	//strcpy(buffer + strlen(buffer), "\"\"");
	tabLexerSpecificVars.buffer += string(yytext);
}

<quoted_field>\n {
	//printf("found a newline in a quoted field\n");
	//strcpy(buffer + strlen(buffer), "\n");
	tabLexerSpecificVars.buffer += string(yytext);
}

<quoted_field>\r {
	//printf("found a carriage return in a quoted field\n");
	//strcpy(buffer + strlen(buffer), "\r");
	tabLexerSpecificVars.buffer += string(yytext);
}

<quoted_field>\t {
	//printf("found a comma in a quoted field\n");
	//strcpy(buffer + strlen(buffer), ",");
	tabLexerSpecificVars.buffer += string(yytext);
}

<quoted_field>\" {
	map<int,string>::const_iterator  index = tabLexerSpecificVars.header_row_map.find(tabLexerSpecificVars.num_fields);
	string field(tabLexerSpecificVars.buffer);
	if (index == tabLexerSpecificVars.header_row_map.end()) {
		tabLexerSpecificVars.header_row_map[tabLexerSpecificVars.num_fields] = field;
		tabLexerSpecificVars.header_mode = true;
	} else {
		//cout << "field: " << index->second << ", data: "
		//	<< field << endl; 
	}
	BEGIN(INITIAL);
	printf("got a quoted field: %s\n", tabLexerSpecificVars.buffer.c_str());
	++tabLexerSpecificVars.num_quoted_fields;
	tabLexerSpecificVars.semi_colon_count += std::count(field.begin(), field.end(), ';');
	tabLexerSpecificVars.tab_count += std::count(field.begin(), field.end(), '\t');
	tabLexerSpecificVars.comma_count += std::count(field.begin(), field.end(), ',');
	tab_separated_values_lval = tabLexerSpecificVars.buffer;
	tabLexerSpecificVars.buffer[0] = '\0';
	tabLexerSpecificVars.buffer = "";
	return TABSV_QUOTED_FIELD;
}

\t	{
	++tabLexerSpecificVars.num_fields;
	//printf("field separator: %d\n", tabLexerSpecificVars.num_fields);
	return '\t';
}

	/*
	<<EOF>> {
		static int once = 0;
		cout << "flex - returning NEWL on EOF" << endl;
		return once++ ? 0 : '\n';
	}
	*/

\r\n|\n\r|\r|\n {
	++tabLexerSpecificVars.num_lines;
	//printf("total fields :%d\n", tabLexerSpecificVars.num_fields);
	if (tabLexerSpecificVars.header_mode) {
		tabLexerSpecificVars.expected_fields = tabLexerSpecificVars.num_fields;
		tabLexerSpecificVars.header_mode = false;
	} else if (tabLexerSpecificVars.expected_fields != tabLexerSpecificVars.num_fields) {
		//printf("line_no: %d , tabLexerSpecificVars.num_fields: %d  not matcing != expected_fields  : %d \n",
		//	tabLexerSpecificVars.num_lines, tabLexerSpecificVars.num_fields, expected_fields);
	}
	
	tabLexerSpecificVars.num_fields = 1;
	//printf("new Record no:%d\n", tabLexerSpecificVars.num_lines);
	return '\n';
} 

%%

void tabsv2_lex_clean_up() {
	yy_delete_buffer(YY_CURRENT_BUFFER);
	yy_init = 1;
}

bool initialise_tab_lex_from_file(string file_name) {
	tab_separated_values_in = fopen( file_name.c_str(), "r" );
	if ( ! tab_separated_values_in ) {
	      cout << "unable to open file: " << file_name << endl;
	      exit(1);
	}
	unsigned char buffer[100] ; // for the byte order mark
	for (int i = 0; i < 100; ++i) {
		buffer[i] = 0;
	}
	int n_read = fread(buffer, sizeof(char), 3, tab_separated_values_in);
	unsigned char ch1 = buffer[0], ch2 = buffer[1], ch3 = buffer[2];
	//printf("%x %x %x\n", buffer[0], buffer[1], buffer[2]);
	if (ch1 == 0xef && ch2 == 0xbb && ch3 == 0xbf) {
		// got the byte order mark so we skip over those
		// 3 bytes
		//cout << "skipping over byte order mark" << endl;
	} else {
		//cout << "rewinding to start of file - no byte order mark" << endl;
		fseek(tab_separated_values_in, 0, SEEK_SET);
	}
     
	tab_separated_values_push_buffer_state(tab_separated_values__create_buffer( tab_separated_values_in, YY_BUF_SIZE ));
	BEGIN(INITIAL);
	return true;
}

//int main() {
//        yylex();
//        //printf( "# of lines = %d, # of chars = %d\n", tabLexerSpecificVars.num_lines, tabLexerSpecificVars.num_fields );
//	printf("parsed: tabLexerSpecificVars.num_lines: %d, tabLexerSpecificVars.num_fields: %d, tabLexerSpecificVars.num_quoted_fields: %d\n",
//		tabLexerSpecificVars.num_lines, tabLexerSpecificVars.num_fields, tabLexerSpecificVars.num_quoted_fields);
//}

