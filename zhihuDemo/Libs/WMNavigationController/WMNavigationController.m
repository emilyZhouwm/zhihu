//
//  WMNavigationController.m
//
//  Created by ZWM on 11/20/14.
//
//

#import "WMNavigationController.h"
#import "WMPanGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>
#import "UIView+Snapshot.h"

#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

@interface WMNavigationController ()<UIGestureRecognizerDelegate>
@property (strong, nonatomic) WMPanGestureRecognizer *pan;
@property (readonly, nonatomic) UIView *controllerWrapperView;
@end

@implementation WMNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (SYSTEM_VERSION >= 7) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    _pan = [[WMPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    _pan.delegate = self;
    _pan.maximumNumberOfTouches = 1;
    [self.view addGestureRecognizer:_pan];
}

- (void)pan:(UIPanGestureRecognizer *)pan
{
    UIGestureRecognizerState state = pan.state;
    switch (state) {
        case UIGestureRecognizerStateBegan:
        {
            CGFloat width = self.view.frame.size.width;
            CGPoint touchPoint = [self.pan beganLocationInView:self.controllerWrapperView];
            if (touchPoint.x <= 220) {
                // 右滑
                [self popCurrentViewOut:pan];
            } else if (touchPoint.x >= width - 220) {
                // 左滑
                [self pushNewViewIn:pan];
          }
        } break;
        case UIGestureRecognizerStateChanged:
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
            break;
        default:break;
    }
}

- (void)pushNewViewIn:(UIGestureRecognizer *)gestureRecognizer
{
    if ([self.visibleViewController respondsToSelector:@selector(viewControllerToPush)]) {
        UIViewController<WMNavigationDelegate> *vc = (UIViewController<WMNavigationDelegate> *)self.visibleViewController;
        UIViewController *newViewController = [vc viewControllerToPush];
        if (newViewController != nil) {
            [self pushViewController:newViewController animated:YES];
        }
    }
}

- (void)popCurrentViewOut:(UIGestureRecognizer *)gestureRecognizer
{
    if ([self.visibleViewController respondsToSelector:@selector(viewControllerToPop)]) {
        UIViewController<WMNavigationDelegate> *vc = (UIViewController<WMNavigationDelegate> *)self.visibleViewController;
        BOOL isPop = [vc viewControllerToPop];
        if (isPop) {
            [self popViewControllerAnimated:YES];
        }
    }
}

#pragma mark - GestureRecognizer Delegate

#define MIN_TAN_VALUE tan(M_PI/6)

- (UIView *)controllerWrapperView
{
    return self.visibleViewController.view.superview;
}

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
    if (![self enablePanBack]) return NO; // 询问当前viewconroller 是否允许右滑返回
    
    BOOL succeed = NO;
    CGFloat width = self.view.frame.size.width;
    CGPoint touchPoint = [gestureRecognizer locationInView:self.controllerWrapperView];
    if (touchPoint.x <= 220) {
        // 右滑
        if (self.viewControllers.count < 2) return NO;
        
        if (touchPoint.x < 0 || touchPoint.y < 10 || touchPoint.x > 220) return NO;
        
        CGPoint translation = [gestureRecognizer translationInView:self.view];
        if (translation.x <= 0) return NO;
        
        // 是否是右滑
        succeed = fabs(translation.y / translation.x) < MIN_TAN_VALUE;
    } else if (touchPoint.x >= width - 220) {
        // 左滑
        if (touchPoint.x > width || touchPoint.y < 10 || touchPoint.x < width - 220) return NO;
        
        CGPoint translation = [gestureRecognizer translationInView:self.view];
        if (translation.x > 0) return NO;// 检查X正负
        
        // 是否是左滑
        succeed = fabs(translation.y / translation.x) < MIN_TAN_VALUE;
    }
    return succeed;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if (gestureRecognizer != self.pan) return NO;
    if (self.pan.state != UIGestureRecognizerStateBegan) return NO;
    
    if (otherGestureRecognizer.state != UIGestureRecognizerStateBegan) {
        return YES;
    }
    
    CGFloat width = self.view.frame.size.width;
    CGPoint touchPoint = [self.pan beganLocationInView:self.controllerWrapperView];
    if (touchPoint.x <= 220) {
        // 右滑
        // 点击区域判断 如果在左边 30 以内, 强制手势后退
        if (touchPoint.x < 30) {
            [self cancelOtherGestureRecognizer:otherGestureRecognizer];
            return YES;
        }
        
        // 如果是scrollview 判断scrollview contentOffset 是否为0，是 cancel scrollview 的手势，否cancel自己
        if ([[otherGestureRecognizer view] isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *)[otherGestureRecognizer view];
            if (scrollView.contentOffset.x <= 0) {
                [self cancelOtherGestureRecognizer:otherGestureRecognizer];
                return YES;
            }
        }
    } else if (touchPoint.x >= width - 220) {
        // 左滑
        // 点击区域判断 如果在右边边 30 以内, 强制手势后退
//        if (touchPoint.x > width - 30) {
//            [self cancelOtherGestureRecognizer:otherGestureRecognizer];
//            return YES;
//        }
        
        // 如果是scrollview 判断scrollview contentOffset 是否为最后一页，是 cancel scrollview 的手势，否cancel自己
        if ([[otherGestureRecognizer view] isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *)[otherGestureRecognizer view];
            if (scrollView.contentOffset.x + width >= scrollView.contentSize.width) {// 只有一页内容的情况呢
                [self cancelOtherGestureRecognizer:otherGestureRecognizer];
                return YES;
            }
        }
    }
  
    return NO;
}

- (void)cancelOtherGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    NSSet *touchs = [self.pan.event touchesForGestureRecognizer:otherGestureRecognizer];
    [otherGestureRecognizer touchesCancelled:touchs withEvent:self.pan.event];
}

- (UIPanGestureRecognizer *)panGestureRecognizer
{
    return self.pan;
}

#pragma mark - WMNavigationDelegate

- (BOOL)enablePanBack
{
    BOOL enable = YES;
    if ([self.visibleViewController respondsToSelector:@selector(enablePanBack:)]) {
        UIViewController<WMNavigationDelegate> *vc = (UIViewController<WMNavigationDelegate> *)self.visibleViewController;
        enable = [vc enablePanBack:self];
    }
    return enable;
}

- (void)startPanBack
{
    if ([self.visibleViewController respondsToSelector:@selector(startPanBack:)]) {
        UIViewController<WMNavigationDelegate> *vc = (UIViewController<WMNavigationDelegate> *)self.visibleViewController;
        [vc startPanBack:self];
    }
}

- (void)finshPanBack
{
    if ([self.visibleViewController respondsToSelector:@selector(finshPanBack:)]) {
        UIViewController<WMNavigationDelegate> *vc = (UIViewController<WMNavigationDelegate> *)self.visibleViewController;
        [vc finshPanBack:self];
    }
}

- (void)resetPanBack
{
    if ([self.visibleViewController respondsToSelector:@selector(resetPanBack:)]) {
        UIViewController<WMNavigationDelegate> *vc = (UIViewController<WMNavigationDelegate> *)self.visibleViewController;
        [vc resetPanBack:self];
    }
}

@end
