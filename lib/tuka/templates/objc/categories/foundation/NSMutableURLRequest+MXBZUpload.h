#import <Foundation/Foundation.h>

@interface NSMutableURLRequest (MXBZUpload)

+ (instancetype)mxbz_requestWithURL:(NSURL *)URL fileURL:(NSURL *)fileURL name:(NSString *)name;

+ (instancetype)mxbz_requestWithURL:(NSURL *)URL fileURL:(NSURL *)fileURL fileName:(NSString *)fileName name:(NSString *)name;

+ (instancetype)mxbz_requestWithURL:(NSURL *)URL fileURLs:(NSArray *)fileURLs name:(NSString *)name;

+ (instancetype)mxbz_requestWithURL:(NSURL *)URL fileURLs:(NSArray *)fileURLs fileNames:(NSArray *)fileNames name:(NSString *)name;

@end
