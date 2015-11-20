//
//  WMNews.h
//  zhihuDemo
//
//  Created by zwm on 15/6/22.
//  Copyright (c) 2015年 zwm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WMZhihu : NSObject

+ (WMZhihu *)sharedInstance;

@property (strong, nonatomic) NSMutableArray *newsAry;

- (NSIndexPath *)findWithID:(NSInteger)index;

@end

@interface WMStories : NSObject

@property (strong, nonatomic) NSNumber *ID;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *image;
@property (strong, nonatomic) NSArray *images;

@property (assign, nonatomic) BOOL selected;

@end

@interface WMNews : NSObject

@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSArray *stories;
@property (strong, nonatomic) NSArray *topStories;

- (NSArray *)topImgUrl;
- (NSArray *)topTitle;

- (NSString *)dateStr;
- (NSString *)nextDate;

@end
