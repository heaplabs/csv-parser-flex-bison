# Summary
This is a custom CSV parser written for our usecase at [SmartReach.io](https://smartreach.io)

We faced various issues with csv parsing libraries.
These were not necessarily the faults of the libraries, but rather
the varied formats of CSV files - including incorrectly formatted files that our customers 
expected to "just" work, Tab separated files and semi-colon separated files.

Finally to reduce our error rate we decided to roll our own parser.

We have seen a significant reduction in CSV errors after this.

Although the title is CSV parser - but it handles semicolon separated,
 tab separated files as well.

To see that logic - have a look at common/driver.cpp

# Prerequisites

* bison (GNU Bison) 3.5.1
* flex 2.6.4
* c++-11 
* GNU make

```
brew info flex


flex: stable 2.6.4 (bottled), HEAD [keg-only]
Fast Lexical Analyzer, generates Scanners (tokenizers)
https://github.com/westes/flex
/opt/homebrew/Cellar/flex/2.6.4_2 (46 files, 1.6MB)
Poured from bottle on 2021-09-25 at 13:48:45
From: https://github.com/Homebrew/homebrew-core/blob/HEAD/Formula/flex.rb
License: BSD-2-Clause
==> Dependencies
Build: help2man ✘
Required: gettext ✔
==> Options
--HEAD
Install HEAD version
==> Caveats
flex is keg-only, which means it was not symlinked into /opt/homebrew,
because macOS already provides this software and installing another version in
parallel can cause all kinds of trouble.

If you need to have flex first in your PATH, run:
echo 'export PATH="/opt/homebrew/opt/flex/bin:$PATH"' >> ~/.zshrc

For compilers to find flex you may need to set:
export LDFLAGS="-L/opt/homebrew/opt/flex/lib"
export CPPFLAGS="-I/opt/homebrew/opt/flex/include"

==> Analytics
install: 1,962 (30 days), 5,700 (90 days), 28,177 (365 days)
install-on-request: 1,600 (30 days), 4,605 (90 days), 22,208 (365 days)
build-error: 1 (30 days)
```

```
brew info bison


bison: stable 3.8.2 (bottled) [keg-only]
Parser generator
https://www.gnu.org/software/bison/
/opt/homebrew/Cellar/bison/3.8.2 (99 files, 3.7MB)
Poured from bottle on 2021-10-08 at 16:13:15
From: https://github.com/Homebrew/homebrew-core/blob/HEAD/Formula/bison.rb
License: GPL-3.0-or-later
==> Caveats
bison is keg-only, which means it was not symlinked into /opt/homebrew,
because macOS already provides this software and installing another version in
parallel can cause all kinds of trouble.



If you need to have bison first in your PATH, run:
echo 'export PATH="/opt/homebrew/opt/bison/bin:$PATH"' >> ~/.zshrc



For compilers to find bison you may need to set:
export LDFLAGS="-L/opt/homebrew/opt/bison/lib"



==> Analytics
install: 16,083 (30 days), 47,157 (90 days), 221,672 (365 days)
install-on-request: 10,204 (30 days), 31,108 (90 days), 136,836 (365 days)
build-error: 1 (30 days)
```

# Tested platforms
* MacOS 
* Ubuntu Linux


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

