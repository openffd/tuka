#import <Foundation/Foundation.h>
@interface NSString(MXBZMatcher)
- (NSArray *)mxbz_matchWithRegex:(NSString *)regex;
- (NSString *)mxbz_matchWithRegex:(NSString *)regex atIndex:(NSUInteger)index;
- (NSString *)mxbz_firstMatchedGroupWithRegex:(NSString *)regex;
- (NSTextCheckingResult *)mxbz_firstMatchedResultWithRegex:(NSString *)regex;
@end
