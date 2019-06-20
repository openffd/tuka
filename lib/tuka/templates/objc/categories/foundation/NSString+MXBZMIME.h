#import <Foundation/Foundation.h>

@interface NSString (MXBZMIME)
- (NSString *)mxbz_MIMEType;

+ (NSString *)mxbz_MIMETypeForExtension:(NSString *)extension;

+ (NSDictionary *)mxbz_MIMEDict;
@end
