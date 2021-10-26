#ifndef common_defs_h
#define common_defs_h
#include <string>
#include <vector>
using std::string;
using std::vector;

struct error_pos {
	int row, col; string error_context;
	error_pos(int r, int c, string err_ctx)
		: row(r), col(c), error_context(err_ctx)
	{}
};

#endif /* common_defs_h */
