#import "NSURLRequest+MXBZParamsFromDictionary.h"

@implementation NSURLRequest (MXBZParamsFromDictionary)

+(NSURLRequest *)mxbz_requestGETWithURL:(NSURL *)url parameters:(NSDictionary *)params {
    return [[NSURLRequest alloc] initWithURL:url parameters:params];
}

-(id)initWithURL:(NSURL *)URL parameters:(NSDictionary *)params {
    if (params) {
        NSArray *queryStringComponents = [[self class] mxbz_queryStringComponentsFromKey:nil value:params];
        NSString *parameterString = [queryStringComponents componentsJoinedByString:@"&"];
        if ([[URL absoluteString] rangeOfString:@"?"].location == NSNotFound) {
            URL = [NSURL URLWithString:[[URL absoluteString] stringByAppendingFormat:@"?%@",parameterString]];
        } else {
            URL = [NSURL URLWithString:[[URL absoluteString] stringByAppendingFormat:@"&%@",parameterString]];
        }
    }
    self = [self initWithURL:URL];
    if (!self) {
        return nil;
    }
    return self;
}

+(NSString *)mxbz_URLfromParameters:(NSDictionary *)params{
    if (params) {
        NSArray *queryStringComponents = [[self class] mxbz_queryStringComponentsFromKey:nil value:params];
        NSString *parameterString = [queryStringComponents componentsJoinedByString:@"&"];
        return parameterString;
    }
    return @"";
}

+(NSArray *)mxbz_queryStringComponentsFromKey:(NSString *)key value:(id)value {
    NSMutableArray *queryStringComponents = [NSMutableArray arrayWithCapacity:2];
    if ([value isKindOfClass:[NSDictionary class]]) {
        [queryStringComponents addObjectsFromArray:[self mxbz_queryStringComponentsFromKey:key dictionaryValue:value]];
    } else if ([value isKindOfClass:[NSArray class]]) {
        [queryStringComponents addObjectsFromArray:[self mxbz_queryStringComponentsFromKey:key arrayValue:value]];
    } else {
        NSString *valueString = [value description];
        NSString *unescapedString = [valueString stringByRemovingPercentEncoding];
        if (unescapedString) {
            valueString = unescapedString;
        }
        
        NSString *component = [NSString stringWithFormat:@"%@=%@", key, unescapedString];
        [queryStringComponents addObject:component];
    }
    
    return queryStringComponents;
}

+(NSArray *)mxbz_queryStringComponentsFromKey:(NSString *)key dictionaryValue:(NSDictionary *)dict{
    NSMutableArray *queryStringComponents = [NSMutableArray arrayWithCapacity:2];
    [dict enumerateKeysAndObjectsUsingBlock:^(id nestedKey, id nestedValue, BOOL *stop) {
        NSArray *components = nil;
        if (key == nil) {
            components = [self mxbz_queryStringComponentsFromKey:nestedKey value:nestedValue];
        } else {
            components = [self mxbz_queryStringComponentsFromKey:[NSString stringWithFormat:@"%@[%@]", key, nestedKey] value:nestedValue];
        }
        
        [queryStringComponents addObjectsFromArray:components];
    }];
    
    return queryStringComponents;
}

+(NSArray *)mxbz_queryStringComponentsFromKey:(NSString *)key arrayValue:(NSArray *)array{
    NSMutableArray *queryStringComponents = [NSMutableArray arrayWithCapacity:2];
    [array enumerateObjectsUsingBlock:^(id nestedValue, NSUInteger index, BOOL *stop) {
        [queryStringComponents addObjectsFromArray:[self mxbz_queryStringComponentsFromKey:[NSString stringWithFormat:@"%@[]", key] value:nestedValue]];
    }];
    
    return queryStringComponents;
}

@end
