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

%}

%option noyywrap

%x quoted_field

%%

[^,\r\n"]* {
	//printf("got field: |%s|, field_no: %d\n", yytext, num_fields);
	string field(yytext);
	map<int,string>::const_iterator  index = header_row_map.find(num_fields);
	if (index == header_row_map.end()) {
		header_row_map[num_fields] = field;
		header_mode = true;
	} else {
		cout << "field: " << index->second << ", data: "
			<< field << endl; 
	}
	yylval = field;
	return CSV_FIELD;
}

\"      {
	BEGIN(quoted_field);
}

<quoted_field>[^,"\r\n]* {
	//strcpy(buffer+strlen(buffer), yytext);
	buffer += string(yytext);
}

<quoted_field>"\"\"" {
	//printf("got a double quote inside a csv field");
	//strcpy(buffer + strlen(buffer), "\"\"");
	buffer += string(yytext);
}

<quoted_field>\n {
	//printf("found a newline in a quoted field\n");
	//strcpy(buffer + strlen(buffer), "\n");
	buffer += string(yytext);
}

<quoted_field>\r {
	//printf("found a carriage return in a quoted field\n");
	//strcpy(buffer + strlen(buffer), "\r");
	buffer += string(yytext);
}

<quoted_field>, {
	//printf("found a comma in a quoted field\n");
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
		cout << "field: " << index->second << ", data: "
			<< field << endl; 
	}
	BEGIN(INITIAL);
	//printf("got a quoted field: %s\n", buffer.c_str());
	++num_quoted_fields;
	yylval = buffer;
	buffer[0] = '\0';
	buffer = "";
	return CSV_FIELD;
}

,	{
	++num_fields;
	printf("field separator: %d\n", num_fields);
	return ',';
}

<<EOF>> {
	static int once = 0;
	cout << "flex - returning NEWL on EOF" << endl;
	return once++ ? 0 : '\n';
}

\r\n|\n\r|\r|\n {
	++num_lines;
	printf("total fields :%d\n", num_fields);
	if (header_mode) {
		expected_fields = num_fields;
		header_mode = false;
	} else if (expected_fields != num_fields) {
		printf("line_no: %d , num_fields: %d  not matcing != expected_fields  : %d \n",
			num_lines, num_fields, expected_fields);
	}
	
	num_fields = 1;
	printf("new Record no:%d\n", num_lines);
	return '\n';
} 

%%

//int main() {
//        yylex();
//        //printf( "# of lines = %d, # of chars = %d\n", num_lines, num_fields );
//	printf("parsed: num_lines: %d, num_fields: %d, num_quoted_fields: %d\n",
//		num_lines, num_fields, num_quoted_fields);
//}

