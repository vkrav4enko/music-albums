//
//  MAHorizontalScroller.h
//  MusicAlbums
//
//  Created by Владимир on 20.01.14.
//  Copyright (c) 2014 V. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MAHorizontalScrollerDelegate;

@interface MAHorizontalScroller : UIView

@property (weak) id<MAHorizontalScrollerDelegate> delegate;

-(void) reload;

@end

@protocol MAHorizontalScrollerDelegate <NSObject>

@required
- (NSInteger)numberOfViewsForHorizontalScroller:(MAHorizontalScroller *)scroller;
- (UIView *)horizontalScroller:(MAHorizontalScroller *)scroller viewAtIndex:(int)index;
- (void)horizontalScroller:(MAHorizontalScroller *)scroller clickedViewAtIndex:(int)index;

@optional
- (NSInteger)initialViewIndexForHorizontalScroller:(MAHorizontalScroller *)scroller;

@end
