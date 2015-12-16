//
//  UINavigationBar+Night.m
//
//  Created by zwm on 15/11/25.
//  Copyright (c) 2015年 zwm. All rights reserved.
//

#import "UINavigationBar+Night.h"
#import "WMNightManager.h"
#import "UIColor+Night.h"
#import "objc/runtime.h"

CGFloat const stepDuration = 0.01;

@implementation UINavigationBar (Night)

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
    [self checkNormalBarTint];
    if ([WMNightManager currentStatus] == WMNightStatusNight) {
        [self setBarTintColor:nightBarTintColor];
    }
    objc_setAssociatedObject(self, @selector(nightBarTintColor), nightBarTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)checkNormalBarTint
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
    [self checkNormalTint];
    if ([WMNightManager currentStatus] == WMNightStatusNight) {
        [self setTintColor:nightTintColor];
    }
    objc_setAssociatedObject(self, @selector(nightTintColor), nightTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)checkNormalTint
{
    if (!objc_getAssociatedObject(self, @selector(normalTintColor))) {
        objc_setAssociatedObject(self, @selector(normalTintColor), self.tintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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

- (void)animateWithArray:(NSArray *)array
{
    NSUInteger counter = 0;
    
    for (UIColor *color in array) {
        double delayInSeconds = stepDuration * counter++;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [UIView animateWithDuration:stepDuration animations:^{
                self.barTintColor = color;
            }];
        });
    }
}

#pragma mark - ChangeColor

- (void)changeColorWithDuration:(CGFloat)duration
{
    if ([WMNightManager currentStatus] == WMNightStatusNight) {
        
        NSArray *colorArray = [UIColor arrayFromColor:self.barTintColor ToColor:self.nightBarTintColor duration:duration stepDuration:stepDuration];
        if (colorArray) {
            [self animateWithArray:colorArray];
        }
        
        [UIView animateWithDuration:duration animations:^{
            [self setTintColor:self.nightTintColor];
            [self setBackgroundColor:self.nightBackgroundColor];
        }];
    } else {
        NSArray *colorArray = [UIColor arrayFromColor:self.barTintColor ToColor:self.normalBarTintColor duration:duration stepDuration:stepDuration];
        if (colorArray) {
            [self animateWithArray:colorArray];
        }
        
        [UIView animateWithDuration:duration animations:^{
            [self setTintColor:self.normalTintColor];
            [self setBackgroundColor:self.normalBackgroundColor];
        }];
    }
}

- (void)changeColor
{
    if ([WMNightManager currentStatus] == WMNightStatusNight) {
        [self setBarTintColor:self.nightBarTintColor];
        [self setTintColor:self.nightTintColor];
        [self setBackgroundColor:self.nightBackgroundColor];
    } else {
        [self setBarTintColor:self.normalBarTintColor];
        [self setTintColor:self.normalTintColor];
        [self setBackgroundColor:self.normalBackgroundColor];
    }
}

@end
