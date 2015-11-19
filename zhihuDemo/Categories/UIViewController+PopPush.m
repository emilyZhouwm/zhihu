//
//  UIViewController+zz.m
//
//  Created by zwm on 14-8-5.
//  Copyright (c) 2014年 zwm. All rights reserved.
//

#import "UIViewController+PopPush.h"
#import "UINavigationController+Transition.h"

#define  DefaultPushTime        0.4
#define  DefaultPopTime         0.3
#define  zoomPushTime           0.4
#define  zoomPopTime            0.3

@implementation UIViewController (PopPush)

- (void)customerPopViewController
{
    [self.navigationController popViewControllerWithDuration:DefaultPopTime
                                                           prelayouts:^(UIView *fromView, UIView *toView) {
                                                           }
                                                           animations:^(UIView *fromView, UIView *toView) {
                                                               fromView.alpha = 0.0f;
                                                           }
                                                           completion:nil];
}

- (void)customerPushViewController:(UIViewController *)aTargetVC
{
    [self.navigationController pushViewController:aTargetVC
                                                  duration:DefaultPushTime
                                                prelayouts:^(UIView *fromView, UIView *toView) {
                                                    toView.alpha = 0.0f;
                                                }
                                                animations:^(UIView *fromView, UIView *toView) {
                                                    toView.alpha = 1.0f;
                                                }
                                                completion:^(UIView *fromView, UIView *toView) {
                                                }];
}

- (void)zoomPopViewController
{
    [self.navigationController popViewControllerWithDuration:zoomPopTime
                                                  prelayouts:^(UIView *fromView, UIView *toView) {
                                                      toView.transform = CGAffineTransformMakeScale(.7, .7);
                                                  }
                                                  animations:^(UIView *fromView, UIView *toView) {
                                                      toView.transform = CGAffineTransformMakeScale(1, 1);
                                                      fromView.frame = CGRectMake(toView.frame.size.width,
                                                                                  0,
                                                                                  fromView.frame.size.width,
                                                                                  fromView.frame.size.height);
                                                  }
                                                  completion:nil];
}

- (void)zoomPushViewController:(UIViewController *)aTargetVC
{
    [self.navigationController pushViewController:aTargetVC
                                         duration:zoomPushTime
                                       prelayouts:^(UIView *fromView, UIView *toView) {
                                           toView.frame = CGRectMake(toView.frame.size.width,
                                                                     0,
                                                                     toView.frame.size.width,
                                                                     toView.frame.size.height);
                                       }
                                       animations:^(UIView *fromView, UIView *toView) {
                                           toView.frame = CGRectMake(0, 0,
                                                                     toView.frame.size.width,
                                                                     toView.frame.size.height);
                                           
                                           fromView.transform = CGAffineTransformMakeScale(.7, .7);
                                       }
                                       completion:^(UIView *fromView, UIView *toView) {
                                           fromView.transform = CGAffineTransformMakeScale(1, 1);
                                       }];
}

@end
