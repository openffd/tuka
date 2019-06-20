#import <Foundation/Foundation.h>

@interface NSString (MXBZTrims)

- (NSString *)mxbz_stringByStrippingHTML;

- (NSString *)mxbz_stringByRemovingScriptsAndStrippingHTML;

- (NSString *)mxbz_trimmingWhitespace;

- (NSString *)mxbz_trimmingWhitespaceAndNewlines;
@end
