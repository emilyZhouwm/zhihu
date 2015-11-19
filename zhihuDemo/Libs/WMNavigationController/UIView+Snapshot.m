//
//  UIView+Snapshot.m
//
//  Created by zwm on 11/20/14.
//  Copyright (c) 2014 zwm. All rights reserved.
//

#import "UIView+Snapshot.h"

@implementation UIView (Snapshot)

- (UIImage *)snapshot
{
//    BOOL opaque = self.opaque;
//    CGSize size = self.bounds.size;
//    UIGraphicsBeginImageContextWithOptions(size, opaque, [UIScreen mainScreen].scale);
//    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    [self.layer renderInContext:context];
//    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
//    
//    UIGraphicsEndImageContext();
//    
//    return viewImage;
    
    BOOL opaque = self.opaque;
    CGSize size = self.bounds.size;
    UIGraphicsBeginImageContextWithOptions(size, opaque, [UIScreen mainScreen].scale);
    //UIGraphicsBeginImageContext(size);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //[image applyLightEffect];
    
    return image;
}

- (UIImage *)snapshotWithRect:(CGRect)rect
{
    UIGraphicsBeginImageContext(rect.size);
    [self drawViewHierarchyInRect:rect afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
