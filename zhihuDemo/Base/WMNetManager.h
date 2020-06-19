//
//  WMNetManager.h
//  iDemo
//
//  Created by zwm on 15/6/15.
//  Copyright (c) 2015年 zwm. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^NetworkBlock)(id data, NSError *error);

@interface WMNetManager : NSObject

+ (void)requestHomeWithBlock:(NetworkBlock)block;
+ (void)requestStories:(NSString *)urlDate andBlock:(NetworkBlock)block;
+ (void)requestStory:(NSString *)ID andBlock:(NetworkBlock)block;
+ (void)requestStoryExtra:(NSString *)ID andBlock:(NetworkBlock)block;
+ (void)requestStoryLong:(NSString *)ID andBlock:(NetworkBlock)block;
+ (void)requestStoryShort:(NSString *)ID andBlock:(NetworkBlock)block;

@end
