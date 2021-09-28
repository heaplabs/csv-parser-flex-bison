Builds a parser for csv files.

To build the parser type :

$ make

Prerequisites:

Tested on Ubuntu 20.04

bison (GNU Bison) 3.5.1
flex 2.6.4

Lower versions of these programs may work, you will need to test

Running the generated parser.

the directory csv-test-files contains some sample csv files.

run the program as illustrated below

❯ ./csv2.exe < csv-test-files/inp1.csv                
 abcd efgh 1235
new rec: , num_lines2: 1, num_fields2: 3
header row, expected_fields2:3
num_lines2: 1
num_fields2: 3

❯ ./csv2.exe < csv-test-files/inp2.csv 
 abcd efgh 1235
new rec: , num_lines2: 1, num_fields2: 3
header row, expected_fields2:3
new rec: , num_lines2: 2, num_fields2: 3
new rec: , num_lines2: 3, num_fields2: 3
new rec: , num_lines2: 4, num_fields2: 3
new rec: , num_lines2: 5, num_fields2: 3
num_lines2: 5
num_fields2: 3

❯ ./csv2.exe < csv-test-files/inp3.csv 
 quotes normal field
new rec: , num_lines2: 1, num_fields2: 2
header row, expected_fields2:2
new rec: , num_lines2: 2, num_fields2: 2
new rec: , num_lines2: 3, num_fields2: 2
num_lines2: 3
num_fields2: 2


-- NxD --
setup lexer special match for 
1. csv field without quote
2. csv field with quote
3. detect quote if necessary in lexer
4. in grammar - handle case of quoted field and unquoted field separately
   if in an unquoted field you have a double quote appearing - flag as error and recover
