#import "NSDictionary+MXBZXML.h"

@implementation NSDictionary (MXBZXML)
- (NSString *)mxbz_XMLString {
   
    return [self  mxbz_XMLStringWithRootElement:nil declaration:nil];
}
- (NSString*)mxbz_XMLStringDefaultDeclarationWithRootElement:(NSString*)rootElement{
    return [self  mxbz_XMLStringWithRootElement:rootElement declaration:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"];

}
- (NSString*)mxbz_XMLStringWithRootElement:(NSString*)rootElement declaration:(NSString*)declaration{
    NSMutableString *xml = [[NSMutableString alloc] initWithString:@""];
    if (declaration) {
        [xml appendString:declaration];
    }
    if (rootElement) {
        [xml appendString:[NSString stringWithFormat:@"<%@>",rootElement]];
    }
    [self mxbz_convertNode:self withString:xml andTag:nil];
    if (rootElement) {
        [xml appendString:[NSString stringWithFormat:@"</%@>",rootElement]];
    }
    NSString *finalXML=[xml stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"];
    return finalXML;
}

- (void)mxbz_convertNode:(id)node withString:(NSMutableString *)xml andTag:(NSString *)tag{
    if ([node isKindOfClass:[NSDictionary class]] && !tag) {
        NSArray *keys = [node allKeys];
        for (NSString *key in keys) {
            [self mxbz_convertNode:[node objectForKey:key] withString:xml andTag:key];
        }
    }else if ([node isKindOfClass:[NSArray class]]) {
        for (id value in node) {
            [self mxbz_convertNode:value withString:xml andTag:tag];
        }
    }else {
        [xml appendString:[NSString stringWithFormat:@"<%@>", tag]];
        if ([node isKindOfClass:[NSString class]]) {
            [xml appendString:node];
        }else if ([node isKindOfClass:[NSDictionary class]]) {
            [self mxbz_convertNode:node withString:xml andTag:nil];
        }
        [xml appendString:[NSString stringWithFormat:@"</%@>", tag]];
    }
}

- (NSString *)mxbz_plistString{
    NSString *result = [[NSString alloc] initWithData:[self mxbz_plistData]  encoding:NSUTF8StringEncoding];
    return result;
}
- (NSData *)mxbz_plistData{
    NSError *error = nil;
    return [NSPropertyListSerialization dataWithPropertyList:self format:NSPropertyListXMLFormat_v1_0 options:0 error:&error];
}
@end
