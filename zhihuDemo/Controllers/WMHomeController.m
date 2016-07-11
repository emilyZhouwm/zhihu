//
//  ViewController.m
//  zhihuDemo
//
//  Created by zwm on 15/6/19.
//  Copyright (c) 2015年 zwm. All rights reserved.
//

#import "WMHomeController.h"
#import "WMAdPageView.h"
#import "WMAdTitleView.h"
#import "WMNews.h"
#import "WMNetManager.h"
#import "WMHomeCell.h"
#import "UIViewController+PopPush.h"
#import "WMDetailController.h"
#import "UIColor+Night.h"
#import "MJRefresh.h"
#import "FBKVOController.h"
#import "WMProgressView.h"

#define kScreen_Width [UIScreen mainScreen].bounds.size.width
#define kDayR (1/255.0)
#define kDayG (131/255.0)
#define kDayB (209/255.0)
#define kNightR 0.5
#define kNightG 0.5
#define kNightB 0.5

#define kDayColor [UIColor whiteColor]
#define kNightColor [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1]

@interface WMHomeController ()
{
    FBKVOController *_kvo;

    CGFloat _HomeR;
    CGFloat _HomeG;
    CGFloat _HomeB;

    CGFloat _HeadHeight;
    CGFloat _HeadTop;
    CGFloat _alpha;
    CGFloat _alphaCur;
    BOOL _isNeting;

    WMHomeCell *_homeCell;
    CGRect _tempRect;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet WMAdPageView *adPageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headTopLayout;
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UIImageView *mengImage;
@property (weak, nonatomic) IBOutlet WMProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;

@property (strong, nonatomic) WMAdTitleView *adTitleView;

@end

@implementation WMHomeController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"今日要闻";

    UIButton *nightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [nightBtn setImage:[UIImage imageNamed:@"Menu_Dark"] forState:UIControlStateNormal];
    nightBtn.nightImageN = [UIImage imageNamed:@"Dark_Menu_Day"];
    [nightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 14, 0, -14)];
    [nightBtn addTarget:self action:@selector(nightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:nightBtn];

    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:kDayColor, NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];

    _HomeR = kDayR;
    _HomeG = kDayG;
    _HomeB = kDayB;
    _HeadHeight = 100 * kScreen_Width / 180;
    _HeadTop = -(kScreen_Width - _HeadHeight) * 0.5;
    _headTopLayout.constant = _HeadTop;
    _headView.backgroundColor = [UIColor colorWithRed:kDayR green:kDayG blue:kDayB alpha:1];
    _headView.nightBackgroundColor = [UIColor colorWithRed:kNightR green:kNightG blue:kNightB alpha:1];

    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, _HeadHeight - 40)];
    _tableView.tableHeaderView.backgroundColor = [UIColor clearColor];

    _adTitleView = [[WMAdTitleView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, _HeadHeight)];
    _adTitleView.backgroundColor = [UIColor clearColor];
    [_tableView.tableHeaderView addSubview:_adTitleView];

    MJRefreshHeader *header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestHome)];
    _tableView.mj_header = header;

    __weak typeof(self) weakself = self;
    _kvo = [FBKVOController controllerWithObserver:self];
    [_kvo observe:header keyPath:@"pullingPercent" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
        CGFloat percent = [change[NSKeyValueChangeNewKey] floatValue];
        [weakself.progressView setProgress:percent];
    }];

    [[WMZhihu sharedInstance] load];
    [self requestHome];
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    self.tableView.contentInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
    [self.adPageView updateConstraints];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_homeCell) {
        _homeCell.iconView.frame = _tempRect;
        [_homeCell.iconView setNeedsLayout];
        [UIView animateWithDuration:0.3f animations:^{
            [_homeCell.iconView layoutIfNeeded];
        } completion:^(BOOL finished) {
            _homeCell = nil;
            [_tableView reloadData];
        }];
    } else {
        [_tableView reloadData];
    }
}

- (void)requestHome
{
    [_progressView setProgress:0];
    [_tableView.mj_header endRefreshing];
    if ([_activityView isAnimating]) {
        return;
    }
    [_activityView startAnimating];
    __weak typeof(self) weakself = self;
    [WMNetManager requestHomeWithBlock:^(id data, NSError *error) {
        [weakself.activityView stopAnimating];
        if (data && [data isKindOfClass:[WMNews class]]) {
            if ([WMZhihu sharedInstance].newsAry.count > 0) {
                WMNews *tempNews = [WMZhihu sharedInstance].newsAry[0];
                if ([tempNews.date isEqualToDate:((WMNews *)data).date]) {
                    [[WMZhihu sharedInstance].newsAry replaceObjectAtIndex:0 withObject:data];
                } else {
                    [[WMZhihu sharedInstance].newsAry removeAllObjects];
                    [[WMZhihu sharedInstance].newsAry addObject:data];
                }
            } else {
                [[WMZhihu sharedInstance].newsAry addObject:data];
            }
            [weakself.tableView reloadData];
            [weakself.adPageView setAdsWithImages:[(WMNews *) data topImgUrl]];
            weakself.adTitleView.adPageView = weakself.adPageView;
            [weakself.adTitleView setAdsWithTitles:[(WMNews *) data topTitle] block:^(NSInteger clickIndex) {

                WMDetailController *nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"WMDetailController"];

                nextVC.indexPath = [[WMZhihu sharedInstance] findWithID:clickIndex];
                nextVC.startRect = CGRectZero;

                [weakself.navigationController pushViewController:nextVC animated:YES];
            }];
            weakself.adTitleView.bAutoRoll = TRUE;

            if ([WMZhihu sharedInstance].newsAry.count < 2) {
                [weakself requestStories];
            }
        }
    }];
}

- (void)requestStories
{
    if (_isNeting || [WMZhihu sharedInstance].newsAry.count <= 0) {
        return;
    }
    _isNeting = TRUE;
    WMNews *tempNews = [WMZhihu sharedInstance].newsAry[[WMZhihu sharedInstance].newsAry.count - 1];
    __weak typeof(self) weakself = self;
    [WMNetManager requestStories:[tempNews nextDate]
                        andBlock:^(id data, NSError *error) {
        if (data && [data isKindOfClass:[WMNews class]]) {
            [[WMZhihu sharedInstance].newsAry addObject:data];
            [weakself.tableView reloadData];
            _isNeting = FALSE;
        }
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [WMZhihu sharedInstance].newsAry.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    WMNews *tempNews = [WMZhihu sharedInstance].newsAry[section];
    return tempNews.stories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WMHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WMHomeCell"];

    WMNews *tempNews = [WMZhihu sharedInstance].newsAry[indexPath.section];
    WMStories *tempStories = tempNews.stories[indexPath.row];
    [cell setStories:tempStories];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [WMHomeCell cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *cellHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, tableView.frame.size.width, 30)];

    WMNews *tempNews = [WMZhihu sharedInstance].newsAry[section];
    titleLbl.text = (section == 0 ? @"今日要闻" : tempNews.dateStr);
    titleLbl.font = [UIFont systemFontOfSize:16];
    titleLbl.textAlignment = NSTextAlignmentCenter;

    if (section == 0) {
        cellHead.backgroundColor = [UIColor clearColor];
        cellHead.nightBackgroundColor = [UIColor clearColor];
        titleLbl.textColor = [UIColor clearColor];
        titleLbl.nightTextColor = [UIColor clearColor];
    } else {
        cellHead.backgroundColor = [UIColor colorWithRed:kDayR green:kDayG blue:kDayB alpha:1];
        cellHead.nightBackgroundColor = _headView.nightBackgroundColor;
        titleLbl.textColor = kDayColor;
        titleLbl.nightTextColor = kNightColor;
    }

    [cellHead addSubview:titleLbl];
    return cellHead;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    _homeCell = (WMHomeCell *)[tableView cellForRowAtIndexPath:indexPath];
    CGRect startRect = [_homeCell convertRect:_homeCell.iconView.frame toView:nil];

    _tempRect = [_homeCell convertRect:CGRectMake((self.view.frame.size.width - 160) * 0.5f, 0, 160, 160) fromView:nil];
    [UIView animateWithDuration:0.3f animations:^{
        _homeCell.iconView.frame = _tempRect;
    } completion:^(BOOL finished) {
    }];

    WMDetailController *nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"WMDetailController"];

    nextVC.indexPath = indexPath;
    nextVC.startRect = startRect;

    //[self.navigationController pushViewController:nextVC animated:YES];
    [self customerPushViewController:nextVC];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y <= 0) {
        CGFloat offset = _HeadTop - scrollView.contentOffset.y * 0.5f;
        if (_headTopLayout.constant != offset) {
            if (_headTopLayout.constant - offset > 5 || _headTopLayout.constant - offset < -5) {
                _headTopLayout.constant = offset;
                [_adPageView setNeedsLayout];
                [UIView animateWithDuration:0.25 animations:^{
                    [_adPageView layoutIfNeeded];
                }];
            } else {
                _headTopLayout.constant = offset;
            }
        }
    } else {
        [_progressView setProgress:0];
        if (scrollView.contentOffset.y > _HeadHeight - 40) {
            _adPageView.hidden = TRUE;

            if (_alpha < 1) {
                _alpha = 1;
                [self changeNav];
            }

            NSArray *cellIndex = [self.tableView indexPathsForVisibleRows];
            if (!cellIndex || cellIndex.count <= 0) {
                return;
            }
            NSIndexPath *indexPath = cellIndex[0];
            if (indexPath.section + 1 == [WMZhihu sharedInstance].newsAry.count) {
                [self requestStories];
            }
            if (indexPath.section <= 1) {
                WMNews *tempNews = [WMZhihu sharedInstance].newsAry[indexPath.section];
                self.navigationItem.title = (indexPath.section == 0 ? @"今日要闻" : tempNews.dateStr);
                if (indexPath.section == 1) {
                    self.navigationItem.title = @"";
                    [self hideNav];
                } else {
                    [self showNav];
                }
            } else {
                [self hideNav];
            }
        } else {
            _adPageView.hidden = FALSE;
            //_headTopLayout.constant = _HeadTop - scrollView.contentOffset.y * 0.5f;

            _alpha = scrollView.contentOffset.y / (_HeadHeight - 40);
            [self changeNav];
        }
    }
}

- (void)hideNav
{
    if (_headView.hidden) {
        _headView.hidden = FALSE;
        _mengImage.hidden = TRUE;
    }
}

- (void)showNav
{
    if (!_headView.hidden) {
        _headView.hidden = TRUE;
        _mengImage.hidden = FALSE;
        UIImage *image = [self imageWithColor:[UIColor colorWithRed:_HomeR green:_HomeG blue:_HomeB alpha:_alpha]];
        [_mengImage setImage:image];
    }
}

- (void)changeNav
{
    if (_alpha <= 0.0) {
        [_mengImage setImage:[UIImage imageNamed:@"bg_xiangqing"]];
    } else {
        if (_alphaCur == _alpha) {
            return;
        }
        _alphaCur = _alpha;
        UIImage *image = [self imageWithColor:[UIColor colorWithRed:_HomeR green:_HomeG blue:_HomeB alpha:_alpha]];
        [_mengImage setImage:image];
    }
}

#pragma mark - click
- (void)nightBtnAction:(UIButton *)sender
{
    sender.enabled = FALSE;
    UIColor *fromColor = [UIColor colorWithRed:_HomeR green:_HomeG blue:_HomeB alpha:_alpha];
    UIColor *color = kDayColor;
    if ([WMNightManager currentStatus] == WMNightStatusNight) {
        _HomeR = kDayR;
        _HomeG = kDayG;
        _HomeB = kDayB;
        [WMNightManager dawnComing];
    } else {
        _HomeR = kNightR;
        _HomeG = kNightG;
        _HomeB = kNightB;
        color = kNightColor;
        [WMNightManager nightFalling];
    }
    UIColor *toColor = [UIColor colorWithRed:_HomeR green:_HomeG blue:_HomeB alpha:_alpha];

    if (_mengImage.hidden) {
        [self changeNav];
    } else {
        NSArray *colorArray = [UIColor arrayFromColor:fromColor ToColor:toColor duration:0.3 stepDuration:0.05];
        if (colorArray) {
            [self animateWithArray:colorArray];
        }
    }

    [UIView animateWithDuration:0.3 animations:^{
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:color, NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    } completion:^(BOOL finished) {
        sender.enabled = TRUE;
    }];
}

- (void)animateWithArray:(NSArray *)array
{
    NSUInteger counter = 0;
    for (UIColor *color in array) {
        double delayInSeconds = 0.05 * counter++;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            UIImage *image = [self imageWithColor:color];
            [_mengImage setImage:image];
        });
    }
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

@end
