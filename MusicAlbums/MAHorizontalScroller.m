//
//  MAHorizontalScroller.m
//  MusicAlbums
//
//  Created by Владимир on 20.01.14.
//  Copyright (c) 2014 V. All rights reserved.
//

#import "MAHorizontalScroller.h"

#define VIEW_PADDING 10
#define VIEW_DIMENSIONS 100
#define VIEWS_OFFSET 100

@interface MAHorizontalScroller () <UIScrollViewDelegate>

@end

@implementation MAHorizontalScroller
{
    UIScrollView * scroller;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        scroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        scroller.delegate = self;
        [self addSubview:scroller];
        UITapGestureRecognizer * tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollerTapped:)];
        [scroller addGestureRecognizer:tapRecognizer];
    }
    return self;
}

- (void)scrollerTapped:(UITapGestureRecognizer *)gesture
{
    CGPoint location = [gesture locationInView:gesture.view];
    
    for (int index = 0; index < [self.delegate numberOfViewsForHorizontalScroller:self]; index++)
    {
        UIView * view = scroller.subviews[index];
        if (CGRectContainsPoint(view.frame, location))
        {
            [self.delegate horizontalScroller:self clickedViewAtIndex:index];
            CGPoint offset = CGPointMake(view.frame.origin.x - self.frame.size.width/2 + view.frame.size.width/2, 0);
            [scroller setContentOffset:offset animated:YES];
            break;
        }
    }
}

- (void)reload
{
    // 1 - нечего загружать, если нет делегата:
    if (self.delegate == nil) return;
    
    // 2 - удалить все subviews:
    [scroller.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * stop) {
        [obj removeFromSuperview];
    }];
    
    // 3 - xValue - стартовая точка всех представлений в скроллере:
    CGFloat xValue = VIEWS_OFFSET;
    for (int i = 0; i < [self.delegate numberOfViewsForHorizontalScroller:self]; i++)
    {
        // 4 - добавляем представление в нужную позицию:
        xValue += VIEW_PADDING;
        UIView * view = [self.delegate horizontalScroller:self viewAtIndex:i];
        view.frame = CGRectMake(xValue, VIEW_PADDING, VIEW_DIMENSIONS, VIEW_DIMENSIONS);
        [scroller addSubview:view];
        xValue += VIEW_DIMENSIONS + VIEW_PADDING;
    }
    
    // 5
    [scroller setContentSize:CGSizeMake(xValue + VIEWS_OFFSET, self.frame.size.height)];
    
    // 6 - если определён initialView, центрируем его в скроллере:
    if ([self.delegate respondsToSelector:@selector(initialViewIndexForHorizontalScroller:)])
    {
        int initialView = [self.delegate initialViewIndexForHorizontalScroller:self];
        CGPoint offset = CGPointMake(initialView * (VIEW_DIMENSIONS + (2 * VIEW_PADDING)), 0);
        [scroller setContentOffset:offset animated:YES];
    }
}

- (void)centerCurrentView
{
    int xFinal = scroller.contentOffset.x + (VIEWS_OFFSET / 2) + VIEW_PADDING;
    int viewIndex = xFinal / (VIEW_DIMENSIONS + (2 * VIEW_PADDING));
    xFinal = viewIndex * (VIEW_DIMENSIONS + (2 * VIEW_PADDING));
    [scroller setContentOffset:CGPointMake(xFinal, 0) animated:YES];
    [self.delegate horizontalScroller:self clickedViewAtIndex:viewIndex];
}

- (void)didMoveToSuperview
{
    [self reload];
}

#pragma mark - UIScrollViewDelegate methods

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        [self centerCurrentView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self centerCurrentView];
}

@end
