//
//  YXTToobar.m
//  HotelVIP
//
//  Created by Hanton on 5/27/15.
//  Copyright (c) 2015 ZKJS. All rights reserved.
//

#import "YXTToolbarVC.h"

@interface YXTToolbarVC ()

@end

@implementation YXTToolbarVC

- (void)viewDidLoad {
  [super viewDidLoad];
  
}

- (IBAction)pressPhoneButton:(id)sender {
  if ([self.delegate respondsToSelector:@selector(didPressedLeftButton)]) {
    [self.delegate performSelector:@selector(didPressedLeftButton) withObject:nil];
  }
}

- (IBAction)pressMapButton:(id)sender {
  if ([self.delegate respondsToSelector:@selector(didPressedRightButton)]) {
    [self.delegate performSelector:@selector(didPressedRightButton) withObject:nil];
  }
}

@end
