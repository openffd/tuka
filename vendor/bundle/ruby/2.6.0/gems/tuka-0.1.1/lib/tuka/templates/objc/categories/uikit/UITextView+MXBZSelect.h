#import <UIKit/UIKit.h>

@interface UITextView (MXBZSelect)

- (NSRange)mxbz_selectedRange;
- (void)mxbz_selectAllText;

- (void)mxbz_setSelectedRange:(NSRange)range;


- (NSInteger)mxbz_getInputLengthWithText:(NSString *)text;

@end
