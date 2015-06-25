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
  
  UIView *mainPage = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame))];
  mainPage.backgroundColor = [UIColor cyanColor];
  [self.scrollView addSubview:mainPage];
  
  self.subTableViewController = [SubPageTVC new];
}

@end
