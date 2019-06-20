#import <UIKit/UIKit.h>

@interface UIScrollView (MXBZPages)
- (NSInteger)mxbz_pages;
- (NSInteger)mxbz_currentPage;
- (CGFloat)mxbz_scrollPercent;

- (CGFloat)mxbz_pagesY;
- (CGFloat)mxbz_pagesX;
- (CGFloat)mxbz_currentPageY;
- (CGFloat)mxbz_currentPageX;
- (void)mxbz_setPageY:(CGFloat)page;
- (void)mxbz_setPageX:(CGFloat)page;
- (void)mxbz_setPageY:(CGFloat)page animated:(BOOL)animated;
- (void)mxbz_setPageX:(CGFloat)page animated:(BOOL)animated;
@end
