//
//  YXTToobar.h
//  HotelVIP
//
//  Created by Hanton on 5/27/15.
//  Copyright (c) 2015 ZKJS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YXTToolbarDelegate;

@interface YXTToolbarVC : UIViewController
@property (nonatomic, weak) id delegate;
@end

@protocol YXTToolbarDelegate <NSObject>
- (void)didPressedPhoneButton;
- (void)didPressedMapButton;
@end
