//
//  WMStory.h
//  zhihuDemo
//
//  Created by zwm on 15/6/24.
//  Copyright (c) 2015年 zwm. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WMStoryExtra : NSObject

@property (strong, nonatomic) NSNumber *longComments;
@property (strong, nonatomic) NSNumber *popularity;
@property (strong, nonatomic) NSNumber *shortComments;
@property (strong, nonatomic) NSNumber *comments;

@end


@interface WMSection : NSObject

@property (strong, nonatomic) NSNumber *ID;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *thumbnail;

@end

@interface WMStory : NSObject

@property (strong, nonatomic) NSNumber *ID;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *body;
@property (copy, nonatomic) NSString *image;
@property (copy, nonatomic) NSString *imageSource;
@property (copy, nonatomic) NSString *shareUrl;
@property (strong, nonatomic) WMSection *section;
@property (strong, nonatomic) NSArray *css;

@property (strong, nonatomic) WMStoryExtra *extra;

@end
