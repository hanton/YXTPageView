//
//  SubPageCell.m
//  YXTPageViewDemo
//
//  Created by Hanton on 6/18/15.
//  Copyright (c) 2015 YXT. All rights reserved.
//

#import "SubPageCell.h"

@implementation SubPageCell

- (void)awakeFromNib {
  // Initialization code
  self.backgroundColor = [UIColor colorWithRed:213.0/255.0 green:197.0/255.0 blue:174.0/255.0 alpha:1.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
  
  // Configure the view for the selected state
}

@end
