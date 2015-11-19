//
//  WMAdPageView.m
//
//  Created by zwm on 15/5/25.
//  Copyright (c) 2015年 zwm. All rights reserved.
//

#import "WMAdPageView.h"
#import "UIImageView+WebCache.h"

@interface WMAdPageView() <UIScrollViewDelegate>
@property (nonatomic, copy) NSArray *arrImage;
@property (nonatomic, strong) UIImageView *imgPrev;
@property (nonatomic, strong) UIImageView *imgCurrent;
@property (nonatomic, strong) UIImageView *imgNext;
@end

@implementation WMAdPageView

- (void)updateConstraints
{
    [super updateConstraints];
    self.scView.contentInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (_scView) {
        self.scView.contentInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
        [_scView setFrame:self.bounds];

        [_imgPrev setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [_imgCurrent setFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        [_imgNext setFrame:CGRectMake(2 * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        
        if (_arrImage.count <= 1) {
            _scView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
            [_scView setContentOffset:CGPointMake(0, 0) animated:NO];
        } else {
            _scView.contentSize = CGSizeMake(self.frame.size.width * 3, self.frame.size.height);
            [_scView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
        }
    }
}

- (void)initUI
{
    _scView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scView.delegate = self;
    _scView.pagingEnabled = YES;
    _scView.bounces = NO;
    _scView.showsHorizontalScrollIndicator = NO;
    _scView.showsVerticalScrollIndicator = NO;
    [self addSubview:_scView];
    
    _imgPrev = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _imgCurrent = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
    _imgNext = [[UIImageView alloc] initWithFrame:CGRectMake(2 * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
    
    [_scView addSubview:_imgPrev];
    [_scView addSubview:_imgCurrent];
    [_scView addSubview:_imgNext];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}

- (void)setAdsWithImages:(NSArray *)imageArray
{
    if (!imageArray || imageArray.count<=0) {
        return;
    }
    _arrImage = imageArray;
    
    if (!_scView) {
        [self initUI];
    }
    
    if (imageArray.count <= 1) {
        _scView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    } else {
        _scView.contentSize = CGSizeMake(self.frame.size.width * 3, self.frame.size.height);
    }
    
    [self reloadImages];
}

- (void)reloadImages
{
    if (_indexShow >= (int)_arrImage.count) {
        _indexShow = 0;
    }
    if (_indexShow < 0) {
        _indexShow = (int)_arrImage.count - 1;
    }
    NSInteger prev = _indexShow - 1;
    if (prev < 0) {
        prev = (int)_arrImage.count - 1;
    }
    NSInteger next = _indexShow + 1;
    if (next > _arrImage.count - 1) {
        next = 0;
    }
    
    NSString *prevImage = [_arrImage objectAtIndex:prev];
    NSString *curImage = [_arrImage objectAtIndex:_indexShow];
    NSString *nextImage = [_arrImage objectAtIndex:next];
    
    [_imgPrev sd_setImageWithURL:[NSURL URLWithString:prevImage]];
    [_imgCurrent sd_setImageWithURL:[NSURL URLWithString:curImage]];
    [_imgNext sd_setImageWithURL:[NSURL URLWithString:nextImage]];

    [_scView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
}

@end
