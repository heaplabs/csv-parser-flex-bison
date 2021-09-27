%{
#include <string>
using std::string;
#include "csv.tab.h"

	//.*	return CSV_FIELD
	int num_fields = 0;
%}

%option noyywrap

%%


[^,\r\n"]* {
	printf("got field: |%s|, field_no: %d\n", yytext, num_fields);
	//string field(yytext);
	//map<int,string>::const_iterator  index = header_row_map.find(num_fields);
	//if (index == header_row_map.end()) {
	//	header_row_map[num_fields] = field;
	//	header_mode = true;
	//} else {
	//	cout << "field: " << index->second << ", data: "
	//		<< field << endl; 
	//}
	return CSV_FIELD;
}

,	{
	printf("got COMMA\n");
	return ',';
}

\n	return '\n';

%%
