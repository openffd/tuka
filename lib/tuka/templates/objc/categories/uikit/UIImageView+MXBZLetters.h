#import <UIKit/UIKit.h>

@interface UIImageView (MXBZLetters)

- (void)mxbz_setImageWithString:(NSString *)string;

- (void)mxbz_setImageWithString:(NSString *)string color:(UIColor *)color;

- (void)mxbz_setImageWithString:(NSString *)string color:(UIColor *)color circular:(BOOL)isCircular;

- (void)mxbz_setImageWithString:(NSString *)string color:(UIColor *)color circular:(BOOL)isCircular fontName:(NSString *)fontName;

- (void)mxbz_setImageWithString:(NSString *)string color:(UIColor *)color circular:(BOOL)isCircular textAttributes:(NSDictionary *)textAttributes;

@end
