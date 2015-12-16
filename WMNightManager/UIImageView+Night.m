//
//  UIImageView+Night.m
//
//  Created by zwm on 15/11/25.
//  Copyright (c) 2015年 zwm. All rights reserved.
//

#import "UIImageView+Night.h"
#import "WMNightManager.h"
#import <objc/runtime.h>

@implementation UIImageView (Night)

- (UIImage *)nightImage
{
    UIImage *night = objc_getAssociatedObject(self, @selector(nightImage));
    if (night) {
        return night;
    }
    return self.image;
}

- (void)setNightImage:(UIImage *)nightImage
{
    if (!objc_getAssociatedObject(self, @selector(normalImage))) {
        objc_setAssociatedObject(self, @selector(normalImage), self.image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    if ([WMNightManager currentStatus] == WMNightStatusNight) {
        [self setImage:nightImage];
    }
    objc_setAssociatedObject(self, @selector(nightImage), nightImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)normalImage
{
    UIImage *normal = objc_getAssociatedObject(self, @selector(normalImage));
    if (normal) {
        return normal;
    }
    return self.image;
}

- (void)setNormalImage:(UIImage *)normalImage
{
    if ([WMNightManager currentStatus] == WMNightStatusNormal) {
        [self setImage:normalImage];
    }
    objc_setAssociatedObject(self, @selector(normalImage), normalImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)changeColor
{
    UIImage *image = ([WMNightManager currentStatus] == WMNightStatusNight) ? self.nightImage : self.normalImage;
    if (image != self.image) {
        [self setImage:image];
    }
}

- (void)changeColorWithDuration:(CGFloat)duration
{
    [self changeColor];
}

@end
