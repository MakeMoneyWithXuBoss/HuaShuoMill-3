//
//  BTVPageViewController.m
//  BTVBCZLapp
//
//  Created by apple on 14-3-11.
//  Copyright (c) 2014年 jetsen. All rights reserved.
//

#import "BTVPageViewController.h"

#define kDefaultTabHeight 44.0 // Default tab height
#define kDefaultTabOffset 56.0 // Offset of the second and further tabs' from left
#define kDefaultTabWidth 108.0

#define kDefaultTabLocation 1.0 // 1.0: Top, 0.0: Bottom

#define kDefaultStartFromSecondTab 0.0 // 1.0: YES, 0.0: NO

#define kDefaultCenterCurrentTab 0.0 // 1.0: YES, 0.0: NO

#define kPageViewTag 34

#define kDefaultIndicatorColor [UIColor colorWithRed:178.0/255.0 green:203.0/255.0 blue:57.0/255.0 alpha:0.75]
#define kDefaultTabsViewBackgroundColor [UIColor colorWithRed:234.0/255.0 green:234.0/255.0 blue:234.0/255.0 alpha:0.75]
#define kDefaultContentViewBackgroundColor [UIColor colorWithRed:248.0/255.0 green:248.0/255.0 blue:248.0/255.0 alpha:0.75]

// TabBarView for tabs, that provides un/selected state indicators
@class TabBarView;

@interface TabBarView : UIView
@property (nonatomic, getter = isSelected) BOOL selected;
@property (nonatomic) UIColor *indicatorColor;
@end

@implementation TabBarView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    // Update view as state changed
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    UIBezierPath *bezierPath;
    
    // Draw top line
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(0.0, 0.0)];
    [bezierPath addLineToPoint:CGPointMake(rect.size.width, 0.0)];
    [[UIColor colorWithWhite:197.0/255.0 alpha:0.75] setStroke];
    [bezierPath setLineWidth:1.0];
    [bezierPath stroke];
    
    // Draw bottom line
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(0.0, rect.size.height)];
    [bezierPath addLineToPoint:CGPointMake(rect.size.width, rect.size.height)];
    [[UIColor colorWithWhite:197.0/255.0 alpha:0.75] setStroke];
    [bezierPath setLineWidth:0.5];
    [bezierPath stroke];
    
    // Draw an indicator line if tab is selected
    if (self.selected) {
        
        bezierPath = [UIBezierPath bezierPath];
        
        // Draw the indicator
        [bezierPath moveToPoint:CGPointMake(6.0, rect.size.height - 1.0)];
        [bezierPath addLineToPoint:CGPointMake(rect.size.width - 6.0, rect.size.height - 1.0)];
        [bezierPath setLineWidth:2.0];
        [self.indicatorColor setStroke];
        [bezierPath stroke];
        
    }
}
@end

@interface BTVPageViewController ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate>

@property UIPageViewController *pageViewController;
@property (assign) id<UIScrollViewDelegate> origPageScrollViewDelegate;

@property UIScrollView *tabsView;
@property UIView *contentView;

@property NSMutableArray *tabs;
@property NSMutableArray *contents;

@property NSUInteger tabCount;
@property (getter = isAnimatingToTab, assign) BOOL animatingToTab;

@property (nonatomic) NSUInteger activeTabIndex;

@end

@implementation BTVPageViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self defaultSettings];
    }
    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self defaultSettings];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self reloadData];
}

- (void)viewWillLayoutSubviews {
    
    CGRect frame;
    
    frame = _tabsView.frame;
    frame.origin.x = 0.0;
    frame.origin.y = self.tabLocation ? 0.0 : self.view.frame.size.height - self.tabHeight;
    frame.size.width = self.view.bounds.size.width;
    frame.size.height = self.tabHeight;
    _tabsView.frame = frame;
    
    frame = _contentView.frame;
    frame.origin.x = 0.0;
    frame.origin.y = self.tabLocation ? self.tabHeight : 0.0;
    frame.size.width = self.view.bounds.size.width;
    frame.size.height = self.view.frame.size.height - self.tabHeight;
    _contentView.frame = frame;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleTapGesture:(id)sender {
    
    self.animatingToTab = YES;
    
    // Get the desired page's index
    UITapGestureRecognizer *tapGestureRecognizer = (UITapGestureRecognizer *)sender;
    UIView *tabView = tapGestureRecognizer.view;
    __block NSUInteger index = [_tabs indexOfObject:tabView];
    
    // Get the desired viewController
    UIViewController *viewController = [self viewControllerAtIndex:index];
    
    // __weak pageViewController to be used in blocks to prevent retaining strong reference to self
    __weak UIPageViewController *weakPageViewController = self.pageViewController;
    __weak BTVPageViewController *weakSelf = self;
    
    
    if (index < self.activeTabIndex) {
        [self.pageViewController setViewControllers:@[viewController]
                                          direction:UIPageViewControllerNavigationDirectionReverse
                                           animated:YES
                                         completion:^(BOOL completed) {
                                             weakSelf.animatingToTab = NO;
                                             
                                             // Set the current page again to obtain synchronisation between tabs and content
                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                 [weakPageViewController setViewControllers:@[viewController]
                                                                                  direction:UIPageViewControllerNavigationDirectionReverse
                                                                                   animated:NO
                                                                                 completion:nil];
                                             });
                                         }];
    } else if (index > self.activeTabIndex) {
        [self.pageViewController setViewControllers:@[viewController]
                                          direction:UIPageViewControllerNavigationDirectionForward
                                           animated:YES
                                         completion:^(BOOL completed) {
                                             weakSelf.animatingToTab = NO;
                                             
                                             // Set the current page again to obtain synchronisation between tabs and content
                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                 [weakPageViewController setViewControllers:@[viewController]
                                                                                  direction:UIPageViewControllerNavigationDirectionForward
                                                                                   animated:NO
                                                                                 completion:nil];
                                             });
                                         }];
    }
    
    // Set activeTabIndex
    self.activeTabIndex = index;
}

#pragma mark -
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    
    // Re-align tabs if needed
    self.activeTabIndex = self.activeTabIndex;
}

#pragma mark - Setter/Getter
- (void)setActiveTabIndex:(NSUInteger)activeTabIndex {
    
    TabBarView *activeTabView;
    
    // Set to-be-inactive tab unselected
    activeTabView = [self tabViewAtIndex:self.activeTabIndex];
    activeTabView.selected = NO;
    
    // Set to-be-active tab selected
    activeTabView = [self tabViewAtIndex:activeTabIndex];
    activeTabView.selected = YES;
    
    // Inform delegate about the change
    // toIndex:activeTabIndex
    if (self.activeTabIndex != activeTabIndex) {
        if ([self.delegate respondsToSelector:@selector(BTVPageView:didChangeTabFromIndex:)]) {
            [self.delegate BTVPageView:self didChangeTabFromIndex:self.activeTabIndex];
        }
    }
    
    // Set current activeTabIndex
    _activeTabIndex = activeTabIndex;
    
    // Inform delegate about the change
    if ([self.delegate respondsToSelector:@selector(BTVPageView:didChangeTabToIndex:)]) {
        [self.delegate BTVPageView:self didChangeTabToIndex:self.activeTabIndex];
    }
    
    // Bring tab to active position
    // Position the tab in center if centerCurrentTab option provided as YES
    
    UIView *tabView = [self tabViewAtIndex:self.activeTabIndex];
    CGRect frame = tabView.frame;
    
    if (self.centerCurrentTab) {
        
        frame.origin.x += (frame.size.width / 2);
        frame.origin.x -= _tabsView.frame.size.width / 2;
        frame.size.width = _tabsView.frame.size.width;
        
        if (frame.origin.x < 0) {
            frame.origin.x = 0;
        }
        
        if ((frame.origin.x + frame.size.width) > _tabsView.contentSize.width) {
            frame.origin.x = (_tabsView.contentSize.width - _tabsView.frame.size.width);
        }
    } else {
        
        frame.origin.x -= self.tabOffset;
        frame.size.width = self.tabsView.frame.size.width;
    }
    
    [_tabsView scrollRectToVisible:frame animated:YES];
}

#pragma mark -
- (void)defaultSettings {
    
    // Default settings
    _tabHeight = kDefaultTabHeight;
    _tabOffset = kDefaultTabOffset;
    _tabWidth = kDefaultTabWidth;
    
    _tabLocation = kDefaultTabLocation;
    
    _startFromSecondTab = kDefaultStartFromSecondTab;
    
    _centerCurrentTab = kDefaultCenterCurrentTab;
    
    // Default colors
    _indicatorColor = kDefaultIndicatorColor;
    _tabsViewBackgroundColor = kDefaultTabsViewBackgroundColor;
    _contentViewBackgroundColor = kDefaultContentViewBackgroundColor;
    
    // pageViewController
    _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                          navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                        options:nil];
    
    //Setup some forwarding events to hijack the scrollview
//    self.origPageScrollViewDelegate = ((UIScrollView*)[_pageViewController.view.subviews objectAtIndex:0]).delegate;
//    [((UIScrollView*)[_pageViewController.view.subviews objectAtIndex:0]) setDelegate:self];
    
    _pageViewController.dataSource = self;
    _pageViewController.delegate = self;
    
    self.animatingToTab = NO;
}
- (void)reloadData {
    
    // Get settings if provided
    if ([self.delegate respondsToSelector:@selector(BTVPageView:valueForOption:withDefault:)])
    {
        _tabHeight = [self.delegate BTVPageView:self valueForOption:BTVPageViewOptionTabHeight withDefault:kDefaultTabHeight];
        _tabOffset = [self.delegate BTVPageView:self valueForOption:BTVPageViewOptionTabOffset withDefault:kDefaultTabOffset];
        _tabWidth = [self.delegate BTVPageView:self valueForOption:BTVPageViewOptionTabWidth withDefault:kDefaultTabWidth];
        
        _tabLocation = [self.delegate BTVPageView:self valueForOption:BTVPageViewOptionTabLocation withDefault:kDefaultTabLocation];
        
        _startFromSecondTab = [self.delegate BTVPageView:self valueForOption:BTVPageViewOptionStartFromSecondTab withDefault:kDefaultStartFromSecondTab];
        
        _centerCurrentTab = [self.delegate BTVPageView:self valueForOption:BTVPageViewOptionCenterCurrentTab withDefault:kDefaultCenterCurrentTab];
        
        /*  eric change  */
        _tabWidthArray = [self.delegate widthOfTabsForBTVPageView:self];
    }
    
    // Get colors if provided
    if ([self.delegate respondsToSelector:@selector(BTVPageView:colorForComponent:withDefault:)])
    {
        _indicatorColor = [self.delegate BTVPageView:self colorForComponent:BTVPageViewIndicator withDefault:kDefaultIndicatorColor];
        _tabsViewBackgroundColor = [self.delegate BTVPageView:self colorForComponent:BTVPageViewTabsView withDefault:kDefaultTabsViewBackgroundColor];
        _contentViewBackgroundColor = [self.delegate BTVPageView:self colorForComponent:BTVPageViewContent withDefault:kDefaultContentViewBackgroundColor];
    }
    
    // Empty tabs and contents
    [_tabs removeAllObjects];
    [_contents removeAllObjects];
    
    _tabCount = [self.dataSource numberOfTabsForBTVPageView:self];
    
    // Populate arrays with [NSNull null];
    _tabs = [NSMutableArray arrayWithCapacity:_tabCount];
    for (int i = 0; i < _tabCount; i++)
    {
        [_tabs addObject:[NSNull null]];
    }
    
    _contents = [NSMutableArray arrayWithCapacity:_tabCount];
    for (int i = 0; i < _tabCount; i++)
    {
        [_contents addObject:[NSNull null]];
    }
    
    // Add tabsView
    _tabsView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.tabHeight)];
    _tabsView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _tabsView.backgroundColor = self.tabsViewBackgroundColor;
    _tabsView.showsHorizontalScrollIndicator = NO;
    _tabsView.showsVerticalScrollIndicator = NO;
//    _tabsView.bounces = NO;
    
    [self.view insertSubview:_tabsView atIndex:0];
    
    // Add tab views to _tabsView
    CGFloat contentSizeWidth = 0;
    for (int i = 0; i < _tabCount; i++)
    {
        UIView *tabView = [self tabViewAtIndex:i];
        
        CGRect frame = tabView.frame;
        frame.origin.x = contentSizeWidth;
//        frame.size.width = self.tabWidth;
        /*  eric change  */
        frame.size.width = [[self.tabWidthArray objectAtIndex:i] intValue];
        tabView.frame = frame;
        
        [_tabsView addSubview:tabView];
        
        contentSizeWidth += tabView.frame.size.width;
        
        // To capture tap events
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        [tabView addGestureRecognizer:tapGestureRecognizer];
    }
    
    _tabsView.contentSize = CGSizeMake(contentSizeWidth, self.tabHeight);
    
    // Add contentView
    _contentView = [self.view viewWithTag:kPageViewTag];
    
    if (!_contentView)
    {
        _contentView = _pageViewController.view;
        _contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _contentView.backgroundColor = self.contentViewBackgroundColor;
        _contentView.bounds = self.view.bounds;
        _contentView.tag = kPageViewTag;
        
        [self.view insertSubview:_contentView atIndex:0];
    }
    
    // Set first viewController
    UIViewController *viewController;
    
    if (self.startFromSecondTab)
    {
        viewController = [self viewControllerAtIndex:1];
    }
    else
    {
        viewController = [self viewControllerAtIndex:0];
    }
    
    if (viewController == nil)
    {
        viewController = [[UIViewController alloc] init];
        viewController.view = [[UIView alloc] init];
    }
    
    [_pageViewController setViewControllers:@[viewController]
                                  direction:UIPageViewControllerNavigationDirectionForward
                                   animated:NO
                                 completion:nil];
    
    // Set activeTabIndex
    self.activeTabIndex = self.startFromSecondTab;
}

- (void)reloadNewData:(NSUInteger)index
{
    UIViewController *viewController;
    
    
    viewController = [self viewControllerAtIndex:index];
    
    [_pageViewController setViewControllers:@[viewController]
                                  direction:UIPageViewControllerNavigationDirectionForward
                                   animated:NO
                                 completion:nil];
    
    self.activeTabIndex = [self indexForViewController:viewController];
    
}

- (TabBarView *)tabViewAtIndex:(NSUInteger)index {
    
    if (index >= _tabCount) {
        return nil;
    }
    
    if ([[_tabs objectAtIndex:index] isEqual:[NSNull null]]) {
        
        // Get view from dataSource
        UIView *tabViewContent = [self.dataSource BTVPageView:self viewForTabAtIndex:index];
        
//        // Create TabView and subview the content
//        TabBarView *tabView = [[TabBarView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.tabWidth, self.tabHeight)];
        /*  eric change  */
        TabBarView *tabView = [[TabBarView alloc] initWithFrame:CGRectMake(0.0, 0.0, [[self.tabWidthArray objectAtIndex:index] intValue], self.tabHeight)];
        
        [tabView addSubview:tabViewContent];
        [tabView setClipsToBounds:YES];
        [tabView setIndicatorColor:self.indicatorColor];
        
        tabViewContent.center = tabView.center;
        
        // Replace the null object with tabView
        [_tabs replaceObjectAtIndex:index withObject:tabView];
    }
    
    return [_tabs objectAtIndex:index];
}
- (NSUInteger)indexForTabView:(UIView *)tabView {
    
    return [_tabs indexOfObject:tabView];
}

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    if (index >= _tabCount) {
        return nil;
    }
    
    if ([[_contents objectAtIndex:index] isEqual:[NSNull null]]) {
        
        UIViewController *viewController;
        
        if ([self.dataSource respondsToSelector:@selector(BTVPageView:contentViewControllerForTabAtIndex:)])
        {
            viewController = [self.dataSource BTVPageView:self contentViewControllerForTabAtIndex:index];
        }
        else if ([self.dataSource respondsToSelector:@selector(BTVPageView:contentViewForTabAtIndex:)])
        {
            
            UIView *view = [self.dataSource BTVPageView:self contentViewForTabAtIndex:index];
            
            // Adjust view's bounds to match the pageView's bounds
            UIView *pageView = [self.view viewWithTag:kPageViewTag];
            view.frame = pageView.bounds;
            
            viewController = [UIViewController new];
            viewController.view = view;
        }
        else
        {
            viewController = [[UIViewController alloc] init];
            viewController.view = [[UIView alloc] init];
        }
        
        [_contents replaceObjectAtIndex:index withObject:viewController];
    }
    
    return [_contents objectAtIndex:index];
}
- (NSUInteger)indexForViewController:(UIViewController *)viewController
{
    return [_contents indexOfObject:viewController];
}

#pragma mark - UIPageViewControllerDataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = [self indexForViewController:viewController];
    index++;
    return [self viewControllerAtIndex:index];
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [self indexForViewController:viewController];
    index--;
    return [self viewControllerAtIndex:index];
}

#pragma mark - UIPageViewControllerDelegate
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers {
    
}
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    
    UIViewController *viewController = self.pageViewController.viewControllers[0];
    self.activeTabIndex = [self indexForViewController:viewController];
}

#pragma mark - UIScrollViewDelegate, Responding to Scrolling and Dragging
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if ([self.origPageScrollViewDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.origPageScrollViewDelegate scrollViewDidScroll:scrollView];
    }
    
    if (![self isAnimatingToTab]) {
        UIView *tabView = [self tabViewAtIndex:self.activeTabIndex];
        
        // Get the related tab view position
        CGRect frame = tabView.frame;
        
        CGFloat movedRatio = (scrollView.contentOffset.x / scrollView.frame.size.width) - 1;
        frame.origin.x += movedRatio * frame.size.width;
        
        if (self.centerCurrentTab) {
            
            frame.origin.x += (frame.size.width / 2);
            frame.origin.x -= _tabsView.frame.size.width / 2;
            frame.size.width = _tabsView.frame.size.width;
            
            if (frame.origin.x < 0) {
                frame.origin.x = 0;
            }
            
            if ((frame.origin.x + frame.size.width) > _tabsView.contentSize.width) {
                frame.origin.x = (_tabsView.contentSize.width - _tabsView.frame.size.width);
            }
        } else {
            
            frame.origin.x -= self.tabOffset;
            frame.size.width = self.tabsView.frame.size.width;
        }
        
        [_tabsView scrollRectToVisible:frame animated:NO];
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([self.origPageScrollViewDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [self.origPageScrollViewDelegate scrollViewWillBeginDragging:scrollView];
    }
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if ([self.origPageScrollViewDelegate respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)]) {
        [self.origPageScrollViewDelegate scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if ([self.origPageScrollViewDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [self.origPageScrollViewDelegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView{
    if ([self.origPageScrollViewDelegate respondsToSelector:@selector(scrollViewShouldScrollToTop:)]) {
        return [self.origPageScrollViewDelegate scrollViewShouldScrollToTop:scrollView];
    }
    return NO;
}
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    if ([self.origPageScrollViewDelegate respondsToSelector:@selector(scrollViewDidScrollToTop:)]) {
        [self.origPageScrollViewDelegate scrollViewDidScrollToTop:scrollView];
    }
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    if ([self.origPageScrollViewDelegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]) {
        [self.origPageScrollViewDelegate scrollViewWillBeginDecelerating:scrollView];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([self.origPageScrollViewDelegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [self.origPageScrollViewDelegate scrollViewDidEndDecelerating:scrollView];
    }
}

#pragma mark - UIScrollViewDelegate, Managing Zooming
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    if ([self.origPageScrollViewDelegate respondsToSelector:@selector(viewForZoomingInScrollView:)]) {
        return [self.origPageScrollViewDelegate viewForZoomingInScrollView:scrollView];
    }
    
    return nil;
}
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    if ([self.origPageScrollViewDelegate respondsToSelector:@selector(scrollViewWillBeginZooming:withView:)]) {
        [self.origPageScrollViewDelegate scrollViewWillBeginZooming:scrollView withView:view];
    }
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    if ([self.origPageScrollViewDelegate respondsToSelector:@selector(scrollViewDidEndZooming:withView:atScale:)]) {
        [self.origPageScrollViewDelegate scrollViewDidEndZooming:scrollView withView:view atScale:scale];
    }
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    if ([self.origPageScrollViewDelegate respondsToSelector:@selector(scrollViewDidZoom:)]) {
        [self.origPageScrollViewDelegate scrollViewDidZoom:scrollView];
    }
}

#pragma mark - UIScrollViewDelegate, Responding to Scrolling Animations
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if ([self.origPageScrollViewDelegate respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)]) {
        [self.origPageScrollViewDelegate scrollViewDidEndScrollingAnimation:scrollView];
    }
}

@end
