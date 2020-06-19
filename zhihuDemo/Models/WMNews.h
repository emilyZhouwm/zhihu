//
//  WMNews.h
//  zhihuDemo
//
//  Created by zwm on 15/6/22.
//  Copyright (c) 2015年 zwm. All rights reserved.
//

#import <Foundation/Foundation.h>

#define STATUS_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height
#define iPX_LATER (STATUS_HEIGHT > 20.0f)
#define iPX_NAV_HEIGHT(x) (iPX_LATER ? ((x) + STATUS_HEIGHT - 20) : (x))
#define iPX_BOTTOM_BAR_HEIGHT(x) (iPX_LATER ? ((x) + 34) : (x))

@interface WMZhihu : NSObject

+ (WMZhihu *)sharedInstance;

@property (strong, nonatomic) NSMutableArray *newsAry;

- (NSIndexPath *)findWithID:(NSInteger)index;

- (void)save;
- (void)load;

@end

@interface WMStories : NSObject <NSCoding>

@property (strong, nonatomic) NSNumber *ID;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *image;
@property (strong, nonatomic) NSArray *images;

@property (assign, nonatomic) BOOL selected;

@end

@interface WMNews : NSObject <NSCoding>

@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSArray *stories;
@property (strong, nonatomic) NSArray *topStories;

- (NSArray *)topImgUrl;
- (NSArray *)topTitle;

- (NSString *)dateStr;
- (NSString *)nextDate;

@end
