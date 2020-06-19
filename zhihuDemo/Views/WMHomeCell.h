//
//  WMHomeCell.h
//  zhihuDemo
//
//  Created by zwm on 15/6/24.
//  Copyright (c) 2015年 zwm. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WMStories;
@interface WMHomeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

- (void)setStories:(WMStories *)stories;

+ (CGFloat)cellHeight;

@end
