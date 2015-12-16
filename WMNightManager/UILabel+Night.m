//
//  UILabel+Night.m
//
//  Created by zwm on 15/11/25.
//  Copyright (c) 2015年 zwm. All rights reserved.
//

#import "UILabel+Night.h"
#import "WMNightManager.h"
#import "objc/runtime.h"

@implementation UILabel (Night)

- (UIColor *)nightTextColor
{
    UIColor *nightColor = objc_getAssociatedObject(self, @selector(nightTextColor));
    if (nightColor) {
        return nightColor;
    } 
    return self.textColor;
}

- (void)setNightTextColor:(UIColor *)nightTextColor
{
    [self checkNormalT];
    if ([WMNightManager currentStatus] == WMNightStatusNight) {
        [self setTextColor:nightTextColor];
    }
    objc_setAssociatedObject(self, @selector(nightTextColor), nightTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)checkNormalT
{
    if (!objc_getAssociatedObject(self, @selector(normalTextColor))) {
        objc_setAssociatedObject(self, @selector(normalTextColor), self.textColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (UIColor *)normalTextColor
{
    UIColor *normalColor = objc_getAssociatedObject(self, @selector(normalTextColor));
    if (normalColor) {
        return normalColor;
    }
    return self.textColor;
}

- (void)setNormalTextColor:(UIColor *)normalTextColor
{
    if ([WMNightManager currentStatus] == WMNightStatusNormal) {
        [self setTextColor:normalTextColor];
    }
    objc_setAssociatedObject(self, @selector(normalTextColor), normalTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - ChangeColor

- (void)changeColorWithDuration:(CGFloat)duration
{
    if ([WMNightManager currentStatus] == WMNightStatusNight) {
        [UIView animateWithDuration:duration animations:^{
            [self setTextColor:self.nightTextColor];
            [self setBackgroundColor:self.nightBackgroundColor];
        }];
    } else {
        [UIView animateWithDuration:duration animations:^{
            [self setTextColor:self.normalTextColor];
            [self setBackgroundColor:self.normalBackgroundColor];
        }];
    }
}

- (void)changeColor
{
    if ([WMNightManager currentStatus] == WMNightStatusNight) {
        [self setTextColor:self.nightTextColor];
        [self setBackgroundColor:self.nightBackgroundColor];
    } else {
        [self setTextColor:self.normalTextColor];
        [self setBackgroundColor:self.normalBackgroundColor];
    }
}

@end
