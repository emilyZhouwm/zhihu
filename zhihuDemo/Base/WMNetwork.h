//
//  WMNetwork.h
//  iDemo
//
//  Created by zwm on 15/6/15.
//  Copyright (c) 2015年 zwm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef enum {
    Get = 0,
    Post,
    Put,
    Delete
} NetworkMethod;

typedef void(^NetworkBlock)(id data, NSError *error);
typedef void(^NetProgressdBlock)(CGFloat progressValue);

@interface WMNetwork : AFHTTPRequestOperationManager

+ (id)sharedInstance;

+ (void)requestWithFullUrl:(NSString *)urlPath
                withParams:(NSDictionary *)params
            withMethodType:(int)NetworkMethod
                  andBlock:(NetworkBlock)block;

+ (void)uploadImage:(UIImage *)image
        withFullUrl:(NSString *)urlPath
         withParams:(NSDictionary *)params
           withName:(NSString *)name
           andBlock:(NetworkBlock)block
      progerssBlock:(NetProgressdBlock)progress;

+ (AFHTTPRequestOperation *)upWithFile:(NSString *)filePath
                                 toUrl:(NSString *)urlPath
                            withParams:(NSDictionary *)params
                              andBlock:(NetworkBlock)block
                         progerssBlock:(NetProgressdBlock)progress;

+ (AFHTTPRequestOperation *)downWithUrl:(NSString *)urlPath
                             withParams:(NSDictionary *)params
                                 toPath:(NSString *)destPath
                               andBlock:(NetworkBlock)block
                          progerssBlock:(NetProgressdBlock)progress;

@end
