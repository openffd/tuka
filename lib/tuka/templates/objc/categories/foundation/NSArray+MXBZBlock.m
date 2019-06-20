#import "NSArray+MXBZBlock.h"

@implementation NSArray (MXBZBlock)
- (void)mxbz_each:(void (^)(id object))block {
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        block(obj);
    }];
}

- (void)mxbz_eachWithIndex:(void (^)(id object, NSUInteger index))block {
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        block(obj, idx);
    }];
}

- (NSArray *)mxbz_map:(id (^)(id object))block {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    
    for (id object in self) {
        [array addObject:block(object) ?: [NSNull null]];
    }
    
    return array;
}

- (NSArray *)mxbz_filter:(BOOL (^)(id object))block {
    return [self filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        return block(evaluatedObject);
    }]];
}

- (NSArray *)mxbz_reject:(BOOL (^)(id object))block {
    return [self filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        return !block(evaluatedObject);
    }]];
}

- (id)mxbz_detect:(BOOL (^)(id object))block {
    for (id object in self) {
        if (block(object))
            return object;
    }
    return nil;
}

- (id)mxbz_reduce:(id (^)(id accumulator, id object))block {
    return [self mxbz_reduce:nil withBlock:block];
}

- (id)mxbz_reduce:(id)initial withBlock:(id (^)(id accumulator, id object))block {
    id accumulator = initial;
    
    for(id object in self)
        accumulator = accumulator ? block(accumulator, object) : object;
    
    return accumulator;
}
@end
