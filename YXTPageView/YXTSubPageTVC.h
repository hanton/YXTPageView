//
//  YXTHotelDetailTableVC.h
//  HotelVIP
//
//  Created by Hanton on 5/27/15.
//  Copyright (c) 2015 ZKJS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YXTSubPageDelegate;

@interface YXTSubPageTVC : UITableViewController
@property (nonatomic, weak) id<YXTSubPageDelegate> delegate;
@property(nonatomic, weak) UIViewController *mainViewController;

@end

@protocol YXTSubPageDelegate <NSObject>
- (void)pullDownDidFail;
- (void)pullDownDidFinish;
- (void)pullDownTransitToNextViewByPercentage:(NSNumber *)percentage;
@end
