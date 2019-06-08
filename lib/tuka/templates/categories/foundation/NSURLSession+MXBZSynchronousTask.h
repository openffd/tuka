#import <Foundation/Foundation.h>

@interface NSURLSession (MXBZSynchronousTask)

#pragma mark - NSURLSessionDataTask

- (nullable NSData *)mxbz_sendSynchronousDataTaskWithURL:(nonnull NSURL *)url returningResponse:(NSURLResponse *_Nullable __autoreleasing *_Nullable)response error:(NSError *_Nullable __autoreleasing*_Nullable)error;
- (nullable NSData *)mxbz_sendSynchronousDataTaskWithRequest:(nonnull NSURLRequest *)request returningResponse:(NSURLResponse *_Nullable __autoreleasing *_Nullable)response error:(NSError *_Nullable __autoreleasing*_Nullable)error;

#pragma mark - NSURLSessionDownloadTask

- (nullable NSURL *)mxbz_sendSynchronousDownloadTaskWithURL:(nonnull NSURL *)url returningResponse:(NSURLResponse *_Nullable __autoreleasing *_Nullable)response error:(NSError *_Nullable __autoreleasing *_Nullable)error;
- (nullable NSURL *)mxbz_sendSynchronousDownloadTaskWithRequest:(nonnull NSURLRequest *)request returningResponse:(NSURLResponse *_Nullable __autoreleasing *_Nullable)response error:(NSError *_Nullable __autoreleasing *_Nullable)error;

#pragma mark - NSURLSessionUploadTask

- (nullable NSData *)mxbz_sendSynchronousUploadTaskWithRequest:(nonnull NSURLRequest *)request fromFile:(nonnull NSURL *)fileURL returningResponse:(NSURLResponse *_Nullable __autoreleasing *_Nullable)response error:(NSError *_Nullable __autoreleasing *_Nullable)error;
- (nullable NSData *)mxbz_sendSynchronousUploadTaskWithRequest:(nonnull NSURLRequest *)request fromData:(nonnull NSData *)bodyData returningResponse:(NSURLResponse *_Nullable __autoreleasing *_Nullable)response error:(NSError *_Nullable __autoreleasing *_Nullable)error;

@end
