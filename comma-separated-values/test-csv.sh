
file=csv-test-files/inp1.csv
echo "processing $file"
#res=./csv2_ubuntu.exe $file  
./csv2_ubuntu.exe $file
if [ $? -ne 0 ]; then
	echo "parsing failed $file"
	exit 1
fi

file=csv-test-files/inp2.csv
echo "processing $file"
./csv2_ubuntu.exe $file
if [ $? -ne 0 ]; then
	echo "parsing failed $file"
	exit 1
fi

file=csv-test-files/inp3.csv
echo "processing $file"
./csv2_ubuntu.exe $file
if [ $? -ne 0 ]; then
	echo "parsing failed $file"
	exit 1
fi

file=csv-test-files/inp4.csv
echo "processing $file"
./csv2_ubuntu.exe $file
if [ $? -ne 0 ]; then
	echo "parsing failed $file"
	exit 1
fi

file=csv-test-files/inp5.csv
echo "processing $file"
./csv2_ubuntu.exe $file
if [ $? -ne 0 ]; then
	echo "parsing failed $file"
	exit 1
fi

file=csv-test-files/inp8a-one-field-less.csv
echo "processing $file"
./csv2_ubuntu.exe $file
if [ $? -ne 0 ]; then
	echo "parsing failed $file"
	exit 1
fi

file=csv-test-files/inp8b-one-field-more.csv
echo "processing $file"
./csv2_ubuntu.exe $file
if [ $? -ne 0 ]; then
	echo "parsing failed $file"
	exit 1
fi

file=csv-test-files/inp8.csv
echo "processing $file"
./csv2_ubuntu.exe $file
if [ $? -ne 0 ]; then
	echo "parsing failed $file"
	exit 1
fi

file=csv-test-files/inp9-syntax-err.csv
echo "processing $file"
./csv2_ubuntu.exe $file
if [ $? -ne 0 ]; then
	echo "parsing failed $file"
	exit 1
fi

#csv-test-files/1621055055104_Digital-Marketing-List--Size-1-10.csv
#csv-test-files/1625811567972_Geneva Management-01_1.csv
#csv-test-files/1627657197078_Automotive_email-new-032.csv
#csv-test-files/1627902072830_family law attorney_email-new-001.csv
#csv-test-files/1631161480590_prospects_mondaycall_1631161059121_export.csv
#csv-test-files/1632413257817_Chris_CR_09222021.csv
#csv-test-files/1633668806822_Liste FE.csv
#csv-test-files/auto-csv-fail.csv
#csv-test-files/bad1.csv
#csv-test-files/bad2.csv
#csv-test-files/bad3-auto.csv
#csv-test-files/USA_Campaign_700.csv
#csv-test-files/Kim_092221.csv

file=csv-test-files/comma_in_quotes.csv
echo "processing $file"
./csv2_ubuntu.exe $file
if [ $? -ne 0 ]; then
	echo "parsing failed $file"
	exit 1
fi

file=csv-test-files/comma_in_quotes-newl.csv
echo "processing $file"
./csv2_ubuntu.exe $file
if [ $? -ne 0 ]; then
	echo "parsing failed $file"
	exit 1
fi

file=csv-test-files/empty_crlf.csv
echo "processing $file"
./csv2_ubuntu.exe $file
if [ $? -ne 0 ]; then
	echo "parsing failed $file"
	exit 1
fi

file=csv-test-files/empty.csv
echo "processing $file"
./csv2_ubuntu.exe $file
if [ $? -ne 0 ]; then
	echo "parsing failed $file"
	exit 1
fi

file=csv-test-files/escaped_quotes.csv
echo "processing $file"
./csv2_ubuntu.exe $file
if [ $? -ne 0 ]; then
	echo "parsing failed $file"
	exit 1
fi

file=csv-test-files/inp-10-empty-last-field
echo "processing $file"
./csv2_ubuntu.exe $file
if [ $? -ne 0 ]; then
	echo "parsing failed $file"
	exit 1
fi

file=csv-test-files/inp-10-empty-last-field-b
echo "processing $file"
./csv2_ubuntu.exe $file
if [ $? -ne 0 ]; then
	echo "parsing failed $file"
	exit 1
fi

file=csv-test-files/inp-10-empty-last-field-c
echo "processing $file"
./csv2_ubuntu.exe $file
if [ $? -ne 0 ]; then
	echo "parsing failed $file"
	exit 1
fi

#file=csv-test-files/inp-11-misplaced-quote.csv
#echo "processing $file"
#./csv2_ubuntu.exe $file
#if [ $? -ne 0 ]; then
#	echo "parsing failed $file"
#	exit 1
#fi

file=csv-test-files/json.csv
echo "processing $file"
./csv2_ubuntu.exe $file
if [ $? -ne 0 ]; then
	echo "parsing failed $file"
	exit 1
fi

#file=csv-test-files/misplaced-double-quote.csv
#echo "processing $file"
#./csv2_ubuntu.exe $file
#if [ $? -ne 0 ]; then
#	echo "parsing failed $file"
#	exit 1
#fi

file=csv-test-files/newlines_crlf.csv
echo "processing $file"
./csv2_ubuntu.exe $file
if [ $? -ne 0 ]; then
	echo "parsing failed $file"
	exit 1
fi

file=csv-test-files/newlines.csv
echo "processing $file"
./csv2_ubuntu.exe $file
if [ $? -ne 0 ]; then
	echo "parsing failed $file"
	exit 1
fi

file=csv-test-files/quotes_and_newlines.csv
echo "processing $file"
./csv2_ubuntu.exe $file
if [ $? -ne 0 ]; then
	echo "parsing failed $file"
	exit 1
fi

file=csv-test-files/sample-header.csv
echo "processing $file"
./csv2_ubuntu.exe $file
if [ $? -ne 0 ]; then
	echo "parsing failed $file"
	exit 1
fi

file=csv-test-files/simple_crlf.csv
echo "processing $file"
./csv2_ubuntu.exe $file
if [ $? -ne 0 ]; then
	echo "parsing failed $file"
	exit 1
fi

file=csv-test-files/simple.csv
echo "processing $file"
./csv2_ubuntu.exe $file
if [ $? -ne 0 ]; then
	echo "parsing failed $file"
	exit 1
fi

file=csv-test-files/utf8.csv
echo "processing $file"
./csv2_ubuntu.exe $file
if [ $? -ne 0 ]; then
	echo "parsing failed $file"
	exit 1
fi


file=csv-test-files/field-length-exceeded-error.csv
echo "processing $file"
./csv2_ubuntu.exe $file
if [ $? -eq 0 ]; then
	echo "parsing failed $file"
	exit 1
fi

echo " All tests passed"
