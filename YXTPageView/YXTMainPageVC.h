//
//  YXTHotelVC.h
//  HotelVIP
//
//  Created by Hanton on 5/27/15.
//  Copyright (c) 2015 ZKJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXTSubPageTVC.h"
#import "YXTToolbarVC.h"

@interface YXTMainPageVC : UIViewController
@property(nonatomic, strong) YXTToolbarVC *toolbarVC;
@property(nonatomic, strong) YXTSubPageTVC *subTableViewController;
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) UIButton *mainButton;
@end
