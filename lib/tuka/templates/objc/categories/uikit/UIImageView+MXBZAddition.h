#import <UIKit/UIKit.h>

@interface UIImageView (MXBZAddition)

+ (id)mxbz_imageViewWithImageNamed:(NSString*)imageName;

+ (id)mxbz_imageViewWithFrame:(CGRect)frame;

+ (id)mxbz_imageViewWithStretchableImage:(NSString*)imageName Frame:(CGRect)frame;


+ (id)mxbz_imageViewWithImageArray:(NSArray*)imageArray duration:(NSTimeInterval)duration;
- (void)mxbz_setImageWithStretchableImage:(NSString*)imageName;


- (void)mxbz_setImage:(UIImage *)image withWaterMark:(UIImage *)mark inRect:(CGRect)rect;
- (void)mxbz_setImage:(UIImage *)image withStringWaterMark:(NSString *)markString inRect:(CGRect)rect color:(UIColor *)color font:(UIFont *)font;
- (void)mxbz_setImage:(UIImage *)image withStringWaterMark:(NSString *)markString atPoint:(CGPoint)point color:(UIColor *)color font:(UIFont *)font;
@end
