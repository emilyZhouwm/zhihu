//
//  TADotView.m
//  TAPageControl
//
//  Created by Tanguy Aladenise on 2015-01-22.
//  Copyright (c) 2015 Tanguy Aladenise. All rights reserved.
//

#import "TADotView.h"

@implementation TADotView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialization];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialization];
    }
    
    return self;
}

- (void)initialization
{
    self.backgroundColor    = [UIColor clearColor];
    self.layer.cornerRadius = CGRectGetWidth(self.frame) / 2;
    self.layer.borderColor  = [UIColor whiteColor].CGColor;
    self.layer.borderWidth  = 2;
}

- (void)changeActivityState:(BOOL)active
{
    if (active) {
        self.backgroundColor = [UIColor whiteColor];
    } else {
        self.backgroundColor = [UIColor clearColor];
    }
}

//static CGFloat const kAnimateDuration = 1;
//
//- (void)initialization
//{
//    self.backgroundColor = [UIColor purpleColor];
//}
//
//
//- (void)changeActivityState:(BOOL)active
//{
//    if (active) {
//        [self animateToActiveState];
//    } else {
//        [self animateToDeactiveState];
//    }
//}
//
//
//- (void)animateToActiveState
//{
//    [UIView animateWithDuration:kAnimateDuration delay:0 usingSpringWithDamping:.5 initialSpringVelocity:-20 options:UIViewAnimationOptionCurveLinear animations:^{
//        self.backgroundColor = [UIColor yellowColor];
//        self.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1.4, 1.4), CGAffineTransformMakeRotation(M_PI)) ;
//    } completion:nil];
//}
//
//- (void)animateToDeactiveState
//{
//    self.transform = CGAffineTransformIdentity;
//    
//    [UIView animateWithDuration:kAnimateDuration delay:0 usingSpringWithDamping:.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
//        self.backgroundColor = [UIColor purpleColor];
//    } completion:nil];
//}

@end
