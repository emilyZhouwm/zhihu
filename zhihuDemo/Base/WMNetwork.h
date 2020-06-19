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

typedef void (^NetworkBlock)(id data, NSError *error);

@interface WMNetwork : AFHTTPSessionManager

+ (id)sharedInstance;

+ (void)requestWithFullUrl:(NSString *)urlPath
                withParams:(NSDictionary *)params
            withMethodType:(int)NetworkMethod
                  andBlock:(NetworkBlock)block;

@end
