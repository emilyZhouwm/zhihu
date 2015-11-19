//
//  UIColor+Night.h
//  zhihuDemo
//
//  Created by zwm on 15/11/18.
//  Copyright © 2015年 zwm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Night)

+ (NSArray *)arrayFromColor:(UIColor *)fromColor
                    ToColor:(UIColor *)toColor
                   duration:(NSTimeInterval)duration
               stepDuration:(NSTimeInterval)stepDuration;

@end
