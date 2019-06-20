#import "NSURLSession+MXBZSynchronousTask.h"

@implementation NSURLSession (MXBZSynchronousTask)

#pragma mark - NSURLSessionDataTask

- (nullable NSData *)mxbz_sendSynchronousDataTaskWithURL:(nonnull NSURL *)url returningResponse:(NSURLResponse *_Nullable*_Nullable)response error:(NSError *_Nullable*_Nullable)error {
    return [self mxbz_sendSynchronousDataTaskWithRequest:[NSURLRequest requestWithURL:url] returningResponse:response error:error];
}

- (nullable NSData *)mxbz_sendSynchronousDataTaskWithRequest:(nonnull NSURLRequest *)request returningResponse:(NSURLResponse *_Nullable __autoreleasing *_Nullable)response error:(NSError *_Nullable __autoreleasing *_Nullable)error {
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block NSData *data = nil;
    [[self dataTaskWithRequest:request completionHandler:^(NSData *taskData, NSURLResponse *taskResponse, NSError *taskError) {
        data = taskData;
        if (response) {
            *response = taskResponse;
        }
        if (error) {
            *error = taskError;
        }
        dispatch_semaphore_signal(semaphore);
    }] resume];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    return data;
}

#pragma mark - NSURLSessionDownloadTask

- (nullable NSURL *)mxbz_sendSynchronousDownloadTaskWithURL:(nonnull NSURL *)url returningResponse:(NSURLResponse *_Nullable*_Nullable)response error:(NSError *_Nullable*_Nullable)error {
    return [self mxbz_sendSynchronousDownloadTaskWithRequest:[NSURLRequest requestWithURL:url] returningResponse:response error:error];
}

- (nullable NSURL *)mxbz_sendSynchronousDownloadTaskWithRequest:(nonnull NSURLRequest *)request returningResponse:(NSURLResponse *_Nullable __autoreleasing *_Nullable)response error:(NSError *_Nullable __autoreleasing *_Nullable)error {
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block NSURL *location = nil;
    [[self downloadTaskWithRequest:request completionHandler:^(NSURL *taskLocation, NSURLResponse *taskResponse, NSError *taskError) {
        location = taskLocation;
        if (response) {
            *response = taskResponse;
        }
        if (error) {
            *error = taskError;
        }
        dispatch_semaphore_signal(semaphore);
    }] resume];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    return location;
}

#pragma mark - NSURLSessionUploadTask

- (nullable NSData *)mxbz_sendSynchronousUploadTaskWithRequest:(nonnull NSURLRequest *)request fromFile:(nonnull NSURL *)fileURL returningResponse:(NSURLResponse *_Nullable*_Nullable)response error:(NSError *_Nullable*_Nullable)error {
    return [self mxbz_sendSynchronousUploadTaskWithRequest:request fromData:[NSData dataWithContentsOfURL:fileURL] returningResponse:response error:error];
}

- (nullable NSData *)mxbz_sendSynchronousUploadTaskWithRequest:(nonnull NSURLRequest *)request fromData:(nonnull NSData *)bodyData returningResponse:(NSURLResponse *_Nullable __autoreleasing *_Nullable)response error:(NSError *_Nullable __autoreleasing *_Nullable)error {
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block NSData *data = nil;
    [[self uploadTaskWithRequest:request fromData:bodyData completionHandler:^(NSData *taskData, NSURLResponse *taskResponse, NSError *taskError) {
        data = taskData;
        if (response) {
            *response = taskResponse;
        }
        if (error) {
            *error = taskError;
        }
        dispatch_semaphore_signal(semaphore);
    }] resume];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    return data;
}

@end
