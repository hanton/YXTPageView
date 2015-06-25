//
//  SubPageTVC.m
//  YXTPageViewDemo
//
//  Created by Hanton on 6/18/15.
//  Copyright (c) 2015 YXT. All rights reserved.
//

#import "SubPageTVC.h"
#import "SubPageCell.h"

static NSString* const SubPageCellIdentifier = @"SubPageCell";

@interface SubPageTVC ()

@end

@implementation SubPageTVC

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SubPageCell class]) bundle:nil] forCellReuseIdentifier:SubPageCellIdentifier];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  // Return the number of sections.
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  // Return the number of rows in the section.
  return 28;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SubPageCellIdentifier forIndexPath:indexPath];
  
  // Configure the cell...
  
  return cell;
}
@end
