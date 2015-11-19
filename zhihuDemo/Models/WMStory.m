//
//  WMStory.m
//  zhihuDemo
//
//  Created by zwm on 15/6/24.
//  Copyright (c) 2015年 zwm. All rights reserved.
//

#import "WMStory.h"
#import "MJExtension.h"

@implementation WMStoryExtra

+ (NSString *)replacedKeyFromPropertyName121:(NSString *)propertyName
{
    // nickName -> nick_name
    return [propertyName underlineFromCamel];
}

@end

@implementation WMSection

+ (NSArray *)allowedPropertyNames
{
    return @[@"name", @"ID", @"thumbnail"];
}

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"};
}

@end

@implementation WMStory
//+ (NSArray *)allowedPropertyNames
//{
//    return @[@"image", @"ID", @"title"];
//}

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"};
}

+ (NSString *)replacedKeyFromPropertyName121:(NSString *)propertyName
{
    // nickName -> nick_name
    return [propertyName underlineFromCamel];
}


@end
