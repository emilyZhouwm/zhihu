//
//  UIBarButtonItem+Night.m
//
//  Created by zwm on 15/11/25.
//  Copyright (c) 2015年 zwm. All rights reserved.
//

#import "UIBarButtonItem+Night.h"
#import "WMNightManager.h"
#import "objc/runtime.h"

@implementation UIBarButtonItem (Night)

- (UIColor *)nightTintColor
{
    UIColor *nightColor = objc_getAssociatedObject(self, @selector(nightTintColor));
    if (nightColor) {
        return nightColor;
    } 
    return self.tintColor;
}

- (void)setNightTintColor:(UIColor *)nightTintColor
{
    [self checkNormalButtonItem];
    if ([WMNightManager currentStatus] == WMNightStatusNight) {
        [self setTintColor:nightTintColor];
    }
    objc_setAssociatedObject(self, @selector(nightTintColor), nightTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)checkNormalButtonItem
{
    if (!objc_getAssociatedObject(self, @selector(normalTintColor))) {
        if (self.tintColor) {
            objc_setAssociatedObject(self, @selector(normalTintColor), self.tintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        } else if ([UINavigationBar appearance].tintColor) {
            objc_setAssociatedObject(self, @selector(normalTintColor), [UINavigationBar appearance].tintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        } else {
            objc_setAssociatedObject(self, @selector(normalTintColor), [UIColor whiteColor], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
}

- (UIColor *)normalTintColor
{
    UIColor *normalColor = objc_getAssociatedObject(self, @selector(normalTintColor));
    if (normalColor) {
        return normalColor;
    }
    return self.tintColor;
}

- (void)setNormalTintColor:(UIColor *)normalTintColor
{
    if ([WMNightManager currentStatus] == WMNightStatusNormal) {
        [self setTintColor:normalTintColor];
    }
    objc_setAssociatedObject(self, @selector(normalTintColor), normalTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - ChangeColor

- (void)changeColorWithDuration:(CGFloat)duration
{
    [UIView animateWithDuration:duration animations:^{
        [self setTintColor:([WMNightManager currentStatus] == WMNightStatusNight) ? self.nightTintColor : self.normalTintColor];
    }];
}

- (void)changeColor
{
    [self setTintColor:([WMNightManager currentStatus] == WMNightStatusNight) ? self.nightTintColor : self.normalTintColor];
}

@end
