//
//  YXTHotelVC.m
//  HotelVIP
//
//  Created by Hanton on 5/27/15.
//  Copyright (c) 2015 ZKJS. All rights reserved.
//

#import "YXTMainPageVC.h"
#import "YXTPullUpRefreshView.h"

static const CGFloat YXTPullFreshViewHeight = 0.0;

@interface YXTMainPageVC () <YXTPullUpRefreshViewDelegate, YXTPullDownRefreshViewDelegate, YXTToolbarDelegate, UIScrollViewDelegate>
@property(nonatomic) BOOL isResponseToScroll;
@property(nonatomic, strong) YXTPullUpRefreshView *pullFreshView;
@end

@implementation YXTMainPageVC

#pragma mark View Lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self setupScrollView];
  [self setupToolbar];
  
  self.isResponseToScroll = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  
  [self setupMainButton];
  [self addRefreshView];
  [self addSubPage];
}

#pragma mark Setup Subviews

- (void)setupScrollView {
  self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
  self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height + 0.3);
  self.scrollView.delegate = self;
  self.scrollView.backgroundColor = [UIColor blackColor];
  [self.view addSubview:self.scrollView];
}

- (void)setupToolbar {
  self.toolbarVC = [YXTToolbarVC new];
  self.toolbarVC.view.frame = CGRectMake(0.0, self.view.frame.size.height - self.toolbarVC.view.frame.size.height, self.view.frame.size.width, self.toolbarVC.view.frame.size.height);
  self.toolbarVC.delegate = self;
  self.toolbarVC.view.alpha = 1.0;
  [self.view addSubview:self.toolbarVC.view];
}

- (void)addRefreshView {
  if (self.pullFreshView == nil) {
    float originY = self.scrollView.contentSize.height;
    self.pullFreshView = [[YXTPullUpRefreshView alloc]initWithFrame:CGRectMake(0, originY, self.view.frame.size.width, YXTPullFreshViewHeight)];
    self.pullFreshView.backgroundColor = [UIColor blackColor];
  }
  
  if (!self.pullFreshView.superview) {
    [self.pullFreshView setupWithOwner:self.scrollView delegate:self];
  }
}

- (void)addSubPage {
  if (!self.subTableViewController) {
    return;
  }
  
  self.subTableViewController.mainViewController = self;
  self.subTableViewController.tableView.frame = CGRectMake(0, self.view.frame.size.height + YXTPullFreshViewHeight, self.view.frame.size.width, self.view.frame.size.height);
  [self.scrollView addSubview:self.subTableViewController.tableView];
}

- (void)setupMainButton {
  self.mainButton = [UIButton buttonWithType:UIButtonTypeCustom];
  [self.mainButton addTarget:self
                      action:@selector(didPressedMainButton)
            forControlEvents:UIControlEventTouchUpInside];
  [self.mainButton setBackgroundColor:[UIColor grayColor]];
  CGFloat mainButtonHeight = 50.0;
  CGFloat mainButtonWidth = 50.0;
  CGFloat mainButtonX = (self.view.frame.size.width - mainButtonWidth) / 2.0;
  CGFloat mainButtonY = (self.view.frame.size.height - mainButtonHeight) - 8.0;
  self.mainButton.frame = CGRectMake(mainButtonX, mainButtonY, mainButtonWidth, mainButtonHeight);
  self.mainButton.layer.cornerRadius = mainButtonWidth / 2.0;
  self.mainButton.layer.masksToBounds = YES;
  self.mainButton.alpha = 1.0;
  [self.view addSubview:self.mainButton];
}

#pragma mark YXTToolbarDelegate

- (void)didPressedMainButton {
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Click Main Button"
                                                  message:@""
                                                 delegate:nil
                                        cancelButtonTitle:@"OK"
                                        otherButtonTitles: nil];
  [alert show];
}

- (void)didPressedLeftButton {
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Click Left Button"
                                                  message:@""
                                                 delegate:nil
                                        cancelButtonTitle:@"OK"
                                        otherButtonTitles: nil];
  [alert show];
}

- (void)didPressedRightButton {
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Click Right Button"
                                                  message:@""
                                                 delegate:nil
                                        cancelButtonTitle:@"OK"
                                        otherButtonTitles: nil];
  [alert show];
}

#pragma mark YXTPullUpRefreshViewDelegate

- (void)pullUpRefreshDidFinish {
  [self.subTableViewController.tableView reloadData];
  
  __weak typeof(self) weakSelf = self;
  [UIView animateWithDuration:0.3 animations:^{
    weakSelf.scrollView.contentInset = UIEdgeInsetsMake(-self.scrollView.contentSize.height, 0, 0, 0);
  }];
  
  self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width, self.scrollView.contentSize.height);
  self.scrollView.scrollEnabled = NO;
  [self.pullFreshView stopLoading];
  self.pullFreshView.hidden = YES;
  self.isResponseToScroll = NO;
}

- (void)pullUpRefreshTransitToNextViewByPercentage:(NSNumber *)percentage {
  self.toolbarVC.view.alpha = [percentage floatValue];
}

#pragma mark YXTPullDownRefreshViewDelegate

- (void)pullDownRefreshDidFinish {
  [self.subTableViewController.pullFreshView stopLoading];
  
  __weak typeof(self) weakSelf = self;
  [UIView animateWithDuration:0.3 animations:^{
    weakSelf.scrollView.contentInset = UIEdgeInsetsZero;
  }];
  
  self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x, self.scrollView.contentOffset.y);
  self.scrollView.scrollEnabled = YES;
  self.pullFreshView.hidden = NO;
  self.isResponseToScroll = YES;
  
  [UIView animateWithDuration:0.3 animations:^{
    weakSelf.toolbarVC.view.alpha = 1.0;
  }];
}

- (void)pullDownRefreshTransitToNextViewByPercentage:(NSNumber *)percentage {
  self.toolbarVC.view.alpha = [percentage floatValue];
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if (self.isResponseToScroll) {
    [self.pullFreshView scrollViewDidScroll:scrollView];
  } else {
    [self.subTableViewController.pullFreshView scrollViewDidScroll:scrollView];
  }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
  if (self.isResponseToScroll) {
    [self.pullFreshView scrollViewWillBeginDragging:scrollView];
  } else {
    [self.subTableViewController.pullFreshView scrollViewWillBeginDragging:scrollView];
  }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
  if (self.isResponseToScroll) {
    [self.pullFreshView scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
  } else {
    [self.subTableViewController.pullFreshView scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
  }
  
  [self resetToolbar];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  if (self.isResponseToScroll) {
    [self.pullFreshView scrollViewDidEndDecelerating:scrollView];
  } else {
    [self.subTableViewController.pullFreshView scrollViewDidEndDecelerating:scrollView];
  }
}

#pragma mark Private Methods

- (void)resetToolbar {
  __weak typeof(self) weakSelf = self;
  [UIView animateWithDuration:0.3 animations:^{
    weakSelf.toolbarVC.view.alpha = 1.0;
  }];
}

@end
