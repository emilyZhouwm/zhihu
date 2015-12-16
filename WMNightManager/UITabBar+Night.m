//
//  UITabBar+Night.m
//
//  Created by zwm on 15/11/25.
//  Copyright (c) 2015年 zwm. All rights reserved.
//

#import "UITabBar+Night.h"
#import "WMNightManager.h"
#import "objc/runtime.h"

@implementation UITabBar (Night)

- (UIColor *)nightBarTintColor
{
    UIColor *nightColor = objc_getAssociatedObject(self, @selector(nightBarTintColor));
    if (nightColor) {
        return nightColor;
    } 
    return self.barTintColor;
}

- (void)setNightBarTintColor:(UIColor *)nightBarTintColor
{
    [self checkNormalTabBar];
    if ([WMNightManager currentStatus] == WMNightStatusNight) {
        [self setBarTintColor:nightBarTintColor];
    }
    objc_setAssociatedObject(self, @selector(nightBarTintColor), nightBarTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)checkNormalTabBar
{
    if (!objc_getAssociatedObject(self, @selector(normalBarTintColor))) {
        objc_setAssociatedObject(self, @selector(normalBarTintColor), self.barTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (UIColor *)normalBarTintColor
{
    UIColor *normalColor = objc_getAssociatedObject(self, @selector(normalBarTintColor));
    if (normalColor) {
        return normalColor;
    }
    return self.barTintColor;
}

- (void)setNormalBarTintColor:(UIColor *)normalBarTintColor
{
    if ([WMNightManager currentStatus] == WMNightStatusNormal) {
        [self setBarTintColor:normalBarTintColor];
    }
    objc_setAssociatedObject(self, @selector(normalBarTintColor), normalBarTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - ChangeColor

- (void)changeColorWithDuration:(CGFloat)duration
{
    if ([WMNightManager currentStatus] == WMNightStatusNight) {
        [UIView animateWithDuration:duration animations:^{
            [self setBarTintColor:self.nightBarTintColor];
            [self setBackgroundColor:self.nightBackgroundColor];
        }];
    } else {
        [UIView animateWithDuration:duration animations:^{
            [self setBarTintColor:self.normalBarTintColor];
            [self setBackgroundColor:self.normalBackgroundColor];
        }];
    }
}

- (void)changeColor
{
    if ([WMNightManager currentStatus] == WMNightStatusNight) {
        [self setBarTintColor:self.nightBarTintColor];
        [self setBackgroundColor:self.nightBackgroundColor];
    } else {
        [self setBarTintColor:self.normalBarTintColor];
        [self setBackgroundColor:self.normalBackgroundColor];
    }
}

@end
