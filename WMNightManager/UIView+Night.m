//
//  UIView+Night.m
//
//  Created by zwm on 15/11/25.
//  Copyright (c) 2015年 zwm. All rights reserved.
//

#import "UIView+Night.h"
#import "WMNightManager.h"
#import "objc/runtime.h"

@implementation UIView (Night)

- (UIColor *)nightBackgroundColor
{
    UIColor *nightColor = objc_getAssociatedObject(self, @selector(nightBackgroundColor));
    if (nightColor) {
        return nightColor;
    }
    return self.backgroundColor;
}

- (void)setNightBackgroundColor:(UIColor *)nightBackgroundColor
{
    [self checkNormal];
    if ([WMNightManager currentStatus] == WMNightStatusNight) {
        [self setBackgroundColor:nightBackgroundColor];
    }
    objc_setAssociatedObject(self, @selector(nightBackgroundColor), nightBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)checkNormal
{
    if (!objc_getAssociatedObject(self, @selector(normalBackgroundColor))) {
        objc_setAssociatedObject(self, @selector(normalBackgroundColor), self.backgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (UIColor *)normalBackgroundColor
{
    UIColor *normalColor = objc_getAssociatedObject(self, @selector(normalBackgroundColor));
    if (normalColor) {
        return normalColor;
    }
    return self.backgroundColor;
}

- (void)setNormalBackgroundColor:(UIColor *)normalBackgroundColor
{
    if ([WMNightManager currentStatus] == WMNightStatusNormal) {
        [self setBackgroundColor:normalBackgroundColor];
    }
    objc_setAssociatedObject(self, @selector(normalBackgroundColor), normalBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - ChangeColor

- (void)changeColorWithDuration:(CGFloat)duration
{
    [UIView animateWithDuration:duration animations:^{
        [self setBackgroundColor:([WMNightManager currentStatus] == WMNightStatusNight) ? self.nightBackgroundColor : self.normalBackgroundColor];
    }];
}

- (void)changeColor
{
    [self setBackgroundColor:([WMNightManager currentStatus] == WMNightStatusNight) ? self.nightBackgroundColor : self.normalBackgroundColor];
}

@end
