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

#ifndef YY_TAB_SEPARATED_VALUES_TAB_SEPARATED_VALUES_TAB_H_INCLUDED
# define YY_TAB_SEPARATED_VALUES_TAB_SEPARATED_VALUES_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef TAB_SEPARATED_VALUES_DEBUG
# if defined YYDEBUG
#if YYDEBUG
#   define TAB_SEPARATED_VALUES_DEBUG 1
#  else
#   define TAB_SEPARATED_VALUES_DEBUG 0
#  endif
# else /* ! defined YYDEBUG */
#  define TAB_SEPARATED_VALUES_DEBUG 0
# endif /* ! defined YYDEBUG */
#endif  /* ! defined TAB_SEPARATED_VALUES_DEBUG */
#if TAB_SEPARATED_VALUES_DEBUG
extern int tab_separated_values_debug;
#endif

/* Token type.  */
#ifndef TAB_SEPARATED_VALUES_TOKENTYPE
# define TAB_SEPARATED_VALUES_TOKENTYPE
  enum tab_separated_values_tokentype
  {
    TABSV_FIELD = 258,
    TABSV_QUOTED_FIELD = 259
  };
#endif

/* Value type.  */
#if ! defined TAB_SEPARATED_VALUES_STYPE && ! defined TAB_SEPARATED_VALUES_STYPE_IS_DECLARED
typedef std::string TAB_SEPARATED_VALUES_STYPE;
# define TAB_SEPARATED_VALUES_STYPE_IS_TRIVIAL 1
# define TAB_SEPARATED_VALUES_STYPE_IS_DECLARED 1
#endif


extern TAB_SEPARATED_VALUES_STYPE tab_separated_values_lval;

int tab_separated_values_parse (vector<string> & csv_record, vector<vector<string>> & all_csv_records, int &num_fields2, int &num_lines2, std::map<int, std::string> & header_row_map2, bool &header_mode2, int &expected_fields2, vector<error_pos> & error_line_nos, bool &enable_progress_report, bool &has_last_bad_header);

#endif /* !YY_TAB_SEPARATED_VALUES_TAB_SEPARATED_VALUES_TAB_H_INCLUDED  */
