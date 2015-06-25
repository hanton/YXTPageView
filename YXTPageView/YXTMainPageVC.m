//
//  YXTHotelVC.m
//  HotelVIP
//
//  Created by Hanton on 5/27/15.
//  Copyright (c) 2015 ZKJS. All rights reserved.
//

#import "YXTMainPageVC.h"

static const CGFloat YXTPullUpThreshold = 50.0;

@interface YXTMainPageVC () <YXTSubPageDelegate, YXTToolbarDelegate, UIScrollViewDelegate>
@property (nonatomic) BOOL isDragging;
@end

@implementation YXTMainPageVC

#pragma mark - View Lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.isDragging = NO;
  
  [self addScrollView];
  [self addToolbar];
  [self addMainButton];
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  
  [self addSubPage];
}

#pragma mark - Setup Subviews

- (void)addScrollView {
  self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
  self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) + 0.3);
  self.scrollView.delegate = self;
  self.scrollView.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:self.scrollView];
}

- (void)addToolbar {
  self.toolbarVC = [YXTToolbarVC new];
  self.toolbarVC.view.frame = CGRectMake(0.0, CGRectGetHeight(self.view.frame) - CGRectGetHeight(self.toolbarVC.view.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.toolbarVC.view.frame));
  self.toolbarVC.delegate = self;
  self.toolbarVC.view.alpha = 1.0;
  [self.view addSubview:self.toolbarVC.view];
}

- (void)addSubPage {
  if (!self.subTableViewController) {
    return;
  }
  
  self.subTableViewController.mainViewController = self;
  self.subTableViewController.tableView.frame = CGRectMake(0, CGRectGetHeight(self.view.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
  self.subTableViewController.delegate = self;
  [self.scrollView addSubview:self.subTableViewController.tableView];
}

- (void)addMainButton {
  self.mainButton = [UIButton buttonWithType:UIButtonTypeCustom];
  [self.mainButton addTarget:self
                      action:@selector(didPressedMainButton)
            forControlEvents:UIControlEventTouchUpInside];
  [self.mainButton setBackgroundColor:[UIColor grayColor]];
  CGFloat mainButtonHeight = 50.0;
  CGFloat mainButtonWidth = 50.0;
  CGFloat mainButtonX = (CGRectGetWidth(self.view.frame) - mainButtonWidth) / 2.0;
  CGFloat mainButtonY = (CGRectGetHeight(self.view.frame) - mainButtonHeight) - 8.0;
  self.mainButton.frame = CGRectMake(mainButtonX, mainButtonY, mainButtonWidth, mainButtonHeight);
  self.mainButton.layer.cornerRadius = mainButtonWidth / 2.0;
  self.mainButton.layer.masksToBounds = YES;
  self.mainButton.alpha = 1.0;
  [self.view addSubview:self.mainButton];
}

#pragma mark - YXTToolbarDelegate

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

#pragma mark - YXTSubPageDelegate

- (void)pullDownDidFinish {  
  __weak typeof(self) weakSelf = self;
  [UIView animateWithDuration:0.3 animations:^{
    weakSelf.scrollView.contentInset = UIEdgeInsetsZero;
  }];
  
  self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x, self.scrollView.contentOffset.y);
  self.scrollView.scrollEnabled = YES;
  
  [UIView animateWithDuration:0.3 animations:^{
    weakSelf.toolbarVC.view.alpha = 1.0;
  }];
}

- (void)pullDownDidFail {
  [self resetToolbar];
}

- (void)pullDownTransitToNextViewByPercentage:(NSNumber *)percentage {
  self.toolbarVC.view.alpha = [percentage floatValue];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if (self.isDragging && self.scrollView.contentOffset.y >= 0) {
      NSNumber *percentage = [NSNumber numberWithFloat: 1.0 - (self.scrollView.contentOffset.y / YXTPullUpThreshold)];
    [self pullUpTransitToNextViewByPercentage:percentage];
  }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
  self.isDragging = YES;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
  self.isDragging = NO;
  
  if(scrollView.contentOffset.y > 0 && self.scrollView.contentOffset.y >= YXTPullUpThreshold) {
    [self pullUpDidFinish];
  }
  [self resetToolbar];
}

#pragma mark - Private Methods

- (void)pullUpDidFinish {
  [self.subTableViewController.tableView reloadData];
  
  __weak typeof(self) weakSelf = self;
  [UIView animateWithDuration:0.3 animations:^{
    weakSelf.scrollView.contentInset = UIEdgeInsetsMake(-self.scrollView.contentSize.height, 0, 0, 0);
  }];
  
  self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width, self.scrollView.contentSize.height);
  self.scrollView.scrollEnabled = NO;
}

- (void)pullUpTransitToNextViewByPercentage:(NSNumber *)percentage {
  self.toolbarVC.view.alpha = [percentage floatValue];
}

- (void)resetToolbar {
  __weak typeof(self) weakSelf = self;
  [UIView animateWithDuration:0.3 animations:^{
    weakSelf.toolbarVC.view.alpha = 1.0;
  }];
}

@end
