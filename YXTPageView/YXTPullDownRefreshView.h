//
//  YXTPullDownRefreshView.h
//  HotelVIP
//
//  Created by Hanton on 5/27/15.
//  Copyright (c) 2015 ZKJS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YXTPullDownRefreshViewDelegate;

@interface YXTPullDownRefreshView : UIView
@property (nonatomic, weak) id delegate;
@property (nonatomic, weak) UIScrollView *owner;

- (void)setupWithOwner:(UIScrollView *)owner delegate:(id<YXTPullDownRefreshViewDelegate>)delegate;
- (void)startLoading;
- (void)stopLoading;
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
@end

@protocol YXTPullDownRefreshViewDelegate <NSObject>
- (void)pullDownRefreshDidFail;
- (void)pullDownRefreshDidFinish;
- (void)pullDownRefreshTransitToNextViewByPercentage:(NSNumber *)percentage;
@end
