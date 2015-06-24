//
//  YXTHotelDetailTableVC.m
//  HotelVIP
//
//  Created by Hanton on 5/27/15.
//  Copyright (c) 2015 ZKJS. All rights reserved.
//

#import "YXTSubPageTVC.h"

static const CGFloat YXTPullFreshViewHeight = 0.0;

@interface YXTSubPageTVC () <UIScrollViewDelegate>

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
  [self addRefreshView];
  
  self.clearsSelectionOnViewWillAppear = YES;
}

#pragma mark - Setup Subviews

- (void)addRefreshView {
  if (self.pullFreshView == nil) {
    self.pullFreshView = [[YXTPullDownRefreshView alloc]initWithFrame:CGRectMake(0, -YXTPullFreshViewHeight, self.view.frame.size.width, YXTPullFreshViewHeight)];
  }
  
  if (!self.pullFreshView.superview) {
    [self.pullFreshView setupWithOwner:self.tableView delegate:(id<YXTPullDownRefreshViewDelegate>)self.mainViewController];
  }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
  [self.pullFreshView scrollViewWillBeginDragging:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  [self.pullFreshView scrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
  [self.pullFreshView scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

@end
