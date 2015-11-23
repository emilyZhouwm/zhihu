//
//  UILabel+Night.h
//
//  Created by zwm on 15/11/25.
//  Copyright (c) 2015年 zwm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Night)

@property (nonatomic, strong) IBInspectable UIColor *nightTextColor;
@property (nonatomic, strong) UIColor *normalTextColor;

- (void)changeColor;
- (void)changeColorWithDuration:(CGFloat)duration;

@end
