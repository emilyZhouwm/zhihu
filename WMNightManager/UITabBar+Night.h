//
//  UITabBar+Night.h
//
//  Created by zwm on 15/11/25.
//  Copyright (c) 2015年 zwm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (Night)

@property (nonatomic, strong) IBInspectable UIColor *nightBarTintColor;
@property (nonatomic, strong) UIColor *normalBarTintColor;

- (void)changeColor;
- (void)changeColorWithDuration:(CGFloat)duration;

@end
