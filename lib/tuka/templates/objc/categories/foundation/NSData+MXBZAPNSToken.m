#import "NSData+MXBZAPNSToken.h"

@implementation NSData (MXBZAPNSToken)
- (NSString *)mxbz_APNSToken {
    return [[[[self description]
              stringByReplacingOccurrencesOfString: @"<" withString: @""]
             stringByReplacingOccurrencesOfString: @">" withString: @""]
            stringByReplacingOccurrencesOfString: @" " withString: @""];
}

@end
