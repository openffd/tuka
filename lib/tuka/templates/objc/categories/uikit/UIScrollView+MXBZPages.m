#import "UIScrollView+MXBZPages.h"

@implementation UIScrollView (MXBZPages)
- (NSInteger)mxbz_pages{
    NSInteger pages = self.contentSize.width/self.frame.size.width;
    return pages;
}
- (NSInteger)mxbz_currentPage{
    NSInteger pages = self.contentSize.width/self.frame.size.width;
    CGFloat scrollPercent = [self mxbz_scrollPercent];
    NSInteger currentPage = (NSInteger)roundf((pages-1)*scrollPercent);
    return currentPage;
}
- (CGFloat)mxbz_scrollPercent{
    CGFloat width = self.contentSize.width-self.frame.size.width;
    CGFloat scrollPercent = self.contentOffset.x/width;
    return scrollPercent;
}

- (CGFloat)mxbz_pagesY {
    CGFloat pageHeight = self.frame.size.height;
    CGFloat contentHeight = self.contentSize.height;
    return contentHeight/pageHeight;
}
- (CGFloat)mxbz_pagesX{
    CGFloat pageWidth = self.frame.size.width;
    CGFloat contentWidth = self.contentSize.width;
    return contentWidth/pageWidth;
}
- (CGFloat)mxbz_currentPageY{
    CGFloat pageHeight = self.frame.size.height;
    CGFloat offsetY = self.contentOffset.y;
    return offsetY / pageHeight;
}
- (CGFloat)mxbz_currentPageX{
    CGFloat pageWidth = self.frame.size.width;
    CGFloat offsetX = self.contentOffset.x;
    return offsetX / pageWidth;
}
- (void)mxbz_setPageY:(CGFloat)page{
    [self mxbz_setPageY:page animated:NO];
}
- (void) mxbz_setPageX:(CGFloat)page{
    [self mxbz_setPageX:page animated:NO];
}
- (void)mxbz_setPageY:(CGFloat)page animated:(BOOL)animated {
    CGFloat pageHeight = self.frame.size.height;
    CGFloat offsetY = page * pageHeight;
    CGFloat offsetX = self.contentOffset.x;
    CGPoint offset = CGPointMake(offsetX,offsetY);
    [self setContentOffset:offset];
}
- (void)mxbz_setPageX:(CGFloat)page animated:(BOOL)animated{
    CGFloat pageWidth = self.frame.size.width;
    CGFloat offsetY = self.contentOffset.y;
    CGFloat offsetX = page * pageWidth;
    CGPoint offset = CGPointMake(offsetX,offsetY);
    [self setContentOffset:offset animated:animated];
}

@end
