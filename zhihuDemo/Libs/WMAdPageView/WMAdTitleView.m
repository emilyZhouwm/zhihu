//
//  WMAdTitleView.m
//
//  Created by zwm on 15/6/23.
//  Copyright (c) 2015年 zwm. All rights reserved.
//

#import "WMAdTitleView.h"
#import "WMDotView.h"
#import "WMAdPageView.h"
#import "TAPageControl.h"

@interface WMAdTitleView () <UIScrollViewDelegate>
@property (nonatomic, copy) NSArray *arrTitle;
@property (nonatomic, assign) NSInteger indexShow;
@property (nonatomic, strong) UIScrollView *scView;
@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic, strong) UILabel *prevLbl;
@property (nonatomic, strong) UILabel *curLbl;
@property (nonatomic, strong) UILabel *nextLbl;

@property (nonatomic, copy) WMAdTitleViewCallback myBlock;
@property (nonatomic, strong) TAPageControl *pageControl;
@property (nonatomic, strong) NSTimer *autoRollTimer;
@end
@implementation WMAdTitleView

- (void)updateConstraints
{
    [super updateConstraints];
    self.scView.contentInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (_scView) {
        [_scView setFrame:self.bounds];
        [_bgView setFrame:self.bounds];

        [self resetLbl];
      
        if (_arrTitle.count <= 1) {
            _scView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
            [_scView setContentOffset:CGPointMake(0, 0) animated:NO];
        } else {
            _scView.contentSize = CGSizeMake(self.frame.size.width * 3, self.frame.size.height);
            [_scView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
        }
        
        [_pageControl setFrame:CGRectMake(0, self.frame.size.height - kPageControlH, self.frame.size.width, kPageControlH)];
        [_pageControl resetDotViews];
    }
}

- (void)initUI
{
    _bgView = [[UIImageView alloc] initWithFrame:self.bounds];
    _bgView.image = [UIImage imageNamed:@"Bg_mengceng"];
    [self addSubview:_bgView];
    
    _scView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scView.delegate = self;
    _scView.pagingEnabled = YES;
    _scView.bounces = NO;
    _scView.showsHorizontalScrollIndicator = NO;
    _scView.showsVerticalScrollIndicator = NO;
    _scView.backgroundColor = [UIColor clearColor];
    [self addSubview:_scView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAds)];
    [_scView addGestureRecognizer:tap];

    _prevLbl = [[UILabel alloc] initWithFrame:CGRectZero];
    _prevLbl.font = [UIFont systemFontOfSize:17];
    _prevLbl.textColor = [UIColor whiteColor];
    _prevLbl.numberOfLines = 2;
   
    _curLbl = [[UILabel alloc] initWithFrame:CGRectZero];
    _curLbl.font = [UIFont systemFontOfSize:17];
    _curLbl.textColor = [UIColor whiteColor];
    _curLbl.numberOfLines = 2;
 
    _nextLbl = [[UILabel alloc] initWithFrame:CGRectZero];
    _nextLbl.font = [UIFont systemFontOfSize:17];
    _nextLbl.textColor = [UIColor whiteColor];
    _nextLbl.numberOfLines = 2;
    
    [_scView addSubview:_prevLbl];
    [_scView addSubview:_curLbl];
    [_scView addSubview:_nextLbl];
    
    _pageControl = [[TAPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height - kPageControlH, self.frame.size.width, kPageControlH)];
    _pageControl.dotViewClass = [WMDotView class];
    _pageControl.dotSize = [WMDotView dotSize];
    [self addSubview:_pageControl];
}

- (void)dealloc
{
    if ([_autoRollTimer isValid]) {
        [_autoRollTimer invalidate];
        _autoRollTimer = nil;
    }
}

- (void)setAdsWithTitles:(NSArray *)titleAry block:(WMAdTitleViewCallback)block
{
    if (!titleAry || titleAry.count<=0) {
        return;
    }
    _arrTitle = titleAry;
    _myBlock = block;
    
    if (!_scView) {
        [self initUI];
    }
    
    if (titleAry.count <= 1) {
        _scView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    } else {
        _scView.contentSize = CGSizeMake(self.frame.size.width * 3, self.frame.size.height);
    }
    
    [self reloadTitles];
    _pageControl.numberOfPages = titleAry.count;
}

- (void)tapAds
{
    if (_myBlock != NULL) {
        _myBlock(_indexShow);
    }
}

- (void)reloadTitles
{
    if (_indexShow >= (int)_arrTitle.count) {
        _indexShow = 0;
    }
    if (_indexShow < 0) {
        _indexShow = (int)_arrTitle.count - 1;
    }
    NSInteger prev = _indexShow - 1;
    if (prev < 0) {
        prev = (int)_arrTitle.count - 1;
    }
    NSInteger next = _indexShow + 1;
    if (next > _arrTitle.count - 1) {
        next = 0;
    }
    
    _pageControl.currentPage = _indexShow;
    NSString *prevStr = [_arrTitle objectAtIndex:prev];
    NSString *curStr = [_arrTitle objectAtIndex:_indexShow];
    NSString *nextStr = [_arrTitle objectAtIndex:next];
    
    _prevLbl.text = prevStr;
    _curLbl.text = curStr;
    _nextLbl.text = nextStr;
    
    [self resetLbl];
    
    [_scView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
}

- (void)resetLbl
{
    CGSize size = [_prevLbl sizeThatFits:CGSizeMake(self.frame.size.width - 30, 100)];
    _prevLbl.frame = CGRectMake(15, self.frame.size.height - size.height - kPageControlH, self.frame.size.width - 30, size.height);
    
    size = [_curLbl sizeThatFits:CGSizeMake(self.frame.size.width - 30, 100)];
    _curLbl.frame = CGRectMake(self.frame.size.width + 15, self.frame.size.height - size.height - kPageControlH, self.frame.size.width - 30, size.height);
    
    size = [_nextLbl sizeThatFits:CGSizeMake(self.frame.size.width - 30, 100)];
    _nextLbl.frame = CGRectMake(self.frame.size.width * 2 + 15, self.frame.size.height - size.height - kPageControlH, self.frame.size.width - 30, size.height);
}

// 定时滚动
- (void)setBAutoRoll:(BOOL)bAutoRoll
{
    _bAutoRoll = bAutoRoll;
    if ([_autoRollTimer isValid]) {
        [_autoRollTimer invalidate];
        _autoRollTimer = nil;
    }
    if (_bAutoRoll) {
        _autoRollTimer = [NSTimer scheduledTimerWithTimeInterval:kAutoRollTime target:self selector:@selector(scrollTimer) userInfo:nil repeats:YES];
    }
}

- (void)scrollTimer
{
    if (_arrTitle.count > 1) {
        [_scView setContentOffset:CGPointMake(self.frame.size.width * 2, 0) animated:YES];
        [_adPageView.scView setContentOffset:CGPointMake(self.frame.size.width * 2, 0) animated:YES];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _adPageView.scView.contentOffset = scrollView.contentOffset;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x >= self.frame.size.width * 2) {
        _indexShow++;
        _adPageView.indexShow++;
    } else if (scrollView.contentOffset.x < self.frame.size.width) {
        _indexShow--;
        _adPageView.indexShow--;
    }
    [self reloadTitles];
    [_adPageView reloadImages];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([_autoRollTimer isValid]) {
        [_autoRollTimer invalidate];
        _autoRollTimer = nil;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (_bAutoRoll) {
        _autoRollTimer = [NSTimer scheduledTimerWithTimeInterval:kAutoRollTime target:self selector:@selector(scrollTimer) userInfo:nil repeats:YES];
    }
    if (scrollView.contentOffset.x >= self.frame.size.width * 2) {
        _indexShow++;
        _adPageView.indexShow++;
    } else if (scrollView.contentOffset.x < self.frame.size.width) {
        _indexShow--;
        _adPageView.indexShow--;
    }
    [self reloadTitles];
    [_adPageView reloadImages];
}

@end
