#import <Foundation/Foundation.h>

@interface NSString (MXBZRemoveEmoji)
- (NSString *)mxbz_removingEmoji;
- (NSString *)mxbz_stringByRemovingEmoji;
- (NSString *)mxbz_stringByReplaceingEmojiWithString:(NSString*)string;

- (BOOL)mxbz_containsEmoji;
- (NSArray<NSString *>*)mxbz_allEmoji;
- (NSString *)mxbz_allEmojiString;
- (NSArray<NSString *>*)mxbz_allEmojiRanges;

+ (NSString*)mxbz_allSystemEmoji;
@end

@interface NSCharacterSet (MXBZEmojiCharacterSet)
+ (NSCharacterSet *)mxbz_emojiCharacterSet;
@end
