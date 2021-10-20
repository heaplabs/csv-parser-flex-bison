#include <iostream>
#include <sstream>
#include <string>

std::string json_print(std::string const & s)
{
	using std::cout;
	using std::endl;
	std::stringstream ss;
	int len = s.length();
	for (int i = 0; i < len; ++i) {
		// control characters
		if (s[i] >= 0 && s[i] < 32) {
			// control characters
			// some control chars need special handling
			// https://www.cs.cmu.edu/~pattis/15-1XX/common/handouts/ascii.html
			// https://www.json.org/json-en.html
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
			cout << "std ascii" << endl;
			if (s[i] == '"' || s[i] == '\\' || s[i] == '/') {
				ss << "\\" << s[i];
			} else {
				ss << s[i];
			}
		} else if ( ((s[i  ] & 0xb11011111) >> 5) == 0b110 && 
			    i + 1 < len &&
			    ((s[i+1] & 0xb10111111) >> 6) == 0b10
				) {
			// 2 byte unicode character
			cout << "2 byte unicode" << endl;
			ss << s[i] << s[i+1];
		} else if ( ((s[i  ] & 0xb11101111) >> 4) == 0b1110 && 
			    i + 2 < len &&
			    ((s[i+1] & 0xb10111111) >> 6) == 0b10 &&
			    ((s[i+2] & 0xb10111111) >> 6) == 0b10 
				) {
			// 3 byte unicode character
			cout << "3 byte unicode" << endl;
			ss << s[i] << s[i+1] << s[i+2];
		} else if ( ((s[i  ] & 0xb11110111) >> 3) == 0b11110 && 
			    i + 3 < len &&
			    ((s[i+1] & 0xb10111111) >> 6) == 0b10 &&
			    ((s[i+2] & 0xb10111111) >> 6) == 0b10 &&
			    ((s[i+3] & 0xb10111111) >> 6) == 0b10 
				) {
		} else {
			// 4 byte unicode character
			cout << "4 byte unicode" << endl;
			ss << s[i] << s[i+1] << s[i+2] << s[i+3];
		}
	}
	return ss.str();
}

int main()
{
	using std::endl;
	using std::cout;
	using std::string;
	//https://www.cogsci.ed.ac.uk/~richard/unicode-sample.html

	string s1="This is a line of text";
	cout << json_print(s1) << endl;
	string s2="This \"	  is \\ /  a line of text";
	string basic_latin = "     ! \" # $ % & ' ( ) * + , - . / 0 1 2 3 4 5 6 7 8 9 : ; < = > ? @ A B C D E F G H I J K L M N O P Q R S T U V W X Y Z [ \\ ] ^ _ ` a b c d e f g h i j k l m n o p q r s t u v w x y z { | } ~ ";
	;
	cout << json_print(basic_latin) << endl;
	string latin1_supplement = "      ¡ ¢ £ ¤ ¥ ¦ § ¨ © ª « ¬ ­ ® ¯ ° ± ² ³ ´ µ ¶ · ¸ ¹ º » ¼ ½ ¾ ¿ À Á Â Ã Ä Å Æ Ç È É Ê Ë Ì Í Î Ï Ð Ñ Ò Ó Ô Õ Ö × Ø Ù Ú Û Ü Ý Þ ß à á â ã ä å æ ç è é ê ë ì í î ï ð ñ ò ó ô õ ö ÷ ø ù ú û ü ý þ ÿ";
	cout << json_print(latin1_supplement) << endl;
	string latin_extended_a = "    Ā ā Ă ă Ą ą Ć ć Ĉ ĉ Ċ ċ Č č Ď ď Đ đ Ē ē Ĕ ĕ Ė ė Ę ę Ě ě Ĝ ĝ Ğ ğ Ġ ġ Ģ ģ Ĥ ĥ Ħ ħ Ĩ ĩ Ī ī Ĭ ĭ Į į İ ı Ĳ ĳ Ĵ ĵ Ķ ķ ĸ Ĺ ĺ Ļ ļ Ľ ľ Ŀ ŀ Ł ł Ń ń Ņ ņ Ň ň ŉ Ŋ ŋ Ō ō Ŏ ŏ Ő ő Œ œ Ŕ ŕ Ŗ ŗ Ř ř Ś ś Ŝ ŝ Ş ş Š š Ţ ţ Ť ť Ŧ ŧ Ũ ũ Ū ū Ŭ ŭ Ů ů Ű ű Ų ų Ŵ ŵ Ŷ ŷ Ÿ Ź ź Ż ż Ž ž ſ";

	cout << json_print(latin_extended_a) << endl;
	string latin_extended_b = "    ƀ Ɓ Ƃ ƃ Ƅ ƅ Ɔ Ƈ ƈ Ɖ Ɗ Ƌ ƌ ƍ Ǝ Ə Ɛ Ƒ ƒ Ɠ Ɣ ƕ Ɩ Ɨ Ƙ ƙ ƚ ƛ Ɯ Ɲ ƞ Ɵ Ơ ơ Ƣ ƣ Ƥ ƥ Ʀ Ƨ ƨ Ʃ ƪ ƫ Ƭ ƭ Ʈ Ư ư Ʊ Ʋ Ƴ ƴ Ƶ ƶ Ʒ Ƹ ƹ ƺ ƻ Ƽ ƽ ƾ ƿ ǀ ǁ ǂ ǃ Ǆ ǅ ǆ Ǉ ǈ ǉ Ǌ ǋ ǌ Ǎ ǎ Ǐ ǐ Ǒ ǒ Ǔ ǔ Ǖ ǖ Ǘ ǘ Ǚ ǚ Ǜ ǜ ǝ Ǟ ǟ Ǡ ǡ Ǣ ǣ Ǥ ǥ Ǧ ǧ Ǩ ǩ Ǫ ǫ Ǭ ǭ Ǯ ǯ ǰ Ǳ ǲ ǳ Ǵ ǵ Ǻ ǻ Ǽ ǽ Ǿ ǿ Ȁ ȁ Ȃ ȃ ...";
	cout << json_print(latin_extended_b) << endl;
	string ipa_extension = "    ɐ ɑ ɒ ɓ ɔ ɕ ɖ ɗ ɘ ə ɚ ɛ ɜ ɝ ɞ ɟ ɠ ɡ ɢ ɣ ɤ ɥ ɦ ɧ ɨ ɩ ɪ ɫ ɬ ɭ ɮ ɯ ɰ ɱ ɲ ɳ ɴ ɵ ɶ ɷ ɸ ɹ ɺ ɻ ɼ ɽ ɾ ɿ ʀ ʁ ʂ ʃ ʄ ʅ ʆ ʇ ʈ ʉ ʊ ʋ ʌ ʍ ʎ ʏ ʐ ʑ ʒ ʓ ʔ ʕ ʖ ʗ ʘ ʙ ʚ ʛ ʜ ʝ ʞ ʟ ʠ ʡ ʢ ʣ ʤ ʥ ʦ ʧ ʨ ";
	cout << json_print(ipa_extension) << endl;
}
