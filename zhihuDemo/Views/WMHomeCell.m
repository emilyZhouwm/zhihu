//
//  WMHomeCell.m
//  zhihuDemo
//
//  Created by zwm on 15/6/24.
//  Copyright (c) 2015年 zwm. All rights reserved.
//

#import "WMHomeCell.h"
#import "WMNews.h"
#import "UIImageView+WebCache.h"

@interface WMHomeCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@end

@implementation WMHomeCell

- (void)awakeFromNib
{
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setStories:(WMStories *)stories
{
    if (stories.images.count > 0) {
        [_iconView sd_setImageWithURL:[NSURL URLWithString:stories.images[0]]];
    }
    _titleLbl.text = stories.title;
    if (stories.selected) {
        _titleLbl.normalTextColor = [UIColor lightGrayColor];
        _titleLbl.nightTextColor = [UIColor grayColor];
    } else {
        _titleLbl.normalTextColor = [UIColor colorWithRed:56/255.0 green:56/255.0 blue:56/255.0 alpha:1];
        _titleLbl.nightTextColor = [UIColor lightGrayColor];
    }
}

+ (CGFloat)cellHeight
{
    return 84;
}

@end
