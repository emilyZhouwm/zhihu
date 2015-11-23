//
//  WMNightManager.h
//
//  Created by zwm on 15/11/25.
//  Copyright (c) 2015年 zwm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+Night.h"
#import "UILabel+Night.h"
#import "UITableView+Night.h"
#import "UITabBar+Night.h"
#import "UIButton+Night.h"
#import "UIView+Night.h"
#import "UIImageView+Night.h"
#import "UIBarButtonItem+Night.h"
#import "UINavigationBar+Night.h"

typedef enum : NSUInteger {
    WMNightStatusNormal,
    WMNightStatusNight,
} WMNightStatus;

extern NSString *const WMNightFallingNotification;
extern NSString *const WMDawnComingNotification;

extern CGFloat const WMNightAnimationDuration;

@interface WMNightManager : NSObject

+ (WMNightStatus)currentStatus;

+ (void)nightFalling;
+ (void)dawnComing;

+ (void)changeColor:(id)object;
+ (void)changeColor:(id)object withDuration:(CGFloat)duration;
    
@end
