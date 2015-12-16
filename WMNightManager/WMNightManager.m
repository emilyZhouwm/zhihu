//
//  WMNightManager.m
//
//  Created by zwm on 15/11/25.
//  Copyright (c) 2015年 zwm. All rights reserved.
//

#import "WMNightManager.h"

NSString *const WMNightFallingNotification = @"WMNightFallingNotification";
NSString *const WMDawnComingNotification = @"WMDawnComingNotification";

CGFloat const WMNightAnimationDuration = 0.3f;

@protocol WMNightChangeColorProtocol <NSObject>

- (void)changeColor;
- (void)changeColorWithDuration:(CGFloat)duration;
- (NSArray *)subviews;

@end

@interface WMNightManager ()

@property (nonatomic, assign) WMNightStatus nightStatus;

@end

@implementation WMNightManager

+ (WMNightManager *)sharedInstance
{
    static dispatch_once_t once;
    static WMNightManager *instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

+ (void)nightFalling
{
    self.sharedInstance.nightStatus = WMNightStatusNight;
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

+ (void)dawnComing
{
    self.sharedInstance.nightStatus = WMNightStatusNormal;
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

+ (WMNightStatus)currentStatus
{
    return self.sharedInstance.nightStatus;
}

- (void)setNightStatus:(WMNightStatus)nightStatus
{
    if (_nightStatus == nightStatus) {
        return;
    }
    _nightStatus = nightStatus;
    //UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //[self.class changeColor:window.subviews.lastObject withDuration:WMNightAnimationDuration];
    if (nightStatus == WMNightStatusNight) {
        [[NSNotificationCenter defaultCenter] postNotificationName:WMNightFallingNotification object:nil];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:WMDawnComingNotification object:nil];
    }
}

+ (void)changeColor:(id <WMNightChangeColorProtocol>)object
{
    if ([object respondsToSelector:@selector(changeColor)]) {
        [object changeColor];
    }
    if ([object respondsToSelector:@selector(subviews)]) {
        if (![object subviews]) {
            return;
        } else {
            for (id subview in [object subviews]) {
                [self changeColor:subview];
                if ([subview respondsToSelector:@selector(changeColor)]) {
                    [subview changeColor];
                }
            }
        }
    }
}

+ (void)changeColor:(id <WMNightChangeColorProtocol>)object withDuration:(CGFloat)duration
{
    if ([object respondsToSelector:@selector(changeColorWithDuration:)]) {
        [object changeColorWithDuration:duration];
    }
    if ([object respondsToSelector:@selector(subviews)]) {
        if (![object subviews]) {
            return;
        } else {
            for (id subview in [object subviews]) {
                [self changeColor:subview withDuration:duration];
                if ([subview respondsToSelector:@selector(changeColorWithDuration:)]) {
                    [subview changeColorWithDuration:duration];
                }
            }
        }
    }
}

@end
