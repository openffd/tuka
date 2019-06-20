#import <Foundation/Foundation.h>

@interface NSString (MXBZHTML)

- (NSString *)mxbz_stringByEscapingForHTML;

- (NSString *)mxbz_stringByEscapingForAsciiHTML;

- (NSString *)mxbz_stringByUnescapingFromHTML;

- (NSString *)mxbz_stringWithNewLinesAsBRs;

- (NSString *)mxbz_stringByRemovingNewLinesAndWhitespace;

- (NSString *)mxbz_stringByLinkifyingURLs;

- (NSString *)mxbz_stringByStrippingTags __attribute__((deprecated));

- (NSString *)mxbz_stringByConvertingHTMLToPlainText;
@end
