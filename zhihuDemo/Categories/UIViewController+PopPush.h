//
//  UIViewController+PopPush.h
//
//  Created by zwm on 14-8-5.
//  Copyright (c) 2014年 zwm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (PopPush)

- (void)customerPopViewController;
- (void)customerPushViewController:(UIViewController *)aTargetVC;
- (void)zoomPopViewController;
- (void)zoomPushViewController:(UIViewController *)aTargetVC;

@end
