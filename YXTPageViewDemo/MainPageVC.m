//
//  ViewController.m
//  YXTPageViewDemo
//
//  Created by Hanton on 6/18/15.
//  Copyright (c) 2015 YXT. All rights reserved.
//

#import "MainPageVC.h"
#import "SubPageTVC.h"

@interface MainPageVC ()

@end

@implementation MainPageVC

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.scrollView.backgroundColor = [UIColor colorWithRed:213.0/255.0 green:197.0/255.0 blue:174.0/255.0 alpha:1.0];
  
  UIView *mainPage = [[[NSBundle mainBundle] loadNibNamed:@"MainPage" owner:self options:nil] firstObject];
  mainPage.frame = self.view.bounds;
  [self.scrollView addSubview:mainPage];
  
  self.subTableViewController = [SubPageTVC new];
}

@end
