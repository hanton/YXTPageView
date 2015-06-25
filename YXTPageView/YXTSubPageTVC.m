//
//  YXTHotelDetailTableVC.m
//  HotelVIP
//
//  Created by Hanton on 5/27/15.
//  Copyright (c) 2015 ZKJS. All rights reserved.
//

#import "YXTSubPageTVC.h"

static const CGFloat YXTPullDownThreshold = 50.0;

@interface YXTSubPageTVC () <UIScrollViewDelegate>
@property (nonatomic) BOOL isDragging;
@end

@implementation YXTSubPageTVC

#pragma mark - View Lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.isDragging = NO;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
  self.isDragging = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if (self.isDragging && scrollView.contentOffset.y <= 0.0) {
    if ([self.delegate respondsToSelector:@selector(pullDownTransitToNextViewByPercentage:)]) {
      CGFloat pullDownOffset = (scrollView.contentOffset.y + YXTPullDownThreshold) / YXTPullDownThreshold;
      if (pullDownOffset < 0.0) {
        pullDownOffset = 0.0;
      }
      NSNumber *percentage = [NSNumber numberWithFloat:pullDownOffset];
      [self.delegate performSelector:@selector(pullDownTransitToNextViewByPercentage:) withObject:percentage];
    }
  }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
  self.isDragging = NO;
  
  if(scrollView.contentOffset.y <= -YXTPullDownThreshold) {
    if ([self.delegate respondsToSelector:@selector(pullDownDidFinish)]) {
      [self.delegate performSelector:@selector(pullDownDidFinish) withObject:nil];
    }
  } else if(scrollView.contentOffset.y < 0.0) {
    if ([self.delegate respondsToSelector:@selector(pullDownDidFail)]) {
      [self.delegate performSelector:@selector(pullDownDidFail) withObject:nil];
    }
  }
}

@end
