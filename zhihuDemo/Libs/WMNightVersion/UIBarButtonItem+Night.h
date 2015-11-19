//
//  UIBarButtonItem+Night.h
//
//  Created by zwm on 15/11/25.
//  Copyright (c) 2015年 zwm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Night)

@property (nonatomic, strong) IBInspectable UIColor *nightTintColor;
@property (nonatomic, strong) UIColor *normalTintColor;

- (void)changeColor;
- (void)changeColorWithDuration:(CGFloat)duration;

@end
