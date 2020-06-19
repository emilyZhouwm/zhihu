//
//  UIColor+Night.m
//
//  Created by zwm on 15/11/18.
//  Copyright © 2015年 zwm. All rights reserved.
//

#import "UIColor+Night.h"

@implementation UIColor (Night)

+ (NSArray *)arrayFromColor:(UIColor *)fromColor
                    ToColor:(UIColor *)toColor
                   duration:(NSTimeInterval)duration
               stepDuration:(NSTimeInterval)stepDuration
{
    if (!fromColor || !toColor) {
        return nil;
    }

    UIColor *tempColor = fromColor;
    NSUInteger steps = duration / stepDuration;
    
    CGFloat fromRed, fromGreen, fromBlue, fromAlpha;
    CGFloat toRed, toGreen, toBlue, toAlpha;
    
    [tempColor getRed:&fromRed green:&fromGreen blue:&fromBlue alpha:&fromAlpha];
    [toColor getRed:&toRed green:&toGreen blue:&toBlue alpha:&toAlpha];
    
    CGFloat diffRed = toRed - fromRed;
    CGFloat diffGreen = toGreen - fromGreen;
    CGFloat diffBlue = toBlue - fromBlue;
    CGFloat diffAlpha = toAlpha - fromAlpha;
    
    NSMutableArray *colorArray = [NSMutableArray array];
    
    [colorArray addObject:tempColor];
    
    for (NSUInteger i = 0; i < steps - 1; ++i) {
        CGFloat red = fromRed + diffRed / steps * (i + 1);
        CGFloat green = fromGreen + diffGreen / steps * (i + 1);
        CGFloat blue = fromBlue + diffBlue / steps * (i + 1);
        CGFloat alpha = fromAlpha + diffAlpha / steps * (i + 1);
        
        UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
        [colorArray addObject:color];
    }
    
    [colorArray addObject:toColor];
    return colorArray;
}

@end
