#import <UIKit/UIKit.h>
typedef enum {
  kUIBezierPathArrowDirectionNone  = 0,
  kUIBezierPathArrowDirectionRight = 1 << 0,
  kUIBezierPathArrowDirectionLeft  = 1 << 1,
  kUIBezierPathArrowDirectionUp    = 1 << 2,
  kUIBezierPathArrowDirectionDown  = 1 << 3
}MXBZUIBezierPathArrowDirection;

@interface UIBezierPath (MXBZSymbol)

+ (UIBezierPath *)mxbz_customBezierPathOfPlusSymbolWithRect:(CGRect)rect   // plus
                                                 scale:(CGFloat)scale;
+ (UIBezierPath *)mxbz_customBezierPathOfMinusSymbolWithRect:(CGRect)rect  // minus
                                                  scale:(CGFloat)scale;
+ (UIBezierPath *)mxbz_customBezierPathOfCheckSymbolWithRect:(CGRect)rect  // check
                                                  scale:(CGFloat)scale
                                                  thick:(CGFloat)thick;
+ (UIBezierPath *)mxbz_customBezierPathOfCrossSymbolWithRect:(CGRect)rect  // cross
                                                  scale:(CGFloat)scale
                                                  thick:(CGFloat)thick;
+ (UIBezierPath *)mxbz_customBezierPathOfArrowSymbolWithRect:(CGRect)rect  // arrow
                                                  scale:(CGFloat)scale
                                                  thick:(CGFloat)thick
                                              direction:(MXBZUIBezierPathArrowDirection)direction;
+ (UIBezierPath *)mxbz_customBezierPathOfPencilSymbolWithRect:(CGRect)rect // pencil
                                                   scale:(CGFloat)scale
                                                   thick:(CGFloat)thick;

@end
