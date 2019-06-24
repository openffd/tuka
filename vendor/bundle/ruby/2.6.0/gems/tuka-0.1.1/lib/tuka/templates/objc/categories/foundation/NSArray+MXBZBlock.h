#import <Foundation/Foundation.h>

@interface NSArray (MXBZBlock)
- (void)mxbz_each:(void (^)(id object))block;
- (void)mxbz_eachWithIndex:(void (^)(id object, NSUInteger index))block;
- (NSArray *)mxbz_map:(id (^)(id object))block;
- (NSArray *)mxbz_filter:(BOOL (^)(id object))block;
- (NSArray *)mxbz_reject:(BOOL (^)(id object))block;
- (id)mxbz_detect:(BOOL (^)(id object))block;
- (id)mxbz_reduce:(id (^)(id accumulator, id object))block;
- (id)mxbz_reduce:(id)initial withBlock:(id (^)(id accumulator, id object))block;
@end
