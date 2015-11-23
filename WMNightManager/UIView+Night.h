//
//  UIView+Night.h
//
//  Created by zwm on 15/11/25.
//  Copyright (c) 2015年 zwm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Night)

@property (nonatomic, strong) IBInspectable UIColor *nightBackgroundColor;
@property (nonatomic, strong) UIColor *normalBackgroundColor;

- (void)changeColor;
- (void)changeColorWithDuration:(CGFloat)duration;

@end
