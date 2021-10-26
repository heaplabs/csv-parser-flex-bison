/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison implementation for Yacc-like parsers in C

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

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "3.5.1"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* First part of user prologue.  */
#line 8 "csv.y"

	#include <stdio.h>
	int yylex(void);
	//void yyerror(char const *);
	#include <string>
	#include <vector>
	#include <map>
	#include <bitset>
	using std::string;
	using std::vector;
	using std::map;
	//vector<string> csv_record;
	//vector<vector<string>> all_csv_records;
	#include <iostream>
	#include <utility>
	using std::cout;
	using std::endl;

	void yyerror ( vector<string> & csv_record, 
		vector<vector<string>> & all_csv_records,
		char const *s);

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

#line 113 "csv.tab.c"

# ifndef YY_CAST
#  ifdef __cplusplus
#   define YY_CAST(Type, Val) static_cast<Type> (Val)
#   define YY_REINTERPRET_CAST(Type, Val) reinterpret_cast<Type> (Val)
#  else
#   define YY_CAST(Type, Val) ((Type) (Val))
#   define YY_REINTERPRET_CAST(Type, Val) ((Type) (Val))
#  endif
# endif
# ifndef YY_NULLPTR
#  if defined __cplusplus
#   if 201103L <= __cplusplus
#    define YY_NULLPTR nullptr
#   else
#    define YY_NULLPTR 0
#   endif
#  else
#   define YY_NULLPTR ((void*)0)
#  endif
# endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 1
#endif

/* Use api.header.include to #include this header
   instead of duplicating it here.  */
#ifndef YY_YY_CSV_TAB_H_INCLUDED
# define YY_YY_CSV_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    CSV_FIELD = 258,
    QUOTED_CSV_FIELD = 259,
    DOUBLE_QUOTE = 260
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef std::string YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (vector<string> & csv_record, vector<vector<string>> & all_csv_records);
/* "%code provides" blocks.  */
#line 1 "csv.y"

	#include <string>
	#include <vector>
	using std::string;
	using std::vector;

#line 186 "csv.tab.c"

#endif /* !YY_YY_CSV_TAB_H_INCLUDED  */



#ifdef short
# undef short
#endif

/* On compilers that do not define __PTRDIFF_MAX__ etc., make sure
   <limits.h> and (if available) <stdint.h> are included
   so that the code can choose integer types of a good width.  */

#ifndef __PTRDIFF_MAX__
# include <limits.h> /* INFRINGES ON USER NAME SPACE */
# if defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stdint.h> /* INFRINGES ON USER NAME SPACE */
#  define YY_STDINT_H
# endif
#endif

/* Narrow types that promote to a signed type and that can represent a
   signed or unsigned integer of at least N bits.  In tables they can
   save space and decrease cache pressure.  Promoting to a signed type
   helps avoid bugs in integer arithmetic.  */

#ifdef __INT_LEAST8_MAX__
typedef __INT_LEAST8_TYPE__ yytype_int8;
#elif defined YY_STDINT_H
typedef int_least8_t yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef __INT_LEAST16_MAX__
typedef __INT_LEAST16_TYPE__ yytype_int16;
#elif defined YY_STDINT_H
typedef int_least16_t yytype_int16;
#else
typedef short yytype_int16;
#endif

#if defined __UINT_LEAST8_MAX__ && __UINT_LEAST8_MAX__ <= __INT_MAX__
typedef __UINT_LEAST8_TYPE__ yytype_uint8;
#elif (!defined __UINT_LEAST8_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST8_MAX <= INT_MAX)
typedef uint_least8_t yytype_uint8;
#elif !defined __UINT_LEAST8_MAX__ && UCHAR_MAX <= INT_MAX
typedef unsigned char yytype_uint8;
#else
typedef short yytype_uint8;
#endif

#if defined __UINT_LEAST16_MAX__ && __UINT_LEAST16_MAX__ <= __INT_MAX__
typedef __UINT_LEAST16_TYPE__ yytype_uint16;
#elif (!defined __UINT_LEAST16_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST16_MAX <= INT_MAX)
typedef uint_least16_t yytype_uint16;
#elif !defined __UINT_LEAST16_MAX__ && USHRT_MAX <= INT_MAX
typedef unsigned short yytype_uint16;
#else
typedef int yytype_uint16;
#endif

#ifndef YYPTRDIFF_T
# if defined __PTRDIFF_TYPE__ && defined __PTRDIFF_MAX__
#  define YYPTRDIFF_T __PTRDIFF_TYPE__
#  define YYPTRDIFF_MAXIMUM __PTRDIFF_MAX__
# elif defined PTRDIFF_MAX
#  ifndef ptrdiff_t
#   include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  endif
#  define YYPTRDIFF_T ptrdiff_t
#  define YYPTRDIFF_MAXIMUM PTRDIFF_MAX
# else
#  define YYPTRDIFF_T long
#  define YYPTRDIFF_MAXIMUM LONG_MAX
# endif
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned
# endif
#endif

#define YYSIZE_MAXIMUM                                  \
  YY_CAST (YYPTRDIFF_T,                                 \
           (YYPTRDIFF_MAXIMUM < YY_CAST (YYSIZE_T, -1)  \
            ? YYPTRDIFF_MAXIMUM                         \
            : YY_CAST (YYSIZE_T, -1)))

#define YYSIZEOF(X) YY_CAST (YYPTRDIFF_T, sizeof (X))

/* Stored state numbers (used for stacks). */
typedef yytype_int8 yy_state_t;

/* State numbers in computations.  */
typedef int yy_state_fast_t;

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif

#ifndef YY_ATTRIBUTE_PURE
# if defined __GNUC__ && 2 < __GNUC__ + (96 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_PURE __attribute__ ((__pure__))
# else
#  define YY_ATTRIBUTE_PURE
# endif
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# if defined __GNUC__ && 2 < __GNUC__ + (7 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_UNUSED __attribute__ ((__unused__))
# else
#  define YY_ATTRIBUTE_UNUSED
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif

#if defined __GNUC__ && ! defined __ICC && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                            \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")              \
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# define YY_IGNORE_MAYBE_UNINITIALIZED_END      \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif

#if defined __cplusplus && defined __GNUC__ && ! defined __ICC && 6 <= __GNUC__
# define YY_IGNORE_USELESS_CAST_BEGIN                          \
    _Pragma ("GCC diagnostic push")                            \
    _Pragma ("GCC diagnostic ignored \"-Wuseless-cast\"")
# define YY_IGNORE_USELESS_CAST_END            \
    _Pragma ("GCC diagnostic pop")
#endif
#ifndef YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_END
#endif


#define YY_ASSERT(E) ((void) (0 && (E)))

#if 1

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
# define YYCOPY_NEEDED 1
#endif


#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yy_state_t yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (YYSIZEOF (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (YYSIZEOF (yy_state_t) + YYSIZEOF (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYPTRDIFF_T yynewbytes;                                         \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * YYSIZEOF (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / YYSIZEOF (*yyptr);                        \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, YY_CAST (YYSIZE_T, (Count)) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYPTRDIFF_T yyi;                      \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  6
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   13

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  8
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  4
/* YYNRULES -- Number of rules.  */
#define YYNRULES  9
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  13

#define YYUNDEFTOK  2
#define YYMAXUTOK   260


/* YYTRANSLATE(TOKEN-NUM) -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, with out-of-bounds checking.  */
#define YYTRANSLATE(YYX)                                                \
  (0 <= (YYX) && (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex.  */
static const yytype_int8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       6,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     7,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5
};

#if YYDEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_int16 yyrline[] =
{
       0,    68,    68,   124,   208,   226,   233,   243,   262,   269
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || 1
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "CSV_FIELD", "QUOTED_CSV_FIELD",
  "DOUBLE_QUOTE", "'\\n'", "','", "$accept", "input", "record",
  "csv_field", YY_NULLPTR
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[NUM] -- (External) token number corresponding to the
   (internal) symbol number NUM (which must be that of a token).  */
static const yytype_int16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,    10,    44
};
# endif

#define YYPACT_NINF (-6)

#define yypact_value_is_default(Yyn) \
  ((Yyn) == YYPACT_NINF)

#define YYTABLE_NINF (-8)

#define yytable_value_is_error(Yyn) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int8 yypact[] =
{
       5,    -6,    -6,     0,     4,    -6,    -6,    -6,     6,    -6,
       5,    -6,    -6
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_int8 yydefact[] =
{
       7,     8,     9,     0,     0,     5,     1,     4,     0,     2,
       7,     3,     6
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int8 yypgoto[] =
{
      -6,    -6,    -1,    -5
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
      -1,     3,     4,     5
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_int8 yytable[] =
{
       6,     7,     8,     1,     2,    12,    -7,    -7,     1,     2,
       9,    10,    11,    10
};

static const yytype_int8 yycheck[] =
{
       0,     1,     3,     3,     4,    10,     6,     7,     3,     4,
       6,     7,     6,     7
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_int8 yystos[] =
{
       0,     3,     4,     9,    10,    11,     0,     1,    10,     6,
       7,     6,    11
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_int8 yyr1[] =
{
       0,     8,     9,     9,     9,    10,    10,    11,    11,    11
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_int8 yyr2[] =
{
       0,     2,     2,     3,     2,     1,     3,     0,     1,     1
};


#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)
#define YYEMPTY         (-2)
#define YYEOF           0

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                    \
  do                                                              \
    if (yychar == YYEMPTY)                                        \
      {                                                           \
        yychar = (Token);                                         \
        yylval = (Value);                                         \
        YYPOPSTACK (yylen);                                       \
        yystate = *yyssp;                                         \
        YY_LAC_DISCARD ("YYBACKUP");                              \
        goto yybackup;                                            \
      }                                                           \
    else                                                          \
      {                                                           \
        yyerror (csv_record, all_csv_records, YY_("syntax error: cannot back up")); \
        YYERROR;                                                  \
      }                                                           \
  while (0)

/* Error token number */
#define YYTERROR        1
#define YYERRCODE       256



/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)

/* This macro is provided for backward compatibility. */
#ifndef YY_LOCATION_PRINT
# define YY_LOCATION_PRINT(File, Loc) ((void) 0)
#endif


# define YY_SYMBOL_PRINT(Title, Type, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Type, Value, csv_record, all_csv_records); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*-----------------------------------.
| Print this symbol's value on YYO.  |
`-----------------------------------*/

static void
yy_symbol_value_print (FILE *yyo, int yytype, YYSTYPE const * const yyvaluep, vector<string> & csv_record, vector<vector<string>> & all_csv_records)
{
  FILE *yyoutput = yyo;
  YYUSE (yyoutput);
  YYUSE (csv_record);
  YYUSE (all_csv_records);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyo, yytoknum[yytype], *yyvaluep);
# endif
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/*---------------------------.
| Print this symbol on YYO.  |
`---------------------------*/

static void
yy_symbol_print (FILE *yyo, int yytype, YYSTYPE const * const yyvaluep, vector<string> & csv_record, vector<vector<string>> & all_csv_records)
{
  YYFPRINTF (yyo, "%s %s (",
             yytype < YYNTOKENS ? "token" : "nterm", yytname[yytype]);

  yy_symbol_value_print (yyo, yytype, yyvaluep, csv_record, all_csv_records);
  YYFPRINTF (yyo, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yy_state_t *yybottom, yy_state_t *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yy_state_t *yyssp, YYSTYPE *yyvsp, int yyrule, vector<string> & csv_record, vector<vector<string>> & all_csv_records)
{
  int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %d):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       yystos[+yyssp[yyi + 1 - yynrhs]],
                       &yyvsp[(yyi + 1) - (yynrhs)]
                                              , csv_record, all_csv_records);
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule, csv_record, all_csv_records); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif

/* Given a state stack such that *YYBOTTOM is its bottom, such that
   *YYTOP is either its top or is YYTOP_EMPTY to indicate an empty
   stack, and such that *YYCAPACITY is the maximum number of elements it
   can hold without a reallocation, make sure there is enough room to
   store YYADD more elements.  If not, allocate a new stack using
   YYSTACK_ALLOC, copy the existing elements, and adjust *YYBOTTOM,
   *YYTOP, and *YYCAPACITY to reflect the new capacity and memory
   location.  If *YYBOTTOM != YYBOTTOM_NO_FREE, then free the old stack
   using YYSTACK_FREE.  Return 0 if successful or if no reallocation is
   required.  Return 1 if memory is exhausted.  */
static int
yy_lac_stack_realloc (YYPTRDIFF_T *yycapacity, YYPTRDIFF_T yyadd,
#if YYDEBUG
                      char const *yydebug_prefix,
                      char const *yydebug_suffix,
#endif
                      yy_state_t **yybottom,
                      yy_state_t *yybottom_no_free,
                      yy_state_t **yytop, yy_state_t *yytop_empty)
{
  YYPTRDIFF_T yysize_old =
    *yytop == yytop_empty ? 0 : *yytop - *yybottom + 1;
  YYPTRDIFF_T yysize_new = yysize_old + yyadd;
  if (*yycapacity < yysize_new)
    {
      YYPTRDIFF_T yyalloc = 2 * yysize_new;
      yy_state_t *yybottom_new;
      /* Use YYMAXDEPTH for maximum stack size given that the stack
         should never need to grow larger than the main state stack
         needs to grow without LAC.  */
      if (YYMAXDEPTH < yysize_new)
        {
          YYDPRINTF ((stderr, "%smax size exceeded%s", yydebug_prefix,
                      yydebug_suffix));
          return 1;
        }
      if (YYMAXDEPTH < yyalloc)
        yyalloc = YYMAXDEPTH;
      yybottom_new =
        YY_CAST (yy_state_t *,
                 YYSTACK_ALLOC (YY_CAST (YYSIZE_T,
                                         yyalloc * YYSIZEOF (*yybottom_new))));
      if (!yybottom_new)
        {
          YYDPRINTF ((stderr, "%srealloc failed%s", yydebug_prefix,
                      yydebug_suffix));
          return 1;
        }
      if (*yytop != yytop_empty)
        {
          YYCOPY (yybottom_new, *yybottom, yysize_old);
          *yytop = yybottom_new + (yysize_old - 1);
        }
      if (*yybottom != yybottom_no_free)
        YYSTACK_FREE (*yybottom);
      *yybottom = yybottom_new;
      *yycapacity = yyalloc;
    }
  return 0;
}

/* Establish the initial context for the current lookahead if no initial
   context is currently established.

   We define a context as a snapshot of the parser stacks.  We define
   the initial context for a lookahead as the context in which the
   parser initially examines that lookahead in order to select a
   syntactic action.  Thus, if the lookahead eventually proves
   syntactically unacceptable (possibly in a later context reached via a
   series of reductions), the initial context can be used to determine
   the exact set of tokens that would be syntactically acceptable in the
   lookahead's place.  Moreover, it is the context after which any
   further semantic actions would be erroneous because they would be
   determined by a syntactically unacceptable token.

   YY_LAC_ESTABLISH should be invoked when a reduction is about to be
   performed in an inconsistent state (which, for the purposes of LAC,
   includes consistent states that don't know they're consistent because
   their default reductions have been disabled).  Iff there is a
   lookahead token, it should also be invoked before reporting a syntax
   error.  This latter case is for the sake of the debugging output.

   For parse.lac=full, the implementation of YY_LAC_ESTABLISH is as
   follows.  If no initial context is currently established for the
   current lookahead, then check if that lookahead can eventually be
   shifted if syntactic actions continue from the current context.
   Report a syntax error if it cannot.  */
#define YY_LAC_ESTABLISH                                         \
do {                                                             \
  if (!yy_lac_established)                                       \
    {                                                            \
      YYDPRINTF ((stderr,                                        \
                  "LAC: initial context established for %s\n",   \
                  yytname[yytoken]));                            \
      yy_lac_established = 1;                                    \
      {                                                          \
        int yy_lac_status =                                      \
          yy_lac (yyesa, &yyes, &yyes_capacity, yyssp, yytoken); \
        if (yy_lac_status == 2)                                  \
          goto yyexhaustedlab;                                   \
        if (yy_lac_status == 1)                                  \
          goto yyerrlab;                                         \
      }                                                          \
    }                                                            \
} while (0)

/* Discard any previous initial lookahead context because of Event,
   which may be a lookahead change or an invalidation of the currently
   established initial context for the current lookahead.

   The most common example of a lookahead change is a shift.  An example
   of both cases is syntax error recovery.  That is, a syntax error
   occurs when the lookahead is syntactically erroneous for the
   currently established initial context, so error recovery manipulates
   the parser stacks to try to find a new initial context in which the
   current lookahead is syntactically acceptable.  If it fails to find
   such a context, it discards the lookahead.  */
#if YYDEBUG
# define YY_LAC_DISCARD(Event)                                           \
do {                                                                     \
  if (yy_lac_established)                                                \
    {                                                                    \
      if (yydebug)                                                       \
        YYFPRINTF (stderr, "LAC: initial context discarded due to "      \
                   Event "\n");                                          \
      yy_lac_established = 0;                                            \
    }                                                                    \
} while (0)
#else
# define YY_LAC_DISCARD(Event) yy_lac_established = 0
#endif

/* Given the stack whose top is *YYSSP, return 0 iff YYTOKEN can
   eventually (after perhaps some reductions) be shifted, return 1 if
   not, or return 2 if memory is exhausted.  As preconditions and
   postconditions: *YYES_CAPACITY is the allocated size of the array to
   which *YYES points, and either *YYES = YYESA or *YYES points to an
   array allocated with YYSTACK_ALLOC.  yy_lac may overwrite the
   contents of either array, alter *YYES and *YYES_CAPACITY, and free
   any old *YYES other than YYESA.  */
static int
yy_lac (yy_state_t *yyesa, yy_state_t **yyes,
        YYPTRDIFF_T *yyes_capacity, yy_state_t *yyssp, int yytoken)
{
  yy_state_t *yyes_prev = yyssp;
  yy_state_t *yyesp = yyes_prev;
  YYDPRINTF ((stderr, "LAC: checking lookahead %s:", yytname[yytoken]));
  if (yytoken == YYUNDEFTOK)
    {
      YYDPRINTF ((stderr, " Always Err\n"));
      return 1;
    }
  while (1)
    {
      int yyrule = yypact[+*yyesp];
      if (yypact_value_is_default (yyrule)
          || (yyrule += yytoken) < 0 || YYLAST < yyrule
          || yycheck[yyrule] != yytoken)
        {
          yyrule = yydefact[+*yyesp];
          if (yyrule == 0)
            {
              YYDPRINTF ((stderr, " Err\n"));
              return 1;
            }
        }
      else
        {
          yyrule = yytable[yyrule];
          if (yytable_value_is_error (yyrule))
            {
              YYDPRINTF ((stderr, " Err\n"));
              return 1;
            }
          if (0 < yyrule)
            {
              YYDPRINTF ((stderr, " S%d\n", yyrule));
              return 0;
            }
          yyrule = -yyrule;
        }
      {
        YYPTRDIFF_T yylen = yyr2[yyrule];
        YYDPRINTF ((stderr, " R%d", yyrule - 1));
        if (yyesp != yyes_prev)
          {
            YYPTRDIFF_T yysize = yyesp - *yyes + 1;
            if (yylen < yysize)
              {
                yyesp -= yylen;
                yylen = 0;
              }
            else
              {
                yylen -= yysize;
                yyesp = yyes_prev;
              }
          }
        if (yylen)
          yyesp = yyes_prev -= yylen;
      }
      {
        yy_state_fast_t yystate;
        {
          const int yylhs = yyr1[yyrule] - YYNTOKENS;
          const int yyi = yypgoto[yylhs] + *yyesp;
          yystate = (0 <= yyi && yyi <= YYLAST && yycheck[yyi] == *yyesp
                     ? yytable[yyi]
                     : yydefgoto[yylhs]);
        }
        if (yyesp == yyes_prev)
          {
            yyesp = *yyes;
            YY_IGNORE_USELESS_CAST_BEGIN
            *yyesp = YY_CAST (yy_state_t, yystate);
            YY_IGNORE_USELESS_CAST_END
          }
        else
          {
            if (yy_lac_stack_realloc (yyes_capacity, 1,
#if YYDEBUG
                                      " (", ")",
#endif
                                      yyes, yyesa, &yyesp, yyes_prev))
              {
                YYDPRINTF ((stderr, "\n"));
                return 2;
              }
            YY_IGNORE_USELESS_CAST_BEGIN
            *++yyesp = YY_CAST (yy_state_t, yystate);
            YY_IGNORE_USELESS_CAST_END
          }
        YYDPRINTF ((stderr, " G%d", yystate));
      }
    }
}


#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen(S) (YY_CAST (YYPTRDIFF_T, strlen (S)))
#  else
/* Return the length of YYSTR.  */
static YYPTRDIFF_T
yystrlen (const char *yystr)
{
  YYPTRDIFF_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
yystpcpy (char *yydest, const char *yysrc)
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYPTRDIFF_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYPTRDIFF_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
        switch (*++yyp)
          {
          case '\'':
          case ',':
            goto do_not_strip_quotes;

          case '\\':
            if (*++yyp != '\\')
              goto do_not_strip_quotes;
            else
              goto append;

          append:
          default:
            if (yyres)
              yyres[yyn] = *yyp;
            yyn++;
            break;

          case '"':
            if (yyres)
              yyres[yyn] = '\0';
            return yyn;
          }
    do_not_strip_quotes: ;
    }

  if (yyres)
    return yystpcpy (yyres, yystr) - yyres;
  else
    return yystrlen (yystr);
}
# endif

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.  In order to see if a particular token T is a
   valid looakhead, invoke yy_lac (YYESA, YYES, YYES_CAPACITY, YYSSP, T).

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store or if
   yy_lac returned 2.  */
static int
yysyntax_error (YYPTRDIFF_T *yymsg_alloc, char **yymsg,
                yy_state_t *yyesa, yy_state_t **yyes,
                YYPTRDIFF_T *yyes_capacity, yy_state_t *yyssp, int yytoken)
{
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULLPTR;
  /* Arguments of yyformat: reported tokens (one for the "unexpected",
     one per "expected"). */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Actual size of YYARG. */
  int yycount = 0;
  /* Cumulated lengths of YYARG.  */
  YYPTRDIFF_T yysize = 0;

  /* There are many possibilities here to consider:
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
       In the first two cases, it might appear that the current syntax
       error should have been detected in the previous state when yy_lac
       was invoked.  However, at that time, there might have been a
       different syntax error that discarded a different initial context
       during error recovery, leaving behind the current lookahead.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[+*yyssp];
      YYPTRDIFF_T yysize0 = yytnamerr (YY_NULLPTR, yytname[yytoken]);
      yysize = yysize0;
      YYDPRINTF ((stderr, "Constructing syntax error message\n"));
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          int yyx;

          for (yyx = 0; yyx < YYNTOKENS; ++yyx)
            if (yyx != YYTERROR && yyx != YYUNDEFTOK)
              {
                {
                  int yy_lac_status = yy_lac (yyesa, yyes, yyes_capacity,
                                              yyssp, yyx);
                  if (yy_lac_status == 2)
                    return 2;
                  if (yy_lac_status == 1)
                    continue;
                }
                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                  {
                    yycount = 1;
                    yysize = yysize0;
                    break;
                  }
                yyarg[yycount++] = yytname[yyx];
                {
                  YYPTRDIFF_T yysize1
                    = yysize + yytnamerr (YY_NULLPTR, yytname[yyx]);
                  if (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM)
                    yysize = yysize1;
                  else
                    return 2;
                }
              }
        }
# if YYDEBUG
      else if (yydebug)
        YYFPRINTF (stderr, "No expected tokens.\n");
# endif
    }

  switch (yycount)
    {
# define YYCASE_(N, S)                      \
      case N:                               \
        yyformat = S;                       \
      break
    default: /* Avoid compiler warnings. */
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  {
    /* Don't count the "%s"s in the final size, but reserve room for
       the terminator.  */
    YYPTRDIFF_T yysize1 = yysize + (yystrlen (yyformat) - 2 * yycount) + 1;
    if (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM)
      yysize = yysize1;
    else
      return 2;
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return 1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yyarg[yyi++]);
          yyformat += 2;
        }
      else
        {
          ++yyp;
          ++yyformat;
        }
  }
  return 0;
}
#endif /* YYERROR_VERBOSE */

/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep, vector<string> & csv_record, vector<vector<string>> & all_csv_records)
{
  YYUSE (yyvaluep);
  YYUSE (csv_record);
  YYUSE (all_csv_records);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}




/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;


/*----------.
| yyparse.  |
`----------*/

int
yyparse (vector<string> & csv_record, vector<vector<string>> & all_csv_records)
{
    yy_state_fast_t yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       'yyss': related to states.
       'yyvs': related to semantic values.

       Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yy_state_t yyssa[YYINITDEPTH];
    yy_state_t *yyss;
    yy_state_t *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    YYPTRDIFF_T yystacksize;

    yy_state_t yyesa[20];
    yy_state_t *yyes;
    YYPTRDIFF_T yyes_capacity;

  int yy_lac_established = 0;
  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYPTRDIFF_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yyssp = yyss = yyssa;
  yyvsp = yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  yyes = yyesa;
  yyes_capacity = 20;
  if (YYMAXDEPTH < yyes_capacity)
    yyes_capacity = YYMAXDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */
  goto yysetstate;


/*------------------------------------------------------------.
| yynewstate -- push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;


/*--------------------------------------------------------------------.
| yysetstate -- set current state (the top of the stack) to yystate.  |
`--------------------------------------------------------------------*/
yysetstate:
  YYDPRINTF ((stderr, "Entering state %d\n", yystate));
  YY_ASSERT (0 <= yystate && yystate < YYNSTATES);
  YY_IGNORE_USELESS_CAST_BEGIN
  *yyssp = YY_CAST (yy_state_t, yystate);
  YY_IGNORE_USELESS_CAST_END

  if (yyss + yystacksize - 1 <= yyssp)
#if !defined yyoverflow && !defined YYSTACK_RELOCATE
    goto yyexhaustedlab;
#else
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYPTRDIFF_T yysize = yyssp - yyss + 1;

# if defined yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        yy_state_t *yyss1 = yyss;
        YYSTYPE *yyvs1 = yyvs;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * YYSIZEOF (*yyssp),
                    &yyvs1, yysize * YYSIZEOF (*yyvsp),
                    &yystacksize);
        yyss = yyss1;
        yyvs = yyvs1;
      }
# else /* defined YYSTACK_RELOCATE */
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yy_state_t *yyss1 = yyss;
        union yyalloc *yyptr =
          YY_CAST (union yyalloc *,
                   YYSTACK_ALLOC (YY_CAST (YYSIZE_T, YYSTACK_BYTES (yystacksize))));
        if (! yyptr)
          goto yyexhaustedlab;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
# undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YY_IGNORE_USELESS_CAST_BEGIN
      YYDPRINTF ((stderr, "Stack size increased to %ld\n",
                  YY_CAST (long, yystacksize)));
      YY_IGNORE_USELESS_CAST_END

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }
#endif /* !defined yyoverflow && !defined YYSTACK_RELOCATE */

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;


/*-----------.
| yybackup.  |
`-----------*/
yybackup:
  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    {
      YY_LAC_ESTABLISH;
      goto yydefault;
    }
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      YY_LAC_ESTABLISH;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);
  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  /* Discard the shifted token.  */
  yychar = YYEMPTY;
  YY_LAC_DISCARD ("shift");
  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  {
    int yychar_backup = yychar;
    switch (yyn)
      {
  case 2:
#line 68 "csv.y"
                    {
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
#line 1637 "csv.tab.c"
    break;

  case 3:
#line 124 "csv.y"
                            {

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
#line 1700 "csv.tab.c"
    break;

  case 4:
#line 208 "csv.y"
                       { 
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
#line 1720 "csv.tab.c"
    break;

  case 5:
#line 226 "csv.y"
                  {
		//csv_record.push_back($1);
		//++ num_fields2;
		//if (header_mode2) {
		//	header_row_map2[num_fields2] = $1;
		//}
	}
#line 1732 "csv.tab.c"
    break;

  case 6:
#line 233 "csv.y"
                               {
		//csv_record.push_back($3);
		//++ num_fields2;
		//if (header_mode2) {
		//	header_row_map2[num_fields2] = $1;
		//}
	}
#line 1744 "csv.tab.c"
    break;

  case 7:
#line 243 "csv.y"
               {
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
#line 1768 "csv.tab.c"
    break;

  case 8:
#line 262 "csv.y"
                    {
		csv_record.push_back(yyvsp[0]);
		++ num_fields2;
		if (header_mode2) {
			header_row_map2[num_fields2] = yyvsp[0];
		}
	}
#line 1780 "csv.tab.c"
    break;

  case 9:
#line 269 "csv.y"
                            {
		csv_record.push_back(yyvsp[0]);
		++ num_fields2;
		if (header_mode2) {
			header_row_map2[num_fields2] = yyvsp[0];
		}
	}
#line 1792 "csv.tab.c"
    break;


#line 1796 "csv.tab.c"

        default: break;
      }
    if (yychar_backup != yychar)
      YY_LAC_DISCARD ("yychar change");
  }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */
  {
    const int yylhs = yyr1[yyn] - YYNTOKENS;
    const int yyi = yypgoto[yylhs] + *yyssp;
    yystate = (0 <= yyi && yyi <= YYLAST && yycheck[yyi] == *yyssp
               ? yytable[yyi]
               : yydefgoto[yylhs]);
  }

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);

  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (csv_record, all_csv_records, YY_("syntax error"));
#else
# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
                                        yyesa, &yyes, &yyes_capacity, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        if (yychar != YYEMPTY)
          YY_LAC_ESTABLISH;
        yysyntax_error_status = YYSYNTAX_ERROR;
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == 1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = YY_CAST (char *, YYSTACK_ALLOC (YY_CAST (YYSIZE_T, yymsg_alloc)));
            if (!yymsg)
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = 2;
              }
            else
              {
                yysyntax_error_status = YYSYNTAX_ERROR;
                yymsgp = yymsg;
              }
          }
        yyerror (csv_record, all_csv_records, yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval, csv_record, all_csv_records);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:
  /* Pacify compilers when the user code never invokes YYERROR and the
     label yyerrorlab therefore never appears in user code.  */
  if (0)
    YYERROR;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYTERROR;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  yystos[yystate], yyvsp, csv_record, all_csv_records);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  /* If the stack popping above didn't lose the initial context for the
     current lookahead token, the shift below will for sure.  */
  YY_LAC_DISCARD ("error recovery");

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;


/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;


#if 1
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (csv_record, all_csv_records, YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif


/*-----------------------------------------------------.
| yyreturn -- parsing is finished, return the result.  |
`-----------------------------------------------------*/
yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval, csv_record, all_csv_records);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  yystos[+*yyssp], yyvsp, csv_record, all_csv_records);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
  if (yyes != yyesa)
    YYSTACK_FREE (yyes);
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  return yyresult;
}
#line 358 "csv.y"



/* Called by yyparse on error. */
void yyerror ( vector<string> & csv_record,
		vector<vector<string>> & all_csv_records,
		char const *s )
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
	cout << "Enter json_print: |" << s << "|" 
		<< ", len: " << s.length() <<  endl;
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
			cout << "ascii control char: " << s[i] << endl;
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
				cout << "adding backslash" << endl;
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
				cout << "wincp1252 printable char: |" << s[i] << "|,"
				 	<< ((int) ch) << endl;
				++res.n_wincp1252;
			} else if (ch >= 160 && ch <= 255) {
				cout << "iso8859 printable char: |" << s[i] << "|, " 
				 	<< ((int) ch) << endl;
				ss << "\\" << s[i];
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

	vector<string> csv_record;
	vector<vector<string>> all_csv_records;

	int status = yyparse(csv_record, all_csv_records);
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
	extern int tab_count;
	if (tab_count > 0) {
		// cout << "input file has tabs:" 
		// 	<< tab_count
		// 	<< "num_lines: " << num_lines2 << endl;
		if (tab_count > num_lines2 ) {
			//cout << "Exiting - this is a tab  separated file mostly" <<endl;
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

