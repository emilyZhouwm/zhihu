//
//  WMNews.m
//  zhihuDemo
//
//  Created by zwm on 15/6/22.
//  Copyright (c) 2015年 zwm. All rights reserved.
//

#import "WMNews.h"
#import "MJExtension.h"

@implementation WMZhihu

+ (WMZhihu *)sharedInstance
{
    static WMZhihu *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[WMZhihu alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _newsAry = @[].mutableCopy;
    }
    return self;
}

- (NSIndexPath *)findWithID:(NSInteger)index
{
    WMNews *top = _newsAry[0];
    WMStories *cur = top.topStories[index];
    for (NSInteger i=0; i<_newsAry.count; i++) {
        WMNews *tempNews = _newsAry[i];
        NSInteger j = 0;
        for (WMStories *stories in tempNews.stories) {
            if ([stories.ID isEqualToNumber:cur.ID]) {
                return [NSIndexPath indexPathForRow:j inSection:i];
            }
            j++;
        }
    }
    return nil;
}

- (void)save
{
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    [archiver encodeObject:_newsAry forKey:@"news"];
    [archiver finishEncoding];
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:@"/news.plist"];
    [data writeToFile:path atomically:YES];
}

- (void)load
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:@"/news.plist"];
    NSData *data = [[NSMutableData alloc] initWithContentsOfFile:path];
    if (data.length > 0) {
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        [_newsAry addObjectsFromArray:[unarchiver decodeObjectForKey:@"news"]];
        [unarchiver finishDecoding];
    }
}

@end

@implementation WMStories

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"};
}

- (id)newValueFromOldValue:(id)oldValue property:(MJProperty *)property
{
    if ([property.name isEqualToString:@"title"] || [property.name isEqualToString:@"image"]) {
        if (oldValue == nil) return @"";
    } else if ([property.name isEqualToString:@"ID"]) {
        if (oldValue == nil) return @0;
    } else if ([property.name isEqualToString:@"images"]) {
        if (oldValue == nil) return @[];
    }
    
    return oldValue;
}

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_ID forKey:@"ID"];
    [aCoder encodeObject:_title forKey:@"title"];
    [aCoder encodeObject:_image forKey:@"image"];
    [aCoder encodeObject:_images forKey:@"images"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _ID = [aDecoder decodeObjectForKey:@"ID"];
        _title = [aDecoder decodeObjectForKey:@"title"];
        _image = [aDecoder decodeObjectForKey:@"image"];
        _images = [aDecoder decodeObjectForKey:@"images"];
    }
    return self;
}

@end

@implementation WMNews

+ (NSString *)replacedKeyFromPropertyName121:(NSString *)propertyName
{
    // nickName -> nick_name
    return [propertyName underlineFromCamel];
}

+ (NSDictionary *)objectClassInArray
{
    return @{@"stories" : @"WMStories",
             @"topStories" : @"WMStories"};
}

- (id)newValueFromOldValue:(id)oldValue property:(MJProperty *)property
{
    if (property.type.typeClass == [NSDate class]) {
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"yyyyMMdd";
        return [fmt dateFromString:oldValue];
    }
    return oldValue;
}

- (NSArray *)topImgUrl
{
    NSMutableArray *topTemp = @[].mutableCopy;
    for (WMStories *topStories in _topStories) {
        [topTemp addObject:topStories.image];
    }
    return topTemp;
}

- (NSArray *)topTitle
{
    NSMutableArray *topTemp = @[].mutableCopy;
    for (WMStories *topStories in _topStories) {
        [topTemp addObject:topStories.title];
    }
    return topTemp;
}

- (NSString *)dateStr
{
    if ([self isToday]) {
        return @"今日要闻";
    }
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"MM月dd日 EEEE";
    return [fmt stringFromDate:_date];
}

- (NSString *)nextDate
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyyMMdd";
    return [fmt stringFromDate:_date];
}

- (BOOL)isToday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components1 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:[NSDate date]];
    NSDateComponents *components2 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:_date];
    return ([components1 year] == [components2 year]
            && [components1 month] == [components2 month]
            && [components1 day] == [components2 day]);
}

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_date forKey:@"date"];
    [aCoder encodeObject:_stories forKey:@"stories"];
    [aCoder encodeObject:_topStories forKey:@"topStories"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _date = [aDecoder decodeObjectForKey:@"date"];
        _stories = [aDecoder decodeObjectForKey:@"stories"];
        _topStories = [aDecoder decodeObjectForKey:@"topStories"];
    }
    return self;
}

@end
