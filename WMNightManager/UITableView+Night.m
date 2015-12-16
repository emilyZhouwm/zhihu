//
//  UITableView+Night.m
//
//  Created by zwm on 15/11/25.
//  Copyright (c) 2015年 zwm. All rights reserved.
//

#import "UITableView+Night.h"
#import "WMNightManager.h"
#import "objc/runtime.h"

@implementation UITableView (Night)

- (UIColor *)nightSeparatorColor
{
    UIColor *nightColor = objc_getAssociatedObject(self, @selector(nightSeparatorColor));
    if (nightColor) {
        return nightColor;
    }
    return self.separatorColor;
}

- (void)setNightSeparatorColor:(UIColor *)nightSeparatorColor
{
    [self checkNormalSeparator];
    if ([WMNightManager currentStatus] == WMNightStatusNight) {
        [self setSeparatorColor:nightSeparatorColor];
    }
    objc_setAssociatedObject(self, @selector(nightSeparatorColor), nightSeparatorColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)checkNormalSeparator
{
    if (!objc_getAssociatedObject(self, @selector(normalSeparatorColor))) {
        objc_setAssociatedObject(self, @selector(normalSeparatorColor), self.separatorColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (UIColor *)normalSeparatorColor
{
    UIColor *normalColor = objc_getAssociatedObject(self, @selector(normalSeparatorColor));
    if (normalColor) {
        return normalColor;
    }
    return self.separatorColor;
}

- (void)setNormalSeparatorColor:(UIColor *)normalSeparatorColor
{
    if ([WMNightManager currentStatus] == WMNightStatusNormal) {
        [self setSeparatorColor:normalSeparatorColor];
    }
    objc_setAssociatedObject(self, @selector(normalSeparatorColor), normalSeparatorColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - ChangeColor

- (void)changeColorWithDuration:(CGFloat)duration
{
    if ([WMNightManager currentStatus] == WMNightStatusNight) {
        [UIView animateWithDuration:duration animations:^{
            [self setSeparatorColor:self.nightSeparatorColor];
            [self setBackgroundColor:self.nightBackgroundColor];
        }];
    } else {
        [UIView animateWithDuration:duration animations:^{
            [self setSeparatorColor:self.normalSeparatorColor];
            [self setBackgroundColor:self.normalBackgroundColor];
        }];
    }
}

- (void)changeColor
{
    if ([WMNightManager currentStatus] == WMNightStatusNight) {
        [self setSeparatorColor:self.nightSeparatorColor];
        [self setBackgroundColor:self.nightBackgroundColor];
    } else {
        [self setSeparatorColor:self.normalSeparatorColor];
        [self setBackgroundColor:self.normalBackgroundColor];
    }
}

@end
