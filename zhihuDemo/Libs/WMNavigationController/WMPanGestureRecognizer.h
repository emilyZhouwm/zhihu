//
//  WMPanGestureRecognizer.h
//
//  Created by zwm on 5/30/14.
//
//

#import <UIKit/UIKit.h>

@interface WMPanGestureRecognizer : UIPanGestureRecognizer
@property (readonly, nonatomic) UIEvent *event;
- (CGPoint)beganLocationInView:(UIView *)view;
@end
