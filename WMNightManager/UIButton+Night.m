//
//  UIButton+Night.m
//
//  Created by zwm on 15/11/25.
//  Copyright (c) 2015年 zwm. All rights reserved.
//

#import "UIButton+Night.h"
#import "WMNightManager.h"
#import "objc/runtime.h"

@implementation UIButton (Night)

- (UIColor *)nightTColorN
{
    UIColor *nightColor = objc_getAssociatedObject(self, @selector(nightTColorN));
    if (nightColor) {
        return nightColor;
    }
    return [self titleColorForState:UIControlStateNormal];
}

- (void)setNightTColorN:(UIColor *)nightTColor
{
    [self checkNormalTN];
    if ([WMNightManager currentStatus] == WMNightStatusNight) {
        [self setTitleColor:nightTColor forState:UIControlStateNormal];
    }
    objc_setAssociatedObject(self, @selector(nightTColorN), nightTColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)checkNormalTN
{
    if (!objc_getAssociatedObject(self, @selector(normalTColorN))) {
        objc_setAssociatedObject(self, @selector(normalTColorN), [self titleColorForState:UIControlStateNormal], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (UIColor *)nightTColorH
{
    UIColor *nightColor = objc_getAssociatedObject(self, @selector(nightTColorH));
    if (nightColor) {
        return nightColor;
    }
    return [self titleColorForState:UIControlStateHighlighted];
}

- (void)setNightTColorH:(UIColor *)nightTColor
{
    [self checkNormalTH];
    if ([WMNightManager currentStatus] == WMNightStatusNight) {
        [self setTitleColor:nightTColor forState:UIControlStateHighlighted];
    }
    objc_setAssociatedObject(self, @selector(nightTColorH), nightTColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)checkNormalTH
{
    if (!objc_getAssociatedObject(self, @selector(normalTColorH))) {
        objc_setAssociatedObject(self, @selector(normalTColorH), [self titleColorForState:UIControlStateHighlighted], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (UIColor *)nightTColorS
{
    UIColor *nightColor = objc_getAssociatedObject(self, @selector(nightTColorS));
    if (nightColor) {
        return nightColor;
    }
    return [self titleColorForState:UIControlStateSelected];
}

- (void)setNightTColorS:(UIColor *)nightTColor
{
    [self checkNormalTS];
    if ([WMNightManager currentStatus] == WMNightStatusNight) {
        [self setTitleColor:nightTColor forState:UIControlStateSelected];
    }
    objc_setAssociatedObject(self, @selector(nightTColorS), nightTColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)checkNormalTS
{
    if (!objc_getAssociatedObject(self, @selector(normalTColorS))) {
        objc_setAssociatedObject(self, @selector(normalTColorS), [self titleColorForState:UIControlStateSelected], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (UIColor *)nightTColorD
{
    UIColor *nightColor = objc_getAssociatedObject(self, @selector(nightTColorD));
    if (nightColor) {
        return nightColor;
    }
    return [self titleColorForState:UIControlStateDisabled];
}

- (void)setNightTColorD:(UIColor *)nightTColor
{
    [self checkNormalTD];
    if ([WMNightManager currentStatus] == WMNightStatusNight) {
        [self setTitleColor:nightTColor forState:UIControlStateDisabled];
    }
    objc_setAssociatedObject(self, @selector(nightTColorD), nightTColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)checkNormalTD
{
    if (!objc_getAssociatedObject(self, @selector(normalTColorD))) {
        objc_setAssociatedObject(self, @selector(normalTColorD), [self titleColorForState:UIControlStateDisabled], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (UIColor *)normalTColorN
{
    UIColor *normalColor = objc_getAssociatedObject(self, @selector(normalTColorN));
    if (normalColor) {
        return normalColor;
    }
    return [self titleColorForState:UIControlStateNormal];
}

- (void)setNormalTColorN:(UIColor *)normalTitleColorN
{
    if ([WMNightManager currentStatus] == WMNightStatusNormal) {
        [self setTitleColor:normalTitleColorN forState:UIControlStateNormal];
    }
    objc_setAssociatedObject(self, @selector(normalTColorN), normalTitleColorN, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)normalTColorH
{
    UIColor *normalColor = objc_getAssociatedObject(self, @selector(normalTColorH));
    if (normalColor) {
        return normalColor;
    }
    return [self titleColorForState:UIControlStateHighlighted];
}

- (void)setNormalTColorH:(UIColor *)normalTitleColorH
{
    if ([WMNightManager currentStatus] == WMNightStatusNormal) {
        [self setTitleColor:normalTitleColorH forState:UIControlStateHighlighted];
    }
    objc_setAssociatedObject(self, @selector(normalTColorH), normalTitleColorH, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)normalTColorS
{
    UIColor *normalColor = objc_getAssociatedObject(self, @selector(normalTColorS));
    if (normalColor) {
        return normalColor;
    }
    return [self titleColorForState:UIControlStateSelected];
}

- (void)setNormalTColorS:(UIColor *)normalTitleColorS
{
    if ([WMNightManager currentStatus] == WMNightStatusNormal) {
        [self setTitleColor:normalTitleColorS forState:UIControlStateSelected];
    }
    objc_setAssociatedObject(self, @selector(normalTColorS), normalTitleColorS, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)normalTColorD
{
    UIColor *normalColor = objc_getAssociatedObject(self, @selector(normalTColorD));
    if (normalColor) {
        return normalColor;
    }
    return [self titleColorForState:UIControlStateDisabled];
}

- (void)setNormalTColorD:(UIColor *)normalTitleColorD
{
    if ([WMNightManager currentStatus] == WMNightStatusNormal) {
        [self setTitleColor:normalTitleColorD forState:UIControlStateDisabled];
    }
    objc_setAssociatedObject(self, @selector(normalTColorD), normalTitleColorD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - image
- (UIImage *)nightImageN
{
    UIImage *nightImage = objc_getAssociatedObject(self, @selector(nightImageN));
    if (nightImage) {
        return nightImage;
    }
    return [self imageForState:UIControlStateNormal];
}

- (void)setNightImageN:(UIImage *)nightImage
{
    if (!objc_getAssociatedObject(self, @selector(normalImageN))) {
        objc_setAssociatedObject(self, @selector(normalImageN), [self imageForState:UIControlStateNormal], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    if ([WMNightManager currentStatus] == WMNightStatusNight) {
        [self setImage:nightImage forState:UIControlStateNormal];
    }
    objc_setAssociatedObject(self, @selector(nightImageN), nightImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)nightImageH
{
    UIImage *nightImage = objc_getAssociatedObject(self, @selector(nightImageH));
    if (nightImage) {
        return nightImage;
    }
    return [self imageForState:UIControlStateHighlighted];
}

- (void)setNightImageH:(UIImage *)nightImage
{
    if (!objc_getAssociatedObject(self, @selector(normalImageH))) {
        objc_setAssociatedObject(self, @selector(normalImageH), [self imageForState:UIControlStateHighlighted], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    if ([WMNightManager currentStatus] == WMNightStatusNight) {
        [self setImage:nightImage forState:UIControlStateHighlighted];
    }
    objc_setAssociatedObject(self, @selector(nightImageH), nightImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)nightImageS
{
    UIImage *nightImage = objc_getAssociatedObject(self, @selector(nightImageS));
    if (nightImage) {
        return nightImage;
    }
    return [self imageForState:UIControlStateSelected];
}

- (void)setNightImageS:(UIImage *)nightImage
{
    if (!objc_getAssociatedObject(self, @selector(normalImageS))) {
        objc_setAssociatedObject(self, @selector(normalImageS), [self imageForState:UIControlStateSelected], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    if ([WMNightManager currentStatus] == WMNightStatusNight) {
        [self setImage:nightImage forState:UIControlStateSelected];
    }
    objc_setAssociatedObject(self, @selector(nightImageS), nightImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)nightImageD
{
    UIImage *nightImage = objc_getAssociatedObject(self, @selector(nightImageD));
    if (nightImage) {
        return nightImage;
    }
    return [self imageForState:UIControlStateDisabled];
}

- (void)setNightImageD:(UIImage *)nightImage
{
    if (!objc_getAssociatedObject(self, @selector(normalImageD))) {
        objc_setAssociatedObject(self, @selector(normalImageD), [self imageForState:UIControlStateDisabled], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    if ([WMNightManager currentStatus] == WMNightStatusNight) {
        [self setImage:nightImage forState:UIControlStateDisabled];
    }
    objc_setAssociatedObject(self, @selector(nightImageD), nightImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)normalImageN
{
    UIImage *normalImage = objc_getAssociatedObject(self, @selector(normalImageN));
    if (normalImage) {
        return normalImage;
    }
    return [self imageForState:UIControlStateNormal];
}

- (void)setNormalImageN:(UIImage *)normalImage
{
    if ([WMNightManager currentStatus] == WMNightStatusNormal) {
        [self setImage:normalImage forState:UIControlStateNormal];
    }
    objc_setAssociatedObject(self, @selector(normalImageN), normalImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)normalImageH
{
    UIImage *normalImage = objc_getAssociatedObject(self, @selector(normalImageH));
    if (normalImage) {
        return normalImage;
    }
    return [self imageForState:UIControlStateHighlighted];
}

- (void)setNormalImageH:(UIImage *)normalImage
{
    if ([WMNightManager currentStatus] == WMNightStatusNormal) {
        [self setImage:normalImage forState:UIControlStateHighlighted];
    }
    objc_setAssociatedObject(self, @selector(normalImageH), normalImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)normalImageS
{
    UIImage *normalImage = objc_getAssociatedObject(self, @selector(normalImageS));
    if (normalImage) {
        return normalImage;
    }
    return [self imageForState:UIControlStateSelected];
}

- (void)setNormalImageS:(UIImage *)normalImage
{
    if ([WMNightManager currentStatus] == WMNightStatusNormal) {
        [self setImage:normalImage forState:UIControlStateSelected];
    }
    objc_setAssociatedObject(self, @selector(normalImageS), normalImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)normalImageD
{
    UIImage *normalImage = objc_getAssociatedObject(self, @selector(normalImageD));
    if (normalImage) {
        return normalImage;
    }
    return [self imageForState:UIControlStateDisabled];
}

- (void)setNormalImageD:(UIImage *)normalImage
{
    if ([WMNightManager currentStatus] == WMNightStatusNormal) {
        [self setImage:normalImage forState:UIControlStateDisabled];
    }
    objc_setAssociatedObject(self, @selector(normalImageD), normalImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - backimage
- (UIImage *)nightBackImageN
{
    UIImage *nightImage = objc_getAssociatedObject(self, @selector(nightBackImageN));
    if (nightImage) {
        return nightImage;
    }
    return [self backgroundImageForState:UIControlStateNormal];
}

- (void)setNightBackImageN:(UIImage *)nightImage
{
    if (!objc_getAssociatedObject(self, @selector(normalBackImageN))) {
        objc_setAssociatedObject(self, @selector(normalBackImageN), [self backgroundImageForState:UIControlStateNormal], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    if ([WMNightManager currentStatus] == WMNightStatusNight) {
        [self setBackgroundImage:nightImage forState:UIControlStateNormal];
    }
    objc_setAssociatedObject(self, @selector(nightBackImageN), nightImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)nightBackImageH
{
    UIImage *nightImage = objc_getAssociatedObject(self, @selector(nightBackImageH));
    if (nightImage) {
        return nightImage;
    }
    return [self backgroundImageForState:UIControlStateHighlighted];
}

- (void)setNightBackImageH:(UIImage *)nightImage
{
    if (!objc_getAssociatedObject(self, @selector(normalBackImageH))) {
        objc_setAssociatedObject(self, @selector(normalBackImageH), [self backgroundImageForState:UIControlStateHighlighted], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    if ([WMNightManager currentStatus] == WMNightStatusNight) {
        [self setBackgroundImage:nightImage forState:UIControlStateHighlighted];
    }
    objc_setAssociatedObject(self, @selector(nightBackImageH), nightImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)nightBackImageS
{
    UIImage *nightImage = objc_getAssociatedObject(self, @selector(nightBackImageS));
    if (nightImage) {
        return nightImage;
    }
    return [self backgroundImageForState:UIControlStateSelected];
}

- (void)setNightBackImageS:(UIImage *)nightImage
{
    if (!objc_getAssociatedObject(self, @selector(normalBackImageS))) {
        objc_setAssociatedObject(self, @selector(normalBackImageS), [self backgroundImageForState:UIControlStateSelected], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    if ([WMNightManager currentStatus] == WMNightStatusNight) {
        [self setBackgroundImage:nightImage forState:UIControlStateSelected];
    }
    objc_setAssociatedObject(self, @selector(nightBackImageS), nightImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)nightBackImageD
{
    UIImage *nightImage = objc_getAssociatedObject(self, @selector(nightBackImageD));
    if (nightImage) {
        return nightImage;
    }
    return [self backgroundImageForState:UIControlStateDisabled];
}

- (void)setNightBackImageD:(UIImage *)nightImage
{
    if (!objc_getAssociatedObject(self, @selector(normalBackImageD))) {
        objc_setAssociatedObject(self, @selector(normalBackImageD), [self backgroundImageForState:UIControlStateDisabled], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    if ([WMNightManager currentStatus] == WMNightStatusNight) {
        [self setBackgroundImage:nightImage forState:UIControlStateDisabled];
    }
    objc_setAssociatedObject(self, @selector(nightBackImageD), nightImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)normalBackImageN
{
    UIImage *normalImage = objc_getAssociatedObject(self, @selector(normalBackImageN));
    if (normalImage) {
        return normalImage;
    }
    return [self backgroundImageForState:UIControlStateNormal];
}

- (void)setNormalBackImageN:(UIImage *)normalImage
{
    if ([WMNightManager currentStatus] == WMNightStatusNormal) {
        [self setBackgroundImage:normalImage forState:UIControlStateNormal];
    }
    objc_setAssociatedObject(self, @selector(normalBackImageN), normalImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)normalBackImageH
{
    UIImage *normalImage = objc_getAssociatedObject(self, @selector(normalBackImageH));
    if (normalImage) {
        return normalImage;
    }
    return [self backgroundImageForState:UIControlStateHighlighted];
}

- (void)setNormalBackImageH:(UIImage *)normalImage
{
    if ([WMNightManager currentStatus] == WMNightStatusNormal) {
        [self setBackgroundImage:normalImage forState:UIControlStateHighlighted];
    }
    objc_setAssociatedObject(self, @selector(normalBackImageH), normalImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)normalBackImageS
{
    UIImage *normalImage = objc_getAssociatedObject(self, @selector(normalBackImageS));
    if (normalImage) {
        return normalImage;
    }
    return [self backgroundImageForState:UIControlStateSelected];
}

- (void)setNormalBackImageS:(UIImage *)normalImage
{
    if ([WMNightManager currentStatus] == WMNightStatusNormal) {
        [self setBackgroundImage:normalImage forState:UIControlStateSelected];
    }
    objc_setAssociatedObject(self, @selector(normalBackImageS), normalImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)normalBackImageD
{
    UIImage *normalImage = objc_getAssociatedObject(self, @selector(normalBackImageD));
    if (normalImage) {
        return normalImage;
    }
    return [self backgroundImageForState:UIControlStateDisabled];
}

- (void)setNormalBackImageD:(UIImage *)normalImage
{
    if ([WMNightManager currentStatus] == WMNightStatusNormal) {
        [self setBackgroundImage:normalImage forState:UIControlStateDisabled];
    }
    objc_setAssociatedObject(self, @selector(normalBackImageD), normalImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - ChangeColor

- (void)changeColorWithDuration:(CGFloat)duration
{
    if ([WMNightManager currentStatus] == WMNightStatusNight) {
        [UIView animateWithDuration:duration animations:^{
            [self setTitleColor:self.nightTColorN forState:UIControlStateNormal];
            [self setTitleColor:self.nightTColorS forState:UIControlStateSelected];
            [self setTitleColor:self.nightTColorH forState:UIControlStateHighlighted];
            [self setTitleColor:self.nightTColorD forState:UIControlStateDisabled];
            
            [self setBackgroundColor:self.nightBackgroundColor];
        }];
        
        [self setImage:self.nightImageN forState:UIControlStateNormal];
        [self setImage:self.nightImageH forState:UIControlStateHighlighted];
        [self setImage:self.nightImageS forState:UIControlStateSelected];
        [self setImage:self.nightImageD forState:UIControlStateDisabled];
        
        [self setBackgroundImage:self.nightBackImageN forState:UIControlStateNormal];
        [self setBackgroundImage:self.nightBackImageH forState:UIControlStateHighlighted];
        [self setBackgroundImage:self.nightBackImageS forState:UIControlStateSelected];
        [self setBackgroundImage:self.nightBackImageD forState:UIControlStateDisabled];
    } else {
        [UIView animateWithDuration:duration animations:^{
            [self setTitleColor:self.normalTColorN forState:UIControlStateNormal];
            [self setTitleColor:self.normalTColorS forState:UIControlStateSelected];
            [self setTitleColor:self.normalTColorH forState:UIControlStateHighlighted];
            [self setTitleColor:self.normalTColorD forState:UIControlStateDisabled];
            
            [self setBackgroundColor:self.normalBackgroundColor];
        }];
        
        [self setImage:self.normalImageN forState:UIControlStateNormal];
        [self setImage:self.normalImageH forState:UIControlStateHighlighted];
        [self setImage:self.normalImageS forState:UIControlStateSelected];
        [self setImage:self.normalImageD forState:UIControlStateDisabled];
        
        [self setBackgroundImage:self.normalBackImageN forState:UIControlStateNormal];
        [self setBackgroundImage:self.normalBackImageH forState:UIControlStateHighlighted];
        [self setBackgroundImage:self.normalBackImageS forState:UIControlStateSelected];
        [self setBackgroundImage:self.normalBackImageD forState:UIControlStateDisabled];
    }
}

- (void)changeColor
{
    if ([WMNightManager currentStatus] == WMNightStatusNight) {
        [self setTitleColor:self.nightTColorN forState:UIControlStateNormal];
        [self setTitleColor:self.nightTColorS forState:UIControlStateSelected];
        [self setTitleColor:self.nightTColorH forState:UIControlStateHighlighted];
        [self setTitleColor:self.nightTColorD forState:UIControlStateDisabled];
        
        [self setBackgroundColor:self.nightBackgroundColor];
        
        [self setImage:self.nightImageN forState:UIControlStateNormal];
        [self setImage:self.nightImageH forState:UIControlStateHighlighted];
        [self setImage:self.nightImageS forState:UIControlStateSelected];
        [self setImage:self.nightImageD forState:UIControlStateDisabled];
        
        [self setBackgroundImage:self.nightBackImageN forState:UIControlStateNormal];
        [self setBackgroundImage:self.nightBackImageH forState:UIControlStateHighlighted];
        [self setBackgroundImage:self.nightBackImageS forState:UIControlStateSelected];
        [self setBackgroundImage:self.nightBackImageD forState:UIControlStateDisabled];
    } else {
        [self setTitleColor:self.normalTColorN forState:UIControlStateNormal];
        [self setTitleColor:self.normalTColorS forState:UIControlStateSelected];
        [self setTitleColor:self.normalTColorH forState:UIControlStateHighlighted];
        [self setTitleColor:self.normalTColorD forState:UIControlStateDisabled];
        
        [self setBackgroundColor:self.normalBackgroundColor];
        
        [self setImage:self.normalImageN forState:UIControlStateNormal];
        [self setImage:self.normalImageH forState:UIControlStateHighlighted];
        [self setImage:self.normalImageS forState:UIControlStateSelected];
        [self setImage:self.normalImageD forState:UIControlStateDisabled];
        
        [self setBackgroundImage:self.normalBackImageN forState:UIControlStateNormal];
        [self setBackgroundImage:self.normalBackImageH forState:UIControlStateHighlighted];
        [self setBackgroundImage:self.normalBackImageS forState:UIControlStateSelected];
        [self setBackgroundImage:self.normalBackImageD forState:UIControlStateDisabled];
    }
}

@end
