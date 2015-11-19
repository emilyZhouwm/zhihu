//
//  WMNetManager.m
//  iDemo
//
//  Created by zwm on 15/6/15.
//  Copyright (c) 2015年 zwm. All rights reserved.
//

#import "WMNetManager.h"
#import "WMNetwork.h"
#import "WMNews.h"
#import "WMStory.h"
#import "MJExtension.h"

#define kNetwrok_Url_Base @"http://news-at.zhihu.com/%@"

@implementation WMNetManager

+ (void)requestHomeWithBlock:(NetworkBlock)block
{
    NSString *fullPath = [NSString stringWithFormat:kNetwrok_Url_Base, @"api/4/stories/latest?client=0"];
    
    [WMNetwork requestWithFullUrl:fullPath
                       withParams:nil
                   withMethodType:Get
                         andBlock:^(id data, NSError *error) {
                             if (block) {
                                 if (error) {
                                     error = [NSError errorWithDomain:@"网络异常" code:-9999 userInfo:nil];
                                     block(nil, error);
                                 } else {
                                     WMNews *news = [WMNews objectWithKeyValues:data];
                                     block(news, nil);
                                 }
                             }
                         }];
}

+ (void)requestStories:(NSString *)urlDate andBlock:(NetworkBlock)block
{
    NSString *urlPath = [NSString stringWithFormat:@"api/4/stories/before/%@?client=0", urlDate];
    NSString *fullPath = [NSString stringWithFormat:kNetwrok_Url_Base, urlPath];
    
    [WMNetwork requestWithFullUrl:fullPath
                       withParams:nil
                   withMethodType:Get
                         andBlock:^(id data, NSError *error) {
                             if (block) {
                                 if (error) {
                                     error = [NSError errorWithDomain:@"网络异常" code:-9999 userInfo:nil];
                                     block(nil, error);
                                 } else {
                                     WMNews *news = [WMNews objectWithKeyValues:data];
                                     block(news, nil);
                                 }
                             }
                         }];
}

+ (void)requestStory:(NSString *)ID andBlock:(NetworkBlock)block
{
    NSString *urlPath = [NSString stringWithFormat:@"api/4/story/%@", ID];
    NSString *fullPath = [NSString stringWithFormat:kNetwrok_Url_Base, urlPath];
    
    [WMNetwork requestWithFullUrl:fullPath
                       withParams:nil
                   withMethodType:Get
                         andBlock:^(id data, NSError *error) {
                             if (block) {
                                 if (error) {
                                     error = [NSError errorWithDomain:@"网络异常" code:-9999 userInfo:nil];
                                     block(nil, error);
                                 } else {
                                     WMStory *story = [WMStory objectWithKeyValues:data];
                                     block(story, nil);
                                 }
                             }
                         }];
}

+ (void)requestStoryExtra:(NSString *)ID andBlock:(NetworkBlock)block
{
    NSString *urlPath = [NSString stringWithFormat:@"api/4/story-extra/%@", ID];
    NSString *fullPath = [NSString stringWithFormat:kNetwrok_Url_Base, urlPath];
    
    [WMNetwork requestWithFullUrl:fullPath
                       withParams:nil
                   withMethodType:Get
                         andBlock:^(id data, NSError *error) {
                             if (block) {
                                 if (error) {
                                     error = [NSError errorWithDomain:@"网络异常" code:-9999 userInfo:nil];
                                     block(nil, error);
                                 } else {
                                     WMNews *news = [WMNews objectWithKeyValues:data];
                                     block(news, nil);
                                 }
                             }
                         }];
}

+ (void)requestStoryLong:(NSString *)ID andBlock:(NetworkBlock)block
{
    NSString *urlPath = [NSString stringWithFormat:@"api/4/story/%@/long-comments", ID];
    NSString *fullPath = [NSString stringWithFormat:kNetwrok_Url_Base, urlPath];
    
    [WMNetwork requestWithFullUrl:fullPath
                       withParams:nil
                   withMethodType:Get
                         andBlock:^(id data, NSError *error) {
                             if (block) {
                                 if (error) {
                                     error = [NSError errorWithDomain:@"网络异常" code:-9999 userInfo:nil];
                                     block(nil, error);
                                 } else {
                                     WMNews *news = [WMNews objectWithKeyValues:data];
                                     block(news, nil);
                                 }
                             }
                         }];
}

+ (void)requestStoryShort:(NSString *)ID andBlock:(NetworkBlock)block
{
    NSString *urlPath = [NSString stringWithFormat:@"api/4/story/%@/short-comments", ID];
    NSString *fullPath = [NSString stringWithFormat:kNetwrok_Url_Base, urlPath];
    
    [WMNetwork requestWithFullUrl:fullPath
                       withParams:nil
                   withMethodType:Get
                         andBlock:^(id data, NSError *error) {
                             if (block) {
                                 if (error) {
                                     error = [NSError errorWithDomain:@"网络异常" code:-9999 userInfo:nil];
                                     block(nil, error);
                                 } else {
                                     WMNews *news = [WMNews objectWithKeyValues:data];
                                     block(news, nil);
                                 }
                             }
                         }];
}

@end
