#import "NSString+MXBZMatcher.h"

@implementation NSString(MXBZMatcher)


- (NSArray *)mxbz_matchWithRegex:(NSString *)regex
{
    NSTextCheckingResult *result = [self mxbz_firstMatchedResultWithRegex:regex];
    NSMutableArray *mArray = [[NSMutableArray alloc] initWithCapacity:[result numberOfRanges]];
    for (int i = 0 ; i < [result numberOfRanges]; i ++ ) {
        [mArray addObject:[self substringWithRange:[result rangeAtIndex:i]]];
    }
    return mArray;
}


- (NSString *)mxbz_matchWithRegex:(NSString *)regex atIndex:(NSUInteger)index
{
    NSTextCheckingResult *result = [self mxbz_firstMatchedResultWithRegex:regex];
    return [self substringWithRange:[result rangeAtIndex:index]];
}


- (NSString *)mxbz_firstMatchedGroupWithRegex:(NSString *)regex
{
    NSTextCheckingResult *result = [self mxbz_firstMatchedResultWithRegex:regex];
    return [self substringWithRange:[result rangeAtIndex:1]];
}


- (NSTextCheckingResult *)mxbz_firstMatchedResultWithRegex:(NSString *)regex
{
    NSRegularExpression *regexExpression = [NSRegularExpression regularExpressionWithPattern:regex options:(NSRegularExpressionOptions)0 error:NULL];
    NSRange range = {0, self.length};
    return [regexExpression firstMatchInString:self options:(NSMatchingOptions)0 range:range];
}

@end
