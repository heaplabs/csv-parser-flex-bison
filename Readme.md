# Summary
This is a custom CSV parser written for our usecase at SmartReach.io

We faced various issues with csv parsing libraries and finally to 
reduce our error rate we decided to roll our own parser.

We have seen a significant reduction in CSV errors after this.

Although the title is CSV parser - but it handles semicolon separated,
 tab separated files as well.

To see that logic - have a look at common/driver.cpp

# Prerequisites

bison (GNU Bison) 3.5.1
flex 2.6.4
c++-11 
GNU make

# Tested platforms
MacOS 
Ubuntu Linux


# Building

Clone the repository:
```shell
git clone https://github.com/heaplabs/csv-parser-flex-bison.git
```

## Linux

```shell
sudo apt-get install flex bison # install if missing
cd csv-parser-flex-bison
make
```
The build is tested on Ubuntu 20.04 with :
g++ (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0

The integrated parser (for csv, tsv and semicolon separated files) will
live in `build` folder, the generated exe is : `csv2_ubuntu.exe`

## MacOS

We tested with the gnu G++-11 cpp compiler . you can install that via brew

```shell
brew install flex
brew install bison
cd csv-parser-flex-bison
make -f GNUmakefile.macos
```
The integrated parser (for csv, tsv and semicolon separated files) will
live in `build` folder, the generated exe is : `csv2_macos.exe`

## Build output 

# Running the generated parser.

The directory comma-separated-values/csv-test-files contains some sample csv files.


run the program as illustrated below:

the result of the parse is printed as a json to stdout:

## Example 1:

```shell
❯ ./build/csv2_ubuntu.exe comma-separated-values/csv-test-files/inp1.csv
```

```json
{
"expected_fields" : 3,
"n_iso_8859_1" : 0,
"n_utf8_longer_than_1byte" : 0,
"n_wincp1252" : 0,
"successfully_parsed" : 0,
"total_errors" : 0,
"total_records" : 0,
"header" :  [ 
    "abcd",
    "efgh",
    "1235"
 ] 
,
"parsed_data":[
]}
```

## Example 2:

```shell
❯ ./build/csv2_ubuntu.exe comma-separated-values/csv-test-files/inp2.csv
```

```json
{
"expected_fields" : 3,
"n_iso_8859_1" : 0,
"n_utf8_longer_than_1byte" : 0,
"n_wincp1252" : 0,
"successfully_parsed" : 4,
"total_errors" : 0,
"total_records" : 4,
"header" :  [ 
    "abcd",
    "efgh",
    "1235"
 ] 
,
"parsed_data":[
 [ 
    "abcd",
    "efgh",
    "1235"
 ] 
, [ 
    "abcd",
    "efgh",
    "1235"
 ] 
, [ 
    "abcd",
    "efgh",
    "12\t35"
 ] 
, [ 
    "abcd",
    "efgh",
    "1235"
 ] ]}
 ```

