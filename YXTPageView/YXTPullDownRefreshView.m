//
//  YXTPullDownRefreshView.m
//  HotelVIP
//
//  Created by Hanton on 5/27/15.
//  Copyright (c) 2015 ZKJS. All rights reserved.
//

#import "YXTPullDownRefreshView.h"

static const CGFloat YXTPullDownThreshold = 50.0;

@interface YXTPullDownRefreshView ()
@property (nonatomic) BOOL isDragging;
@property (nonatomic) BOOL isLoading;
@end

@implementation YXTPullDownRefreshView

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    
  }
  return self;
}

- (void)setupWithOwner:(UIScrollView *)owner  delegate:(id)delegate {
  self.owner = owner;
  self.delegate = delegate;
  
  [self.owner addSubview:self];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

  if (self.isLoading && scrollView.contentOffset.y > 0) {
    return;
  } else if (self.isDragging && scrollView.contentOffset.y <= 0.0) {
    if ([self.delegate respondsToSelector:@selector(pullDownRefreshTransitToNextViewByPercentage:)]) {
      CGFloat pullDownOffset = (scrollView.contentOffset.y + YXTPullDownThreshold) / YXTPullDownThreshold;
      if (pullDownOffset < 0.0) {
        pullDownOffset = 0.0;
      }
      NSNumber *percentage = [NSNumber numberWithFloat:pullDownOffset];
      [self.delegate performSelector:@selector(pullDownRefreshTransitToNextViewByPercentage:) withObject:percentage];
    }
  }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
  if (self.isLoading) return;
  self.isDragging = YES;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
  if (self.isLoading) return;
  self.isDragging = NO;
  
  if(scrollView.contentOffset.y <= -YXTPullDownThreshold) {
    [self startLoading];
  } else if(scrollView.contentOffset.y < 0.0) {
    if ([self.delegate respondsToSelector:@selector(pullDownRefreshDidFail)]) {
      [self.delegate performSelector:@selector(pullDownRefreshDidFail) withObject:nil];
    }
  }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  if (self.isLoading) return;
  
  if(scrollView.contentOffset.y <= -YXTPullDownThreshold){
    [self startLoading];
  }
}

- (void)startLoading {
  if (self.isLoading) {
    return;
  }
  self.isLoading = YES;
  
  if ([self.delegate respondsToSelector:@selector(pullDownRefreshDidFinish)]) {
    [self.delegate performSelector:@selector(pullDownRefreshDidFinish) withObject:nil];
  }
}

- (void)stopLoading {
  self.isLoading = NO;
  
  [UIView beginAnimations:nil context:NULL];
  [UIView setAnimationDelegate:self];
  [UIView setAnimationDuration:0.1];
  [UIView commitAnimations];
  [UIView setAnimationDidStopSelector:@selector(stopLoadingComplete:finished:context:)];
}

- (void)stopLoadingComplete:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
  [self setFrame:CGRectMake(0, -YXTPullDownThreshold, self.frame.size.width, 0)];
}

- (float)contentOffsetBottom:(UIScrollView *)scrollView {
  return scrollView.contentSize.height - (scrollView.contentOffset.y + scrollView.bounds.size.height - scrollView.contentInset.bottom);
}

@end
