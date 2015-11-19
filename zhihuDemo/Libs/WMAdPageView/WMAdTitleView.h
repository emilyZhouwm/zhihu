//
//  WMAdTitleView.h
//
//  Created by zwm on 15/6/23.
//  Copyright (c) 2015年 zwm. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kPageControlH 20
#define kAutoRollTime 3

typedef void (^WMAdTitleViewCallback)(NSInteger clickIndex);

@class WMAdPageView;
@interface WMAdTitleView : UIView

@property (assign, nonatomic) BOOL bAutoRoll;
@property (nonatomic, weak) WMAdPageView *adPageView;

- (void)setAdsWithTitles:(NSArray *)titleAry block:(WMAdTitleViewCallback)block;

@end
