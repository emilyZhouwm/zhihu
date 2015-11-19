//
//  UIImageView+Night.h
//
//  Created by zwm on 15/11/25.
//  Copyright (c) 2015年 zwm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Night)

@property (nonatomic, strong) IBInspectable UIImage *nightImage;
@property (nonatomic, strong) UIImage *normalImage;

- (void)changeColor;
- (void)changeColorWithDuration:(CGFloat)duration;

@end
