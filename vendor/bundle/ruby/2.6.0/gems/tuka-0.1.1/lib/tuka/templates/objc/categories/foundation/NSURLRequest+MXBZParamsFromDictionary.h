#import <Foundation/Foundation.h>

@interface NSURLRequest (MXBZParamsFromDictionary)

- (id)initWithURL:(NSURL *)URL parameters:(NSDictionary *)params;

+(NSURLRequest *)mxbz_requestGETWithURL:(NSURL *)url parameters:(NSDictionary *)params;

+(NSString *)mxbz_URLfromParameters:(NSDictionary *)params;

+(NSArray *)mxbz_queryStringComponentsFromKey:(NSString *)key value:(id)value;
+(NSArray *)mxbz_queryStringComponentsFromKey:(NSString *)key dictionaryValue:(NSDictionary *)dict;
+(NSArray *)mxbz_queryStringComponentsFromKey:(NSString *)key arrayValue:(NSArray *)array;

@end
