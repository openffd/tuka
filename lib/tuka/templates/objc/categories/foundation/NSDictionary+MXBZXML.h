#import <Foundation/Foundation.h>

@interface NSDictionary (MXBZXML)
- (NSString *)mxbz_XMLString;
- (NSString *)mxbz_XMLStringDefaultDeclarationWithRootElement:(NSString*)rootElement;

- (NSString *)mxbz_XMLStringWithRootElement:(NSString*)rootElement declaration:(NSString*)declaration;

- (NSString *)mxbz_plistString;
- (NSData *)mxbz_plistData;

@end
