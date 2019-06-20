#import "UIImageView+MXBZLetters.h"

static const CGFloat mxbz_FontResizingProportion = 0.42f;

@interface UIImageView (MXBZLettersPrivate)

- (UIImage *)mxbz_imageSnapshotFromText:(NSString *)text backgroundColor:(UIColor *)color circular:(BOOL)isCircular textAttributes:(NSDictionary *)attributes;

@end

@implementation UIImageView (Letters)

- (void)mxbz_setImageWithString:(NSString *)string {
    [self mxbz_setImageWithString:string color:nil circular:NO textAttributes:nil];
}

- (void)mxbz_setImageWithString:(NSString *)string color:(UIColor *)color {
    [self mxbz_setImageWithString:string color:color circular:NO textAttributes:nil];
}

- (void)mxbz_setImageWithString:(NSString *)string color:(UIColor *)color circular:(BOOL)isCircular {
    [self mxbz_setImageWithString:string color:color circular:isCircular textAttributes:nil];
}

- (void)mxbz_setImageWithString:(NSString *)string color:(UIColor *)color circular:(BOOL)isCircular fontName:(NSString *)fontName {
    [self mxbz_setImageWithString:string color:color circular:isCircular textAttributes:@{
                                                                                     NSFontAttributeName:[self mxbz_fontForFontName:fontName],
                                                                                     NSForegroundColorAttributeName: [UIColor whiteColor]
                                                                                     }];
}

- (void)mxbz_setImageWithString:(NSString *)string color:(UIColor *)color circular:(BOOL)isCircular textAttributes:(NSDictionary *)textAttributes {
    if (!textAttributes) {
        textAttributes = @{
                           NSFontAttributeName: [self mxbz_fontForFontName:nil],
                           NSForegroundColorAttributeName: [UIColor whiteColor]
                           };
    }
    
    NSMutableString *displayString = [NSMutableString stringWithString:@""];
    
    NSMutableArray *words = [[string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] mutableCopy];
    
    if ([words count]) {
        NSString *firstWord = [words firstObject];
        if ([firstWord length]) {
            NSRange firstLetterRange = [firstWord rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, 1)];
            [displayString appendString:[firstWord substringWithRange:firstLetterRange]];
        }
        
        if ([words count] >= 2) {
            NSString *lastWord = [words lastObject];
            
            while ([lastWord length] == 0 && [words count] >= 2) {
                [words removeLastObject];
                lastWord = [words lastObject];
            }
            
            if ([words count] > 1) {
                NSRange lastLetterRange = [lastWord rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, 1)];
                [displayString appendString:[lastWord substringWithRange:lastLetterRange]];
            }
        }
    }
    
    UIColor *backgroundColor = color ? color : [self mxbz_letter_randomColor];

    self.image = [self mxbz_imageSnapshotFromText:[displayString uppercaseString] backgroundColor:backgroundColor circular:isCircular textAttributes:textAttributes];
}

#pragma mark - Helpers

- (UIFont *)mxbz_fontForFontName:(NSString *)fontName {
    
    CGFloat fontSize = CGRectGetWidth(self.bounds) * mxbz_FontResizingProportion;
    if (fontName) {
        return [UIFont fontWithName:fontName size:fontSize];
    }
    else {
        return [UIFont systemFontOfSize:fontSize];
    }
    
}

- (UIColor *)mxbz_letter_randomColor {
    
    float red = 0.0;
    while (red < 0.1 || red > 0.84) {
        red = drand48();
    }
    
    float green = 0.0;
    while (green < 0.1 || green > 0.84) {
        green = drand48();
    }
    
    float blue = 0.0;
    while (blue < 0.1 || blue > 0.84) {
        blue = drand48();
    }
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

- (UIImage *)mxbz_imageSnapshotFromText:(NSString *)text backgroundColor:(UIColor *)color circular:(BOOL)isCircular textAttributes:(NSDictionary *)textAttributes {
    
    CGFloat scale = [UIScreen mainScreen].scale;
    
    CGSize size = self.bounds.size;
    if (self.contentMode == UIViewContentModeScaleToFill ||
        self.contentMode == UIViewContentModeScaleAspectFill ||
        self.contentMode == UIViewContentModeScaleAspectFit ||
        self.contentMode == UIViewContentModeRedraw)
    {
        size.width = floorf(size.width * scale) / scale;
        size.height = floorf(size.height * scale) / scale;
    }
    
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (isCircular) {
        CGPathRef path = CGPathCreateWithEllipseInRect(self.bounds, NULL);
        CGContextAddPath(context, path);
        CGContextClip(context);
        CGPathRelease(path);
    }
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    
    CGSize textSize = [text sizeWithAttributes:textAttributes];
    CGRect bounds = self.bounds;
    
    [text drawInRect:CGRectMake(bounds.size.width/2 - textSize.width/2,
                                bounds.size.height/2 - textSize.height/2,
                                textSize.width,
                                textSize.height)
      withAttributes:textAttributes];
    
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return snapshot;
}

@end
