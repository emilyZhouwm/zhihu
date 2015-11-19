//
//  WMAdPageView.h
//
//  Created by zwm on 15/5/25.
//  Copyright (c) 2015年 zwm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WMAdPageView : UIView

@property (nonatomic, strong) UIScrollView *scView;
@property (nonatomic, assign) NSInteger indexShow;

- (void)setAdsWithImages:(NSArray*)imageArray;

- (void)reloadImages;

@end
