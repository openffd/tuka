#import "NSString+MXBZHTML.h"

typedef struct {
	__unsafe_unretained NSString *escapeSequence;
	unichar uchar;
} MXBZ_HTMLEscapeMap;

static MXBZ_HTMLEscapeMap mxbz_gAsciiHTMLEscapeMap[] = {
	{ @"&quot;", 34 },
	{ @"&amp;", 38 },
	{ @"&apos;", 39 },
	{ @"&lt;", 60 },
	{ @"&gt;", 62 },
	
	{ @"&nbsp;", 160 },
	{ @"&iexcl;", 161 }, 
	{ @"&cent;", 162 }, 
	{ @"&pound;", 163 }, 
	{ @"&curren;", 164 }, 
	{ @"&yen;", 165 }, 
	{ @"&brvbar;", 166 }, 
	{ @"&sect;", 167 }, 
	{ @"&uml;", 168 }, 
	{ @"&copy;", 169 }, 
	{ @"&ordf;", 170 }, 
	{ @"&laquo;", 171 }, 
	{ @"&not;", 172 }, 
	{ @"&shy;", 173 }, 
	{ @"&reg;", 174 }, 
	{ @"&macr;", 175 }, 
	{ @"&deg;", 176 }, 
	{ @"&plusmn;", 177 }, 
	{ @"&sup2;", 178 }, 
	{ @"&sup3;", 179 }, 
	{ @"&acute;", 180 }, 
	{ @"&micro;", 181 }, 
	{ @"&para;", 182 }, 
	{ @"&middot;", 183 }, 
	{ @"&cedil;", 184 }, 
	{ @"&sup1;", 185 }, 
	{ @"&ordm;", 186 }, 
	{ @"&raquo;", 187 }, 
	{ @"&frac14;", 188 }, 
	{ @"&frac12;", 189 }, 
	{ @"&frac34;", 190 }, 
	{ @"&iquest;", 191 }, 
	{ @"&Agrave;", 192 }, 
	{ @"&Aacute;", 193 }, 
	{ @"&Acirc;", 194 }, 
	{ @"&Atilde;", 195 }, 
	{ @"&Auml;", 196 }, 
	{ @"&Aring;", 197 }, 
	{ @"&AElig;", 198 }, 
	{ @"&Ccedil;", 199 }, 
	{ @"&Egrave;", 200 }, 
	{ @"&Eacute;", 201 }, 
	{ @"&Ecirc;", 202 }, 
	{ @"&Euml;", 203 }, 
	{ @"&Igrave;", 204 }, 
	{ @"&Iacute;", 205 }, 
	{ @"&Icirc;", 206 }, 
	{ @"&Iuml;", 207 }, 
	{ @"&ETH;", 208 }, 
	{ @"&Ntilde;", 209 }, 
	{ @"&Ograve;", 210 }, 
	{ @"&Oacute;", 211 }, 
	{ @"&Ocirc;", 212 }, 
	{ @"&Otilde;", 213 }, 
	{ @"&Ouml;", 214 }, 
	{ @"&times;", 215 }, 
	{ @"&Oslash;", 216 }, 
	{ @"&Ugrave;", 217 }, 
	{ @"&Uacute;", 218 }, 
	{ @"&Ucirc;", 219 }, 
	{ @"&Uuml;", 220 }, 
	{ @"&Yacute;", 221 }, 
	{ @"&THORN;", 222 }, 
	{ @"&szlig;", 223 }, 
	{ @"&agrave;", 224 }, 
	{ @"&aacute;", 225 }, 
	{ @"&acirc;", 226 }, 
	{ @"&atilde;", 227 }, 
	{ @"&auml;", 228 }, 
	{ @"&aring;", 229 }, 
	{ @"&aelig;", 230 }, 
	{ @"&ccedil;", 231 }, 
	{ @"&egrave;", 232 }, 
	{ @"&eacute;", 233 }, 
	{ @"&ecirc;", 234 }, 
	{ @"&euml;", 235 }, 
	{ @"&igrave;", 236 }, 
	{ @"&iacute;", 237 }, 
	{ @"&icirc;", 238 }, 
	{ @"&iuml;", 239 }, 
	{ @"&eth;", 240 }, 
	{ @"&ntilde;", 241 }, 
	{ @"&ograve;", 242 }, 
	{ @"&oacute;", 243 }, 
	{ @"&ocirc;", 244 }, 
	{ @"&otilde;", 245 }, 
	{ @"&ouml;", 246 }, 
	{ @"&divide;", 247 }, 
	{ @"&oslash;", 248 }, 
	{ @"&ugrave;", 249 }, 
	{ @"&uacute;", 250 }, 
	{ @"&ucirc;", 251 }, 
	{ @"&uuml;", 252 }, 
	{ @"&yacute;", 253 }, 
	{ @"&thorn;", 254 }, 
	{ @"&yuml;", 255 },
	
	{ @"&OElig;", 338 },
	{ @"&oelig;", 339 },
	{ @"&Scaron;", 352 },
	{ @"&scaron;", 353 },
	{ @"&Yuml;", 376 },
	
	{ @"&fnof;", 402 },
	
	{ @"&circ;", 710 },
	{ @"&tilde;", 732 },
	
	{ @"&Alpha;", 913 },
	{ @"&Beta;", 914 }, 
	{ @"&Gamma;", 915 }, 
	{ @"&Delta;", 916 }, 
	{ @"&Epsilon;", 917 }, 
	{ @"&Zeta;", 918 }, 
	{ @"&Eta;", 919 }, 
	{ @"&Theta;", 920 }, 
	{ @"&Iota;", 921 }, 
	{ @"&Kappa;", 922 }, 
	{ @"&Lambda;", 923 }, 
	{ @"&Mu;", 924 }, 
	{ @"&Nu;", 925 }, 
	{ @"&Xi;", 926 }, 
	{ @"&Omicron;", 927 }, 
	{ @"&Pi;", 928 }, 
	{ @"&Rho;", 929 }, 
	{ @"&Sigma;", 931 }, 
	{ @"&Tau;", 932 }, 
	{ @"&Upsilon;", 933 }, 
	{ @"&Phi;", 934 }, 
	{ @"&Chi;", 935 }, 
	{ @"&Psi;", 936 }, 
	{ @"&Omega;", 937 }, 
	{ @"&alpha;", 945 }, 
	{ @"&beta;", 946 }, 
	{ @"&gamma;", 947 }, 
	{ @"&delta;", 948 }, 
	{ @"&epsilon;", 949 }, 
	{ @"&zeta;", 950 }, 
	{ @"&eta;", 951 }, 
	{ @"&theta;", 952 }, 
	{ @"&iota;", 953 }, 
	{ @"&kappa;", 954 }, 
	{ @"&lambda;", 955 }, 
	{ @"&mu;", 956 }, 
	{ @"&nu;", 957 }, 
	{ @"&xi;", 958 }, 
	{ @"&omicron;", 959 }, 
	{ @"&pi;", 960 }, 
	{ @"&rho;", 961 }, 
	{ @"&sigmaf;", 962 }, 
	{ @"&sigma;", 963 }, 
	{ @"&tau;", 964 }, 
	{ @"&upsilon;", 965 }, 
	{ @"&phi;", 966 }, 
	{ @"&chi;", 967 }, 
	{ @"&psi;", 968 }, 
	{ @"&omega;", 969 }, 
	{ @"&thetasym;", 977 }, 
	{ @"&upsih;", 978 }, 
	{ @"&piv;", 982 }, 
	
	{ @"&ensp;", 8194 },
	{ @"&emsp;", 8195 },
	{ @"&thinsp;", 8201 },
	{ @"&zwnj;", 8204 },
	{ @"&zwj;", 8205 },
	{ @"&lrm;", 8206 },
	{ @"&rlm;", 8207 },
	{ @"&ndash;", 8211 },
	{ @"&mdash;", 8212 },
	{ @"&lsquo;", 8216 },
	{ @"&rsquo;", 8217 },
	{ @"&sbquo;", 8218 },
	{ @"&ldquo;", 8220 },
	{ @"&rdquo;", 8221 },
	{ @"&bdquo;", 8222 },
	{ @"&dagger;", 8224 },
	{ @"&Dagger;", 8225 },
	{ @"&bull;", 8226 },
	{ @"&hellip;", 8230 }, 
	
	{ @"&permil;", 8240 },
	
	{ @"&prime;", 8242 },
	{ @"&Prime;", 8243 }, 
	
	{ @"&lsaquo;", 8249 },
	{ @"&rsaquo;", 8250 },
	
	{ @"&oline;", 8254 },
	{ @"&frasl;", 8260 }, 
	
	{ @"&euro;", 8364 },
	
	{ @"&image;", 8465 },
	{ @"&weierp;", 8472 }, 
	{ @"&real;", 8476 }, 
	{ @"&trade;", 8482 }, 
	{ @"&alefsym;", 8501 }, 
	{ @"&larr;", 8592 }, 
	{ @"&uarr;", 8593 }, 
	{ @"&rarr;", 8594 }, 
	{ @"&darr;", 8595 }, 
	{ @"&harr;", 8596 }, 
	{ @"&crarr;", 8629 }, 
	{ @"&lArr;", 8656 }, 
	{ @"&uArr;", 8657 }, 
	{ @"&rArr;", 8658 }, 
	{ @"&dArr;", 8659 }, 
	{ @"&hArr;", 8660 }, 
	{ @"&forall;", 8704 }, 
	{ @"&part;", 8706 }, 
	{ @"&exist;", 8707 }, 
	{ @"&empty;", 8709 }, 
	{ @"&nabla;", 8711 }, 
	{ @"&isin;", 8712 }, 
	{ @"&notin;", 8713 }, 
	{ @"&ni;", 8715 }, 
	{ @"&prod;", 8719 }, 
	{ @"&sum;", 8721 }, 
	{ @"&minus;", 8722 }, 
	{ @"&lowast;", 8727 }, 
	{ @"&radic;", 8730 }, 
	{ @"&prop;", 8733 }, 
	{ @"&infin;", 8734 }, 
	{ @"&ang;", 8736 }, 
	{ @"&and;", 8743 }, 
	{ @"&or;", 8744 }, 
	{ @"&cap;", 8745 }, 
	{ @"&cup;", 8746 }, 
	{ @"&int;", 8747 }, 
	{ @"&there4;", 8756 }, 
	{ @"&sim;", 8764 }, 
	{ @"&cong;", 8773 }, 
	{ @"&asymp;", 8776 }, 
	{ @"&ne;", 8800 }, 
	{ @"&equiv;", 8801 }, 
	{ @"&le;", 8804 }, 
	{ @"&ge;", 8805 }, 
	{ @"&sub;", 8834 }, 
	{ @"&sup;", 8835 }, 
	{ @"&nsub;", 8836 }, 
	{ @"&sube;", 8838 }, 
	{ @"&supe;", 8839 }, 
	{ @"&oplus;", 8853 }, 
	{ @"&otimes;", 8855 }, 
	{ @"&perp;", 8869 }, 
	{ @"&sdot;", 8901 }, 
	{ @"&lceil;", 8968 }, 
	{ @"&rceil;", 8969 }, 
	{ @"&lfloor;", 8970 }, 
	{ @"&rfloor;", 8971 }, 
	{ @"&lang;", 9001 }, 
	{ @"&rang;", 9002 }, 
	{ @"&loz;", 9674 }, 
	{ @"&spades;", 9824 }, 
	{ @"&clubs;", 9827 }, 
	{ @"&hearts;", 9829 }, 
	{ @"&diams;", 9830 }
};

static MXBZ_HTMLEscapeMap mxbz_gUnicodeHTMLEscapeMap[] = {
	{ @"&quot;", 34 },
	{ @"&amp;", 38 },
	{ @"&apos;", 39 },
	{ @"&lt;", 60 },
	{ @"&gt;", 62 },
	
	{ @"&OElig;", 338 },
	{ @"&oelig;", 339 },
	{ @"&Scaron;", 352 },
	{ @"&scaron;", 353 },
	{ @"&Yuml;", 376 },
	
	{ @"&circ;", 710 },
	{ @"&tilde;", 732 },
    
	{ @"&ensp;", 8194 },
	{ @"&emsp;", 8195 },
	{ @"&thinsp;", 8201 },
	{ @"&zwnj;", 8204 },
	{ @"&zwj;", 8205 },
	{ @"&lrm;", 8206 },
	{ @"&rlm;", 8207 },
	{ @"&ndash;", 8211 },
	{ @"&mdash;", 8212 },
	{ @"&lsquo;", 8216 },
	{ @"&rsquo;", 8217 },
	{ @"&sbquo;", 8218 },
	{ @"&ldquo;", 8220 },
	{ @"&rdquo;", 8221 },
	{ @"&bdquo;", 8222 },
	{ @"&dagger;", 8224 },
	{ @"&Dagger;", 8225 },
	{ @"&permil;", 8240 },
	{ @"&lsaquo;", 8249 },
	{ @"&rsaquo;", 8250 },
	{ @"&euro;", 8364 },
};


static int MXBZ_EscapeMapCompare(const void *ucharVoid, const void *mapVoid) {
	const unichar *uchar = (const unichar*)ucharVoid;
	const MXBZ_HTMLEscapeMap *map = (const MXBZ_HTMLEscapeMap*)mapVoid;
	int val;
	if (*uchar > map->uchar) {
		val = 1;
	} else if (*uchar < map->uchar) {
		val = -1;
	} else {
		val = 0;
	}
	return val;
}

@implementation NSString (MXBZHTML)
#pragma --mark GTM method

- (NSString *)mxbz_stringByEscapingHTMLUsingTable:(MXBZ_HTMLEscapeMap*)table
                                          ofSize:(NSUInteger)size 
                                 escapingUnicode:(BOOL)escapeUnicode {  
	NSUInteger length = [self length];
	if (!length) {
		return self;
	}
	
	NSMutableString *finalString = [NSMutableString string];
	NSMutableData *data2 = [NSMutableData dataWithCapacity:sizeof(unichar) * length];
	const unichar *buffer = CFStringGetCharactersPtr((CFStringRef)self);
	if (!buffer) {
		NSMutableData *data = [NSMutableData dataWithLength:length * sizeof(UniChar)];
		if (!data) {
			return nil;
		}
		[self getCharacters:[data mutableBytes]];
		buffer = [data bytes];
	}
	
	if (!buffer || !data2) {
		return nil;
	}
	
	unichar *buffer2 = (unichar *)[data2 mutableBytes];
	
	NSUInteger buffer2Length = 0;
	
	for (NSUInteger i = 0; i < length; ++i) {
		MXBZ_HTMLEscapeMap *val = bsearch(&buffer[i], table,
									 size / sizeof(MXBZ_HTMLEscapeMap),
									 sizeof(MXBZ_HTMLEscapeMap), MXBZ_EscapeMapCompare);
		if (val || (escapeUnicode && buffer[i] > 127)) {
			if (buffer2Length) {
				CFStringAppendCharacters((CFMutableStringRef)finalString, 
										 buffer2, 
										 buffer2Length);
				buffer2Length = 0;
			}
			if (val) {
				[finalString appendString:val->escapeSequence];
			}
			else {
				[finalString appendFormat:@"&#%d;", buffer[i]];
			}
		} else {
			buffer2[buffer2Length] = buffer[i];
			buffer2Length += 1;
		}
	}
	if (buffer2Length) {
		CFStringAppendCharacters((CFMutableStringRef)finalString, 
								 buffer2, 
								 buffer2Length);
	}
	return finalString;
}

- (NSString *)mxbz_stringByEscapingForHTML {
	return [self mxbz_stringByEscapingHTMLUsingTable:mxbz_gUnicodeHTMLEscapeMap
											 ofSize:sizeof(mxbz_gUnicodeHTMLEscapeMap) 
									escapingUnicode:NO];
}
- (NSString *)mxbz_stringByEscapingForAsciiHTML {
	return [self mxbz_stringByEscapingHTMLUsingTable:mxbz_gAsciiHTMLEscapeMap
											 ofSize:sizeof(mxbz_gAsciiHTMLEscapeMap) 
									escapingUnicode:YES];
}

- (NSString *)mxbz_stringByUnescapingFromHTML {
    
	NSRange range = NSMakeRange(0, [self length]);
	NSRange subrange = [self rangeOfString:@"&" options:NSBackwardsSearch range:range];
	
	if (subrange.length == 0) return self;
	NSMutableString *finalString = [NSMutableString stringWithString:self];
	do {
		NSRange semiColonRange = NSMakeRange(subrange.location, NSMaxRange(range) - subrange.location);
		semiColonRange = [self rangeOfString:@";" options:0 range:semiColonRange];
		range = NSMakeRange(0, subrange.location);
		if (semiColonRange.location == NSNotFound) {
			continue;
		}
		NSRange escapeRange = NSMakeRange(subrange.location, semiColonRange.location - subrange.location + 1);
		NSString *escapeString = [self substringWithRange:escapeRange];
		NSUInteger length = [escapeString length];
		if (length > 3 && length < 11) {
			if ([escapeString characterAtIndex:1] == '#') {
				unichar char2 = [escapeString characterAtIndex:2];
				if (char2 == 'x' || char2 == 'X') {
					NSString *hexSequence = [escapeString substringWithRange:NSMakeRange(3, length - 4)];
					NSScanner *scanner = [NSScanner scannerWithString:hexSequence];
					unsigned value;
					if ([scanner scanHexInt:&value] && 
						value < USHRT_MAX &&
						value > 0 
						&& [scanner scanLocation] == length - 4) {
						unichar uchar = value;
						NSString *charString = [NSString stringWithCharacters:&uchar length:1];
						[finalString replaceCharactersInRange:escapeRange withString:charString];
					}
					
				} else {
					NSString *numberSequence = [escapeString substringWithRange:NSMakeRange(2, length - 3)];
					NSScanner *scanner = [NSScanner scannerWithString:numberSequence];
					int value;
					if ([scanner scanInt:&value] && 
						value < USHRT_MAX &&
						value > 0 
						&& [scanner scanLocation] == length - 3) {
						unichar uchar = value;
						NSString *charString = [NSString stringWithCharacters:&uchar length:1];
						[finalString replaceCharactersInRange:escapeRange withString:charString];
					}
				}
			} else {
				for (unsigned i = 0; i < sizeof(mxbz_gAsciiHTMLEscapeMap) / sizeof(MXBZ_HTMLEscapeMap); ++i) {
					if ([escapeString isEqualToString:mxbz_gAsciiHTMLEscapeMap[i].escapeSequence]) {
						[finalString replaceCharactersInRange:escapeRange withString:[NSString stringWithCharacters:&mxbz_gAsciiHTMLEscapeMap[i].uchar length:1]];
						break;
					}
				}
			}
		}
	} while ((subrange = [self rangeOfString:@"&" options:NSBackwardsSearch range:range]).length != 0);
	return finalString;
}


#pragma --mark MWFeedParser method
- (NSString *)mxbz_stringWithNewLinesAsBRs {
    @autoreleasepool {
        NSScanner *scanner = [[NSScanner alloc] initWithString:self];
        [scanner setCharactersToBeSkipped:nil];
        NSMutableString *result = [[NSMutableString alloc] init];
        NSString *temp;
        NSCharacterSet *newLineCharacters = [NSCharacterSet characterSetWithCharactersInString:
                                             [NSString stringWithFormat:@"\n\r%C%C%C%C", (unichar)0x0085, (unichar)0x000C, (unichar)0x2028, (unichar)0x2029]];
        do {
            
            temp = nil;
            [scanner scanUpToCharactersFromSet:newLineCharacters intoString:&temp];
            if (temp) [result appendString:temp];
            temp = nil;
            
            if ([scanner scanString:@"\r\n" intoString:nil]) {
                
                [result appendString:@"<br />"];
                
            } else if ([scanner scanCharactersFromSet:newLineCharacters intoString:&temp]) {
                
                if (temp) {
                    for (NSUInteger i = 0; i < temp.length; i++) {
                        [result appendString:@"<br />"];
                    }
                }
                
            }
            
        } while (![scanner isAtEnd]);
        
        NSString *retString = [NSString stringWithString:result];
        
        return retString;
        
    }
}


- (NSString *)mxbz_stringByRemovingNewLinesAndWhitespace {
    @autoreleasepool {
        
        NSScanner *scanner = [[NSScanner alloc] initWithString:self];
        [scanner setCharactersToBeSkipped:nil];
        NSMutableString *result = [[NSMutableString alloc] init];
        NSString *temp;
        NSCharacterSet *newLineAndWhitespaceCharacters = [NSCharacterSet characterSetWithCharactersInString:
                                                          [NSString stringWithFormat:@" \t\n\r%C%C%C%C", (unichar)0x0085, (unichar)0x000C, (unichar)0x2028, (unichar)0x2029]];
        while (![scanner isAtEnd]) {
            
            temp = nil;
            [scanner scanUpToCharactersFromSet:newLineAndWhitespaceCharacters intoString:&temp];
            if (temp) [result appendString:temp];
            
            if ([scanner scanCharactersFromSet:newLineAndWhitespaceCharacters intoString:NULL]) {
                if (result.length > 0 && ![scanner isAtEnd])
                    [result appendString:@" "];
            }
            
        }
        
        NSString *retString = [NSString stringWithString:result];
        
        return retString;
    }
}

- (NSString *)mxbz_stringByLinkifyingURLs {
    if (!NSClassFromString(@"NSRegularExpression")) return self;
    @autoreleasepool {
        NSString *pattern = @"(?<!=\")\\b((http|https):\\/\\/[\\w\\-_]+(\\.[\\w\\-_]+)+([\\w\\-\\.,@?^=%%&amp;:/~\\+#]*[\\w\\-\\@?^=%%&amp;/~\\+#])?)";
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
        NSString *modifiedString = [regex stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, [self length])
                                                              withTemplate:@"<a href=\"$1\" class=\"linkified\">$1</a>"];
        return modifiedString;
    }
}

- (NSString *)mxbz_stringByStrippingTags {
    @autoreleasepool {
        
        NSUInteger ampIndex = [self rangeOfString:@"<" options:NSLiteralSearch].location;
        if (ampIndex == NSNotFound) {
            return [NSString stringWithString:self];
        }
        
        NSScanner *scanner = [NSScanner scannerWithString:self];
        [scanner setCharactersToBeSkipped:nil];
        NSMutableSet *tags = [[NSMutableSet alloc] init];
        NSString *tag;
        do {
            
            tag = nil;
            [scanner scanUpToString:@"<" intoString:NULL];
            [scanner scanUpToString:@">" intoString:&tag];
            
            if (tag) {
                NSString *t = [[NSString alloc] initWithFormat:@"%@>", tag];
                [tags addObject:t];
            }
            
        } while (![scanner isAtEnd]);
        
        NSMutableString *result = [[NSMutableString alloc] initWithString:self];
        NSString *finalString;
        
        NSString *replacement;
        for (NSString *t in tags) {
            
            replacement = @" ";
            if ([t isEqualToString:@"<a>"] ||
                [t isEqualToString:@"</a>"] ||
                [t isEqualToString:@"<span>"] ||
                [t isEqualToString:@"</span>"] ||
                [t isEqualToString:@"<strong>"] ||
                [t isEqualToString:@"</strong>"] ||
                [t isEqualToString:@"<em>"] ||
                [t isEqualToString:@"</em>"]) {
                replacement = @"";
            }
            
            [result replaceOccurrencesOfString:t
                                    withString:replacement
                                       options:NSLiteralSearch
                                         range:NSMakeRange(0, result.length)];
        }
        
        finalString = [result mxbz_stringByRemovingNewLinesAndWhitespace];
        
        
        return finalString;
        
    }
}

- (NSString *)mxbz_stringByConvertingHTMLToPlainText {
    @autoreleasepool {
        NSCharacterSet *stopCharacters = [NSCharacterSet characterSetWithCharactersInString:[NSString stringWithFormat:@"< \t\n\r%C%C%C%C", (unichar)0x0085, (unichar)0x000C, (unichar)0x2028, (unichar)0x2029]];
        NSCharacterSet *newLineAndWhitespaceCharacters = [NSCharacterSet characterSetWithCharactersInString:[NSString stringWithFormat:@" \t\n\r%C%C%C%C", (unichar)0x0085, (unichar)0x000C, (unichar)0x2028, (unichar)0x2029]];
        NSCharacterSet *tagNameCharacters = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghimxbzlmnopqrstuvwxyzABCDEFGHIMXBZLMNOPQRSTUVWXYZ"];
        
        NSMutableString *result = [[NSMutableString alloc] initWithCapacity:self.length];
        NSScanner *scanner = [[NSScanner alloc] initWithString:self];
        [scanner setCharactersToBeSkipped:nil];
        [scanner setCaseSensitive:YES];
        NSString *str = nil, *tagName = nil;
        BOOL dontReplaceTagWithSpace = NO;
        do {
            
            if ([scanner scanUpToCharactersFromSet:stopCharacters intoString:&str]) {
                [result appendString:str];
                str = nil;
            }
            
            if ([scanner scanString:@"<" intoString:NULL]) {
                
                if ([scanner scanString:@"!--" intoString:NULL]) {
                    
                    [scanner scanUpToString:@"-->" intoString:NULL];
                    [scanner scanString:@"-->" intoString:NULL];
                    
                } else if ([scanner scanString:@"script" intoString:NULL]) {
                    
                    [scanner scanUpToString:@"</script>" intoString:NULL];
                    [scanner scanString:@"</script>" intoString:NULL];
                    
                } else {
                    
                    if ([scanner scanString:@"/" intoString:NULL]) {
                        
                        tagName = nil; dontReplaceTagWithSpace = NO;
                        if ([scanner scanCharactersFromSet:tagNameCharacters intoString:&tagName]) {
                            tagName = [tagName lowercaseString];
                            dontReplaceTagWithSpace = ([tagName isEqualToString:@"a"] ||
                                                       [tagName isEqualToString:@"b"] ||
                                                       [tagName isEqualToString:@"i"] ||
                                                       [tagName isEqualToString:@"q"] ||
                                                       [tagName isEqualToString:@"span"] ||
                                                       [tagName isEqualToString:@"em"] ||
                                                       [tagName isEqualToString:@"strong"] ||
                                                       [tagName isEqualToString:@"cite"] ||
                                                       [tagName isEqualToString:@"abbr"] ||
                                                       [tagName isEqualToString:@"acronym"] ||
                                                       [tagName isEqualToString:@"label"]);
                        }
                        
                        if (!dontReplaceTagWithSpace && result.length > 0 && ![scanner isAtEnd]) [result appendString:@" "];
                        
                    }
                    
                    [scanner scanUpToString:@">" intoString:NULL];
                    [scanner scanString:@">" intoString:NULL];
                    
                }
                
            } else {
                
                if ([scanner scanCharactersFromSet:newLineAndWhitespaceCharacters intoString:NULL]) {
                    if (result.length > 0 && ![scanner isAtEnd]) [result appendString:@" "]; // Dont append space to beginning or end of result
                }
                
            }
            
        } while (![scanner isAtEnd]);
        
        NSString *retString = [result mxbz_stringByUnescapingFromHTML];
        
        return retString;
        
    }
}
@end
