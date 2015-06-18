//
//  YXTPullUpRefreshView.m
//  HotelVIP
//
//  Created by Hanton on 5/27/15.
//  Copyright (c) 2015 ZKJS. All rights reserved.
//

#import "YXTPullUpRefreshView.h"

static const CGFloat YXTPullUpThreshold = 50.0;

@interface YXTPullUpRefreshView ()
@property (nonatomic) BOOL isDragging;
@property (nonatomic) BOOL isLoading;
@end

@implementation YXTPullUpRefreshView

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor blueColor];
  }
  return self;
}

- (void)setupWithOwner:(UIScrollView *)owner  delegate:(id)delegate {
  self.owner = owner;
  self.delegate = delegate;
  
  [_owner addSubview:self];
}

- (void)updateOffsetY:(CGFloat)y
{
  CGRect originFrame = self.frame;
  self.frame = CGRectMake(originFrame.origin.x, y, originFrame.size.width, originFrame.size.height);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
  if (self.isLoading) return;
  self.isDragging = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  
  if (!self.isLoading && scrollView.contentOffset.y < 0) {
    return;
  } else if (self.isDragging && [self contentOffsetBottom:scrollView] <= 0) {
    if ([self.delegate respondsToSelector:@selector(pullUpRefreshTransitToNextViewByPercentage:)]) {
      NSNumber *percentage = [NSNumber numberWithFloat:([self contentOffsetBottom:scrollView] + YXTPullUpThreshold) / YXTPullUpThreshold];
      [self.delegate performSelector:@selector(pullUpRefreshTransitToNextViewByPercentage:) withObject:percentage];
    }
  }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
  if (self.isLoading) return;
  self.isDragging = NO;
  
  if(scrollView.contentOffset.y > 0 && [self contentOffsetBottom:scrollView] <= -YXTPullUpThreshold){
    [self startLoading];
  }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  if (self.isLoading) return;
  
  if(scrollView.contentOffset.y > 0 && [self contentOffsetBottom:scrollView] <= -YXTPullUpThreshold){
    [self startLoading];
  }
}

- (void)startLoading {
  if (self.isLoading) {
    return;
  }
  self.isLoading = YES;
  
  if ([self.delegate respondsToSelector:@selector(pullUpRefreshDidFinish)]) {
    [self.delegate performSelector:@selector(pullUpRefreshDidFinish) withObject:nil];
  }
}

- (void)stopLoading {
  self.isLoading = NO;
}

- (void)stopLoadingComplete:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
  [self setFrame:CGRectMake(0, self.owner.contentSize.height, self.frame.size.width, 0)];
}

- (float)contentOffsetBottom:(UIScrollView *)scrollView {
  return scrollView.contentSize.height - (scrollView.contentOffset.y + scrollView.bounds.size.height - scrollView.contentInset.bottom);
}

@end
