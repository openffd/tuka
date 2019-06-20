#import <Foundation/Foundation.h>

@interface NSString (MXBZContains)
- (BOOL)mxbz_isContainChinese;
- (BOOL)mxbz_isContainBlank;

- (NSString *)mxbz_makeUnicodeToString;

- (BOOL)mxbz_containsCharacterSet:(NSCharacterSet *)set;
- (BOOL)mxbz_containsaString:(NSString *)string;
- (int)mxbz_wordsCount;

@end
