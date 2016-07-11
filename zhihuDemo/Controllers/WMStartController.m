//
//  WMStartController.m
//  zhihuDemo
//
//  Created by zwm on 15/11/20.
//  Copyright © 2015年 zwm. All rights reserved.
//

#import "WMStartController.h"

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface WMStartController ()

@property (weak, nonatomic) IBOutlet UIImageView *startImg;
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;
@property (weak, nonatomic) IBOutlet UILabel *describeLbl;

@end

@implementation WMStartController

+ (void)start
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WMStartController *startVC = [storyboard instantiateViewControllerWithIdentifier:@"WMStartController"];

    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([rootVC isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navVC = (UINavigationController *)rootVC;
        rootVC = navVC.topViewController;
    }
    [rootVC addChildViewController:startVC];
    [rootVC.view addSubview:startVC.view];
    [rootVC.view bringSubviewToFront:startVC.view];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIColor *blackColor = [UIColor blackColor];
    [self addGradientLayerWithColors:@[(id)[blackColor colorWithAlphaComponent:0.4].CGColor, (id)[blackColor colorWithAlphaComponent:0.0].CGColor] locations:nil startPoint:CGPointMake(0.5, 0.0) endPoint:CGPointMake(0.5, 0.4)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self startAnimation];
}

- (void)startAnimation
{
    _startImg.alpha = 0.0;
    [_startImg setFrame:self.view.bounds];
    __weak typeof(self) weakself = self;
    [UIView animateWithDuration:2.0 animations:^{
        weakself.startImg.alpha = 1.0;
        [weakself.startImg setFrame:CGRectMake(-kScreenWidth/20, -kScreenHeight/20, 1.1*kScreenWidth, 1.1*kScreenHeight)];
    } completion:^(BOOL finished) {
        weakself.view.backgroundColor = [UIColor clearColor];
        [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            weakself.startImg.alpha = 0.0;
            weakself.iconImg.alpha = 0.0;
            weakself.describeLbl.alpha = 0.0;
            weakself.view.alpha = 0.0;
        } completion:^(BOOL finished) {
            [weakself.view removeFromSuperview];
            [weakself removeFromParentViewController];

//            id navVC = [self.storyboard instantiateViewControllerWithIdentifier:@"WMNavigationController"];
//            [UIApplication sharedApplication].keyWindow.rootViewController = navVC;
        }];
    }];
}

- (void)addGradientLayerWithColors:(NSArray *)cgColorArray
                         locations:(NSArray *)floatNumArray
                        startPoint:(CGPoint)startPoint
                          endPoint:(CGPoint)endPoint
{
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = self.view.bounds;
    if (cgColorArray && [cgColorArray count] > 0) {
        layer.colors = cgColorArray;
    } else {
        return;
    }
    if (floatNumArray && [floatNumArray count] == [cgColorArray count]) {
        layer.locations = floatNumArray;
    }
    layer.startPoint = startPoint;
    layer.endPoint = endPoint;
    [self.view.layer addSublayer:layer];
}

@end
