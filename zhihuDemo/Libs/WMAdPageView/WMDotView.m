//
//  WMPageControl.m
//
//  Created by zwm on 15/5/18.
//  Copyright (c) 2015年 zwm. All rights reserved.
//

#import "WMDotView.h"

@implementation WMDotView

+ (CGSize)dotSize
{
    return CGSizeMake(12, 2);
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialization];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialization];
    }
    return self;
}

- (void)initialization
{
    self.backgroundColor = [UIColor grayColor];
    self.layer.cornerRadius = 1;
}

- (void)changeActivityState:(BOOL)active
{
    if (active) {
        self.backgroundColor = [UIColor colorWithRed:1/255.0 green:131/255.0 blue:209/255.0 alpha:1.0];
    } else {
        self.backgroundColor = [UIColor lightGrayColor];
    }
}

@end
