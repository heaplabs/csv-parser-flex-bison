/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_COMMA_SEPARATED_VALUES_CSV_TAB_H_INCLUDED
# define YY_COMMA_SEPARATED_VALUES_CSV_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef COMMA_SEPARATED_VALUES_DEBUG
# if defined YYDEBUG
#if YYDEBUG
#   define COMMA_SEPARATED_VALUES_DEBUG 1
#  else
#   define COMMA_SEPARATED_VALUES_DEBUG 0
#  endif
# else /* ! defined YYDEBUG */
#  define COMMA_SEPARATED_VALUES_DEBUG 0
# endif /* ! defined YYDEBUG */
#endif  /* ! defined COMMA_SEPARATED_VALUES_DEBUG */
#if COMMA_SEPARATED_VALUES_DEBUG
extern int comma_separated_values_debug;
#endif

/* Token type.  */
#ifndef COMMA_SEPARATED_VALUES_TOKENTYPE
# define COMMA_SEPARATED_VALUES_TOKENTYPE
  enum comma_separated_values_tokentype
  {
    CSV_FIELD = 258,
    QUOTED_CSV_FIELD = 259,
    DOUBLE_QUOTE = 260
  };
#endif

/* Value type.  */
#if ! defined COMMA_SEPARATED_VALUES_STYPE && ! defined COMMA_SEPARATED_VALUES_STYPE_IS_DECLARED
typedef std::string COMMA_SEPARATED_VALUES_STYPE;
# define COMMA_SEPARATED_VALUES_STYPE_IS_TRIVIAL 1
# define COMMA_SEPARATED_VALUES_STYPE_IS_DECLARED 1
#endif


extern COMMA_SEPARATED_VALUES_STYPE comma_separated_values_lval;

int comma_separated_values_parse (vector<string> & csv_record, vector<vector<string>> & all_csv_records, int &num_fields2, int &num_lines2, std::map<int, std::string> & header_row_map2, bool &header_mode2, int &expected_fields2, vector<error_pos> & error_line_nos, bool &enable_progress_report, bool &has_last_bad_header);

#endif /* !YY_COMMA_SEPARATED_VALUES_CSV_TAB_H_INCLUDED  */
