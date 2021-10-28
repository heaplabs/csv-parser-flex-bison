#ifndef common_defs_h
#define common_defs_h
#include <string>
#include <vector>
#include <map>
using std::string;
using std::vector;
using std::map;

struct error_pos {
	int row, col; string error_context;
	error_pos(int r, int c, string err_ctx)
		: row(r), col(c), error_context(err_ctx)
	{}
};

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

#endif /* common_defs_h */
