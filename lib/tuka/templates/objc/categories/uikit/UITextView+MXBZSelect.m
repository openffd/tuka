#import "UITextView+MXBZSelect.h"

@implementation UITextView (MXBZSelect)

- (NSRange)mxbz_selectedRange
{
    UITextPosition* beginning = self.beginningOfDocument;
    
    UITextRange* selectedRange = self.selectedTextRange;
    UITextPosition* selectionStart = selectedRange.start;
    UITextPosition* selectionEnd = selectedRange.end;
    
    NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    
    return NSMakeRange(location, length);
}
- (void)mxbz_selectAllText {
    UITextRange *range = [self textRangeFromPosition:self.beginningOfDocument toPosition:self.endOfDocument];
    [self setSelectedTextRange:range];
}
- (void)mxbz_setSelectedRange:(NSRange)range {
    UITextPosition *beginning = self.beginningOfDocument;
    UITextPosition *startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition *endPosition = [self positionFromPosition:beginning offset:NSMaxRange(range)];
    UITextRange *selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectionRange];
}


- (NSInteger)mxbz_getInputLengthWithText:(NSString *)text
{
    NSInteger textLength = 0;
    UITextRange *selectedRange = [self markedTextRange];
    if (selectedRange) {
        NSString *newText = [self textInRange:selectedRange];
        textLength = (newText.length + 1) / 2 + [self offsetFromPosition:self.beginningOfDocument toPosition:selectedRange.start] + text.length;
    } else {
        textLength = self.text.length + text.length;
    }
    return textLength;
}
@end
