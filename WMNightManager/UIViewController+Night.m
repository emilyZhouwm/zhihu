//
//  UIViewController+Night.m
//
//  Created by zwm on 15/11/25.
//  Copyright (c) 2015年 zwm. All rights reserved.
//

#import "UIViewController+Night.h"
#import "WMNightManager.h"
#import "UIBarButtonItem+Night.h"
#import <objc/runtime.h>

@implementation UIViewController (Night)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        SEL originalSelector = @selector(viewDidLoad);
        SEL swizzledSelector = @selector(hook_viewDidLoad);
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        BOOL didAddMethod =
        class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (didAddMethod){
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }

        originalSelector = @selector(viewWillAppear:);
        swizzledSelector = @selector(hook_viewWillAppear:);
        originalMethod = class_getInstanceMethod(class, originalSelector);
        swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        didAddMethod =
        class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (didAddMethod){
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)hook_viewDidLoad
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor) name:WMNightFallingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor) name:WMDawnComingNotification object:nil];
    [self hook_viewDidLoad];
}

- (void)hook_viewWillAppear:(BOOL)animated
{
    [self hook_viewWillAppear:animated];
    [self changeColor];
}

- (void)changeColor
{
    [WMNightManager changeColor:self.view withDuration:WMNightAnimationDuration];
    [self.navigationItem.leftBarButtonItem changeColor];
    [self.navigationItem.rightBarButtonItem changeColor];
    [self.navigationItem.backBarButtonItem changeColor];
}

@end
