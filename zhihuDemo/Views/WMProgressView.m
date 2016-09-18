//
//  WMProgressView.m
//  zhihuDemo
//
//  Created by zwm on 15/11/19.
//  Copyright © 2015年 zwm. All rights reserved.
//

#import "WMProgressView.h"

#define kLineW 1

@interface WMProgressView ()

@property (nonatomic, strong) CAShapeLayer *backgroundLayer;
@property (nonatomic, strong) CAShapeLayer *progressLayer;

@end

@implementation WMProgressView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initUI];
}

- (void)initUI
{
    if (!_backgroundLayer) {
        _backgroundLayer = [CAShapeLayer layer];
        _backgroundLayer.frame = self.bounds;
        _backgroundLayer.fillColor = nil;
        _backgroundLayer.strokeColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.4].CGColor;
        _backgroundLayer.lineWidth = kLineW;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.center.x - self.frame.origin.x, self.center.y - self.frame.origin.y)
                                                            radius:(self.bounds.size.width - kLineW) / 2
                                                        startAngle:0
                                                          endAngle:M_PI * 2
                                                         clockwise:YES];
        _backgroundLayer.path = path.CGPath;
        [self.layer addSublayer:_backgroundLayer];
    }

    if (!_progressLayer) {
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.frame = self.bounds;
        _progressLayer.fillColor = nil;
        _progressLayer.strokeColor = [UIColor whiteColor].CGColor;
        _progressLayer.lineWidth = kLineW;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.center.x - self.frame.origin.x, self.center.y - self.frame.origin.y)
                                                            radius:(self.bounds.size.width - kLineW) / 2
                                                        startAngle:-M_PI_2
                                                          endAngle:-M_PI_2 + M_PI * 2
                                                         clockwise:YES];
        _progressLayer.path = path.CGPath;
        [self.layer addSublayer:_progressLayer];
    }
}

- (void)setProgress:(CGFloat)progress
{
    if (progress <= 0.0) {
        self.hidden = TRUE;
        return;
    }
    self.hidden = FALSE;

    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    _progressLayer.strokeEnd = progress;
    [CATransaction commit];
}

@end
