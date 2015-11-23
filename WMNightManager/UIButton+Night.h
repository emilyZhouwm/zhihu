//
//  UIButton+Night.h
//
//  Created by zwm on 15/11/25.
//  Copyright (c) 2015年 zwm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Night)

@property (nonatomic, strong) IBInspectable UIColor *nightTColorN;
@property (nonatomic, strong) IBInspectable UIColor *nightTColorH;
@property (nonatomic, strong) IBInspectable UIColor *nightTColorS;
@property (nonatomic, strong) IBInspectable UIColor *nightTColorD;

@property (nonatomic, strong) IBInspectable UIImage *nightImageN;
@property (nonatomic, strong) IBInspectable UIImage *nightImageH;
@property (nonatomic, strong) IBInspectable UIImage *nightImageS;
@property (nonatomic, strong) IBInspectable UIImage *nightImageD;

@property (nonatomic, strong) IBInspectable UIImage *nightBackImageN;
@property (nonatomic, strong) IBInspectable UIImage *nightBackImageH;
@property (nonatomic, strong) IBInspectable UIImage *nightBackImageS;
@property (nonatomic, strong) IBInspectable UIImage *nightBackImageD;

@property (nonatomic, strong) UIColor *normalTColorN;
@property (nonatomic, strong) UIColor *normalTColorH;
@property (nonatomic, strong) UIColor *normalTColorS;
@property (nonatomic, strong) UIColor *normalTColorD;

@property (nonatomic, strong) UIImage *normalImageN;
@property (nonatomic, strong) UIImage *normalImageH;
@property (nonatomic, strong) UIImage *normalImageS;
@property (nonatomic, strong) UIImage *normalImageD;

@property (nonatomic, strong) UIImage *normalBackImageN;
@property (nonatomic, strong) UIImage *normalBackImageH;
@property (nonatomic, strong) UIImage *normalBackImageS;
@property (nonatomic, strong) UIImage *normalBackImageD;

- (void)changeColor;
- (void)changeColorWithDuration:(CGFloat)duration;

@end
