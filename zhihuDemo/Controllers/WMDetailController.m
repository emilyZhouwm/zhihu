//
//  WMDetailController.m
//  zhihuDemo
//
//  Created by zwm on 15/6/24.
//  Copyright (c) 2015年 zwm. All rights reserved.
//

#import "WMDetailController.h"
#import "UIViewController+PopPush.h"
#import "WMNews.h"
#import "WMStory.h"
#import "WMNetManager.h"
#import "UIImageView+WebCache.h"
#import "FBKVOController.h"

@interface WMDetailController () <UIScrollViewDelegate, UIWebViewDelegate>
{
    FBKVOController *_kvo;
}

@property (strong, nonatomic) WMStory *story;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *imageSourceLbl;
@property (weak, nonatomic) IBOutlet UIImageView *mengView;

@property (weak, nonatomic) IBOutlet UIView *toolBar;
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UIView *statusView;
@property (weak, nonatomic) IBOutlet UIImageView *mengImage;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headTopLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headHLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webHLayout;

@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIImageView *guideImg;

@property (strong, nonatomic) WMStories *stories;

@end

@implementation WMDetailController

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    self.scrollView.contentInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = FALSE;

    [self setCurStories:_indexPath];

    self.webView.scrollView.scrollEnabled = FALSE;
    _webHLayout.constant = self.view.frame.size.height - 160 - _toolBar.frame.size.height;
    _webView.delegate = self;
    //_webView.scalesPageToFit = YES;

    _titleLbl.text = _stories.title;
    _headView.layer.zPosition = -1;

    [self startAnimate];
    [self showGuide];

    __weak typeof(self) weakself = self;
    _kvo = [FBKVOController controllerWithObserver:self];
    [_kvo observe:_webView.scrollView keyPath:@"contentSize" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
        weakself.webHLayout.constant = weakself.webView.scrollView.contentSize.height;
        [weakself.webView setNeedsLayout];
        [weakself.webView layoutIfNeeded];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestStory
{
    _leftBtn.enabled = FALSE;
    _rightBtn.enabled = TRUE;
    __weak typeof(self) weakself = self;
    [WMNetManager requestStory:_stories.ID.stringValue andBlock:^(id data, NSError *error) {
        weakself.leftBtn.enabled = TRUE;
        weakself.rightBtn.enabled = TRUE;
        if (data && [data isKindOfClass:[WMStory class]]) {
            [weakself setStory:data];
        }
    }];
}

- (void)setStory:(WMStory *)story
{
    _story = story;
    if (_story.image.length > 0) {
        [_iconView sd_setImageWithURL:[NSURL URLWithString:_story.image] placeholderImage:_iconView.image];
    }
    _titleLbl.text = _story.title;
    _imageSourceLbl.text = _story.imageSource;
    if (_story.body.length > 0) {
        if ([WMNightManager currentStatus] == WMNightStatusNight) {
            NSString *html = [NSString stringWithFormat:@"<html><head><link rel=\"stylesheet\" href=%@</head><body><div class=\"night\">%@</div></body></html>", _story.css[0], [_story.body stringByReplacingOccurrencesOfString:@"<div class=\"img-place-holder\"></div>" withString:@""]];
            [_webView loadHTMLString:html baseURL:nil];
        } else {
            NSString *html = [NSString stringWithFormat:@"<html><head><link rel=\"stylesheet\" href=%@</head><body>%@</body></html>", _story.css[0], [_story.body stringByReplacingOccurrencesOfString:@"<div class=\"img-place-holder\"></div>" withString:@""]];
            [_webView loadHTMLString:html baseURL:nil];
        }
    } else {
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_story.shareUrl]]];
    }
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //NSInteger height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"] intValue];
    //NSString *javascript = [NSString stringWithFormat:@"window.scrollBy(0, %ld);", (long)height];
    //NSString *javascript = @"window.scrollBy(0, 0);";
    //[webView stringByEvaluatingJavaScriptFromString:javascript];
    _webHLayout.constant = webView.scrollView.contentSize.height;
    [_webView setNeedsLayout];
    [_webView layoutIfNeeded];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"%@", error);
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

#pragma mark - WMNavigationDelegate
- (BOOL)viewControllerToPop
{
    [self rightBtnClick];
    return NO;
}

- (void)rightBtnClick
{
    if (CGRectEqualToRect(self.startRect, CGRectZero)) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }

    _bottomLayout.constant = -_toolBar.frame.size.height;

    [_toolBar setNeedsLayout];
    [UIView animateWithDuration:0.3f animations:^{
        [_toolBar layoutIfNeeded];
        _mengView.alpha = 0;
        _webView.alpha = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3f animations:^{
            _iconView.frame = self.startRect;
        } completion:^(BOOL finished) {
        }];
        [self customerPopViewController];
    }];
}

- (void)startAnimate
{
    if (CGRectEqualToRect(self.startRect, CGRectZero)) {
        return;
    }
    _iconView.frame = self.startRect;
    [_iconView setNeedsLayout];
    _webView.alpha = 0;
    _mengView.alpha = 0;
    _toolBar.alpha = 0;
    CGRect frame = _toolBar.frame;
    frame.origin.y += frame.size.height;
    _toolBar.frame = frame;

    [UIView animateWithDuration:0.3f animations:^{
        [_iconView layoutIfNeeded];
    } completion:^(BOOL finished) {

        _toolBar.alpha = 1;
        [_toolBar setNeedsLayout];
        [UIView animateWithDuration:0.2f animations:^{
            [_toolBar layoutIfNeeded];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2f animations:^{
                _webView.alpha = 1;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.2f animations:^{
                    _mengView.alpha = 1;
                } completion:^(BOOL finished) {
                }];
            }];
        }];
    }];
}

- (void)showGuide
{
    NSString *guide = [[NSUserDefaults standardUserDefaults] objectForKey:@"guide"];
    if ([guide integerValue] > 0) {
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"guide"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        _guideImg.hidden = FALSE;
        CGRect frame = self.view.bounds;
        frame.origin.x = frame.size.width;
        [UIView animateWithDuration:2 animations:^{
            _guideImg.alpha = 0.5;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                _guideImg.alpha = 0;
                _guideImg.frame = frame;
            } completion:^(BOOL finished) {
                _guideImg.hidden = TRUE;
            }];
        }];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _scrollView) {
        _statusView.hidden = TRUE;
        _mengImage.hidden = FALSE;
        if (scrollView.contentOffset.y < 0) {
            if ([UIApplication sharedApplication].statusBarStyle != UIStatusBarStyleLightContent) {
                [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
            }
            _headHLayout.constant = 160 - scrollView.contentOffset.y;
            if (_headTopLayout.constant != 0) {
                _headTopLayout.constant = 0;
            }
        } else {
            _headTopLayout.constant = -scrollView.contentOffset.y * 0.5;
            _headHLayout.constant = 160;
            if (scrollView.contentOffset.y >= 160) {
                if ([UIApplication sharedApplication].statusBarStyle != UIStatusBarStyleDefault) {
                    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
                }
                _statusView.hidden = FALSE;
                _mengImage.hidden = TRUE;
            } else {
                if ([UIApplication sharedApplication].statusBarStyle != UIStatusBarStyleLightContent) {
                    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
                }
            }
        }
    }
}

#pragma mark -
- (IBAction)leftBtnAction:(id)sender
{
    NSIndexPath *pre = [self getPreIndex];
    if (pre) {
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        [self setCurStories:pre];
    }
}

- (IBAction)rightBtnAction:(id)sender
{
    WMNews *tempNews = [WMZhihu sharedInstance].newsAry[_indexPath.section];
    NSIndexPath *next = [self getNextIndex:tempNews.stories.count];
    if (next) {
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        [self setCurStories:next];
    }
}

- (NSIndexPath *)getPreIndex
{
    if (_indexPath.row == 0) {
        if (_indexPath.section > 0) {
            WMNews *tempNews = [WMZhihu sharedInstance].newsAry[_indexPath.section - 1];
            return [NSIndexPath indexPathForRow:tempNews.stories.count - 1 inSection:_indexPath.section - 1];
        }
    } else {
        return [NSIndexPath indexPathForRow:_indexPath.row - 1 inSection:_indexPath.section];
    }
    return nil;
}

- (WMStories *)getPre
{
    if (_indexPath.row == 0) {
        if (_indexPath.section > 0) {
            WMNews *tempNews = [WMZhihu sharedInstance].newsAry[_indexPath.section - 1];
            return tempNews.stories[tempNews.stories.count - 1];
        }
    } else {
        WMNews *tempNews = [WMZhihu sharedInstance].newsAry[_indexPath.section];
        return tempNews.stories[_indexPath.row - 1];
    }
    return nil;
}

- (WMStories *)getNext:(NSUInteger)count
{
    if (_indexPath.row >= count - 1) {
        if (_indexPath.section + 1 < [WMZhihu sharedInstance].newsAry.count) {
            WMNews *tempNews = [WMZhihu sharedInstance].newsAry[_indexPath.section + 1];
            return tempNews.stories[0];
        }
    } else {
        WMNews *tempNews = [WMZhihu sharedInstance].newsAry[_indexPath.section];
        return tempNews.stories[_indexPath.row + 1];
    }
    return nil;
}

- (NSIndexPath *)getNextIndex:(NSUInteger)count
{
    if (_indexPath.row >= count - 1) {
        if (_indexPath.section + 1 < [WMZhihu sharedInstance].newsAry.count) {
            return [NSIndexPath indexPathForRow:0 inSection:_indexPath.section + 1];
        }
    } else {
        return [NSIndexPath indexPathForRow:_indexPath.row + 1 inSection:_indexPath.section];
    }
    return nil;
}

- (void)setCurStories:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    WMNews *tempNews = [WMZhihu sharedInstance].newsAry[_indexPath.section];
    self.stories = tempNews.stories[_indexPath.row];
    self.stories.selected = TRUE;

    if (_stories.images.count > 0) {
        [_iconView sd_setImageWithURL:[NSURL URLWithString:_stories.images[0]]];
    } else if (_stories.image.length > 0) {
        [_iconView sd_setImageWithURL:[NSURL URLWithString:_stories.image]];
    }

    WMStories *pre = [self getPre];
    if (pre) {
        [_leftBtn setTitle:[NSString stringWithFormat:@"<%@", pre.title] forState:UIControlStateNormal];
        _leftBtn.enabled = TRUE;
    } else {
        [_leftBtn setTitle:@"没有上一篇" forState:UIControlStateNormal];
        _leftBtn.enabled = FALSE;
    }
    WMStories *next = [self getNext:tempNews.stories.count];
    if (next) {
        [_rightBtn setTitle:[NSString stringWithFormat:@"%@>", next.title] forState:UIControlStateNormal];
        _rightBtn.enabled = TRUE;
    } else {
        [_rightBtn setTitle:@"没有下一篇" forState:UIControlStateNormal];
        _rightBtn.enabled = FALSE;
    }

    [self requestStory];
}

@end
