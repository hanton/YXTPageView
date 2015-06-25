//
//  YXTHotelDetailTableVC.m
//  HotelVIP
//
//  Created by Hanton on 5/27/15.
//  Copyright (c) 2015 ZKJS. All rights reserved.
//

#import "YXTSubPageTVC.h"

static const CGFloat YXTPullFreshViewHeight = 0.0;
static const CGFloat YXTPullDownThreshold = 50.0;

@interface YXTSubPageTVC () <UIScrollViewDelegate>
@property (nonatomic) BOOL isDragging;
@property (nonatomic) BOOL isLoading;
@end

@implementation YXTSubPageTVC

#pragma mark - View Lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.view.backgroundColor = [UIColor whiteColor];
  
  if (self.tableView == nil) {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
  }
  self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  self.tableView.showsVerticalScrollIndicator = NO;
  
  self.clearsSelectionOnViewWillAppear = YES;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
  if (self.isLoading) return;
  self.isDragging = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if (self.isLoading && scrollView.contentOffset.y > 0) {
    return;
  } else if (self.isDragging && scrollView.contentOffset.y <= 0.0) {
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
  if (self.isLoading) return;
  self.isDragging = NO;
  
  if(scrollView.contentOffset.y <= -YXTPullDownThreshold) {
    [self startLoading];
  } else if(scrollView.contentOffset.y < 0.0) {
    if ([self.delegate respondsToSelector:@selector(pullDownDidFail)]) {
      [self.delegate performSelector:@selector(pullDownDidFail) withObject:nil];
    }
  }
}

#pragma mark - Private Method

- (void)startLoading {
  if (self.isLoading) {
    return;
  }
  self.isLoading = YES;
  
  if ([self.delegate respondsToSelector:@selector(pullDownDidFinish)]) {
    [self.delegate performSelector:@selector(pullDownDidFinish) withObject:nil];
  }
}

- (void)stopLoading {
  self.isLoading = NO;
}

@end
