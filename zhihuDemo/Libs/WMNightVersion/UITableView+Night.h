//
//  UITableView+Night.h
//
//  Created by zwm on 15/11/25.
//  Copyright (c) 2015年 zwm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Night)

@property (nonatomic, strong) IBInspectable UIColor *nightSeparatorColor;
@property (nonatomic, strong) UIColor *normalSeparatorColor;

- (void)changeColor;
- (void)changeColorWithDuration:(CGFloat)duration;

@end
