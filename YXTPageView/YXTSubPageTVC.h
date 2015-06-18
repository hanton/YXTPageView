//
//  YXTHotelDetailTableVC.h
//  HotelVIP
//
//  Created by Hanton on 5/27/15.
//  Copyright (c) 2015 ZKJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXTPullDownRefreshView.h"

@interface YXTSubPageTVC : UITableViewController

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, weak) UIViewController *mainViewController;
@property(nonatomic, strong) YXTPullDownRefreshView *pullFreshView;

@end
