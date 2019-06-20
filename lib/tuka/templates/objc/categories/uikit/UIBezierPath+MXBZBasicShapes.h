#import <UIKit/UIKit.h>

@interface UIBezierPath (MXBZBasicShapes)

+ (UIBezierPath *)mxbz_heartShape:(CGRect)originalFrame;
+ (UIBezierPath *)mxbz_userShape:(CGRect)originalFrame;
+ (UIBezierPath *)mxbz_martiniShape:(CGRect)originalFrame;
+ (UIBezierPath *)mxbz_beakerShape:(CGRect)originalFrame;
+ (UIBezierPath *)mxbz_starShape:(CGRect)originalFrame;
+ (UIBezierPath *)mxbz_stars:(NSUInteger)numberOfStars shapeInFrame:(CGRect)originalFrame;

@end
