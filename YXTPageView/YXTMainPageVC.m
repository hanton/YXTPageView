//
//  YXTHotelVC.m
//  HotelVIP
//
//  Created by Hanton on 5/27/15.
//  Copyright (c) 2015 ZKJS. All rights reserved.
//

#import "YXTMainPageVC.h"
#import "YXTPullUpRefreshView.h"
//#import "FXBlurView.h"
//#import "Colours.h"

static const CGFloat YXTPullFreshViewHeight = 1.0;

@interface YXTMainPageVC () <YXTPullUpRefreshViewDelegate, YXTPullDownRefreshViewDelegate, YXTToolbarDelegate, UIScrollViewDelegate>
@property(nonatomic) BOOL isResponseToScroll;
@property(nonatomic, strong) YXTPullUpRefreshView *pullFreshView;
//@property(nonatomic) BOOL showedSubButtons;
//@property (nonatomic, strong) FXBlurView *blurView;
@end

@implementation YXTMainPageVC

#pragma mark View Lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self setupScrollView];
  [self setupToolbar];
//  [self setupMainButton];
//  [self setupMainButtonSubButtons];
  
  self.isResponseToScroll = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  
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
  self.toolbarVC = [[YXTToolbarVC alloc] init];
  self.toolbarVC.view.frame = CGRectMake(0.0, self.view.frame.size.height - self.toolbarVC.view.frame.size.height, self.view.frame.size.width, self.toolbarVC.view.frame.size.height);
  self.toolbarVC.delegate = self;
  self.toolbarVC.view.alpha = 0.0;
  [self.view addSubview:self.toolbarVC.view];
}

//- (void)setupMainButton {
//  self.mainButton = [UIButton buttonWithType:UIButtonTypeCustom];
//  [self.mainButton addTarget:self
//                      action:@selector(showSubButtons)
//            forControlEvents:UIControlEventTouchUpInside];
//  UIImage *mainImage = [UIImage imageNamed:@"ic_home_nor"];
//  [self.mainButton setImage:mainImage forState:UIControlStateNormal];
//  [self.mainButton sizeToFit];
//  CGFloat mainButtonX = (self.view.frame.size.width - self.mainButton.frame.size.width) / 2.0;
//  CGFloat mainButtonY = self.view.frame.size.height - self.mainButton.frame.size.height - 8.0;
//  self.mainButton.frame = CGRectMake(mainButtonX, mainButtonY, self.mainButton.frame.size.width, self.mainButton.frame.size.height);
//  self.mainButton.alpha = 0.0;
//  [self.view addSubview:self.mainButton];
//}

//- (void)setupMainButtonSubButtons {
//  UIImage *subButtonImage = [UIImage imageNamed:@"ic_xuanxiang2_nor"];
//  
//  // Account Button
//  self.accountButton = [UIButton buttonWithType:UIButtonTypeCustom];
//  [self.accountButton addTarget:self
//                         action:@selector(showAccount)
//               forControlEvents:UIControlEventTouchUpInside];
//  [self.accountButton setTitle:@"我的" forState:UIControlStateNormal];
//  [self.accountButton setTitleShadowColor:[UIColor colorFromHexString:@"#DABB84"] forState:UIControlStateNormal];
//  self.accountButton.titleLabel.shadowOffset = CGSizeMake(0.0, 1.0);
//  [self.accountButton setBackgroundImage:subButtonImage forState:UIControlStateNormal];
//  [self.accountButton sizeToFit];
//  CGFloat accountButtonX = (self.view.frame.size.width - self.accountButton.frame.size.width) / 2.0;
//  CGFloat accountButtonY = self.view.frame.size.height - 80.0 - self.accountButton.frame.size.height;
//  self.accountButton.frame = CGRectMake(accountButtonX, accountButtonY, subButtonImage.size.width, subButtonImage.size.height);
//  [self.view addSubview:self.accountButton];
//  self.accountButton.hidden = YES;
//  self.accountButton.transform = CGAffineTransformMakeScale(0.001, 0.001);
//  
//  // VIP Button
//  self.vipButton = [UIButton buttonWithType:UIButtonTypeCustom];
//  [self.vipButton addTarget:self
//                        action:@selector(showVIPService)
//              forControlEvents:UIControlEventTouchUpInside];
//  [self.vipButton setTitle:@"定制" forState:UIControlStateNormal];
//  [self.vipButton setTitleShadowColor:[UIColor colorFromHexString:@"#DABB84"] forState:UIControlStateNormal];
//  self.vipButton.titleLabel.shadowOffset = CGSizeMake(0.0, 1.0);
//  [self.vipButton setBackgroundImage:subButtonImage forState:UIControlStateNormal];
//  [self.vipButton sizeToFit];
//  CGFloat vipButtonX = (self.view.frame.size.width - self.vipButton.frame.size.width) / 2.0;
//  CGFloat vipButtonY = accountButtonY - 10.0 - self.vipButton.frame.size.height;
//  self.vipButton.frame = CGRectMake(vipButtonX, vipButtonY, subButtonImage.size.width, subButtonImage.size.height);
//  [self.view addSubview:self.vipButton];
//  self.vipButton.hidden = YES;
//  self.vipButton.transform = CGAffineTransformMakeScale(0.001, 0.001);
//  
//  // Booking Button
//  self.bookingButton = [UIButton buttonWithType:UIButtonTypeCustom];
//  [self.bookingButton addTarget:self
//                     action:@selector(showBookingSerivce)
//           forControlEvents:UIControlEventTouchUpInside];
//  [self.bookingButton setTitle:@"预付" forState:UIControlStateNormal];
//  [self.bookingButton setTitleShadowColor:[UIColor colorFromHexString:@"#DABB84"] forState:UIControlStateNormal];
//  self.bookingButton.titleLabel.shadowOffset = CGSizeMake(0.0, 1.0);
//  [self.bookingButton setBackgroundImage:subButtonImage forState:UIControlStateNormal];
//  [self.bookingButton sizeToFit];
//  CGFloat bookingButtonX = (self.view.frame.size.width - self.bookingButton.frame.size.width) / 2.0;
//  CGFloat bookingButtonY = vipButtonY - 10.0 - self.bookingButton.frame.size.height;
//  self.bookingButton.frame = CGRectMake(bookingButtonX, bookingButtonY, subButtonImage.size.width, subButtonImage.size.height);
//  [self.view addSubview:self.bookingButton];
//  self.bookingButton.hidden = YES;
//  self.bookingButton.transform = CGAffineTransformMakeScale(0.001, 0.001);
//}

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

//#pragma mark Button Actions
//
//- (void)showBookingSerivce {
//  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"测试"
//                                                  message:@"预付订单"
//                                                 delegate:self
//                                        cancelButtonTitle:@"OK"
//                                        otherButtonTitles:nil];
//  [alert show];
//}
//
//- (void)showVIPService {
////  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"测试"
////                                                  message:@"定制服务"
////                                                 delegate:self
////                                        cancelButtonTitle:@"OK"
////                                        otherButtonTitles:nil];
////  [alert show];
//  [self dismissViewControllerAnimated:YES completion:nil];
//}
//
//- (void)showAccount {
//  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"测试"
//                                                  message:@"用户账号"
//                                                 delegate:self
//                                        cancelButtonTitle:@"OK"
//                                        otherButtonTitles:nil];
//  [alert show];
//}
//
//- (void)showSubButtons {
//  if (self.showedSubButtons) {
//    [self hideBlurBackground];
//  } else {
//    [self showBlurBackground];
//  }
//}
//
//- (void)hideBlurBackground {
//  [self.mainButton setImage:[UIImage imageNamed:@"ic_home_nor"] forState:UIControlStateNormal];
//  
//  __weak typeof(self) weakSelf = self;
//  [UIView animateWithDuration:0.06 animations:^{
//    weakSelf.bookingButton.transform = CGAffineTransformMakeScale(0.001, 0.001);
//    weakSelf.bookingButton.alpha = 0.0;
//    weakSelf.vipButton.transform = CGAffineTransformMakeScale(0.001, 0.001);
//    weakSelf.vipButton.alpha = 0.0;
//    weakSelf.accountButton.transform = CGAffineTransformMakeScale(0.001, 0.001);
//    weakSelf.accountButton.alpha = 0.0;
//  } completion:nil];
//  
//  self.toolbarVC.view.hidden = NO;
//  self.blurView.hidden = YES;
//  
//  self.showedSubButtons = !self.showedSubButtons;
//}
//
//- (void)showBlurBackground {
//  self.toolbarVC.view.hidden = YES;
//  
//  self.blurView = [[FXBlurView alloc] initWithFrame:self.view.bounds];
//  self.blurView.tintColor = [UIColor blackColor];
//  self.blurView.blurRadius = 10.0;
//  self.blurView.dynamic = NO;
//  self.blurView.alpha = 0.95;
//  [self.view addSubview:self.blurView];
//  
//  UIButton *dimButton = [UIButton buttonWithType:UIButtonTypeCustom];
//  dimButton.frame = self.view.bounds;
//  [dimButton addTarget:self
//                action:@selector(hideBlurBackground)
//      forControlEvents:UIControlEventTouchUpInside];
//  dimButton.backgroundColor = [UIColor blackColor];
//  dimButton.alpha = 0.3;
//  [self.blurView addSubview:dimButton];
//  
//  [self.mainButton setImage:[UIImage imageNamed:@"ic_home_pre"] forState:UIControlStateNormal];
//  [self.view bringSubviewToFront:self.mainButton];
//  
//  [self.view bringSubviewToFront:self.accountButton];
//  self.accountButton.hidden = NO;
//  [self.view bringSubviewToFront:self.vipButton];
//  self.vipButton.hidden = NO;
//  [self.view bringSubviewToFront:self.bookingButton];
//  self.bookingButton.hidden = NO;
//  
//  __weak typeof(self) weakSelf = self;
//  [UIView animateWithDuration:0.06 animations:^{
//    weakSelf.accountButton.transform = CGAffineTransformIdentity;
//    weakSelf.accountButton.alpha = 1.0;
//    weakSelf.vipButton.transform = CGAffineTransformIdentity;
//    weakSelf.vipButton.alpha = 1.0;
//    weakSelf.bookingButton.transform = CGAffineTransformIdentity;
//    weakSelf.bookingButton.alpha = 1.0;
//  } completion:nil];
//  
//  self.showedSubButtons = !self.showedSubButtons;
//}

#pragma mark YXTToolbarDelegate

- (void)didPressedPhoneButton {
//  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"测试"
//                                                  message:@"打电话"
//                                                 delegate:self
//                                        cancelButtonTitle:@"OK"
//                                        otherButtonTitles:nil];
//  [alert show];
  NSString *phoneNumber = [@"tel://" stringByAppendingString:@"+8673188688888"];
  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}

- (void)didPressedMapButton {
//  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"测试"
//                                                  message:@"地图"
//                                                 delegate:self
//                                        cancelButtonTitle:@"OK"
//                                        otherButtonTitles:nil];
//  [alert show];
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

- (void)pullDownRefreshDidFail {
  [self resetToolbar];
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
