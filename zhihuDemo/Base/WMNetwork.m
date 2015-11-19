//
//  WMNetwork.m
//  iDemo
//
//  Created by zwm on 15/6/15.
//  Copyright (c) 2015年 zwm. All rights reserved.
//

#import "WMNetwork.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "WMMacros.h"

@implementation WMNetwork

+ (WMNetwork *)sharedInstance
{
    static WMNetwork *_sharedNetwork = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedNetwork = [[WMNetwork alloc] init];
    });
    
    return _sharedNetwork;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    }
    return self;
}

+ (void)requestWithFullUrl:(NSString *)urlPath
                withParams:(NSDictionary *)params
            withMethodType:(int)NetworkMethod
                  andBlock:(NetworkBlock)block
{
    if (!urlPath || urlPath.length <= 0) {
        return;
    }
    
    // log请求数据
    DebugLog(@"\n===========request===========\n%@:\n%@", urlPath, params);
    urlPath = [urlPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    // 发起请求
    switch (NetworkMethod) {
        case Get:
        {
            [[WMNetwork sharedInstance] GET:urlPath
                                 parameters:params
                                    success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                        DebugLog(@"\n===========response GET===========\n%@:\n%@", urlPath, responseObject);
                                        if (block) {
                                            block(responseObject, nil);
                                        }
                                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                        DebugLog(@"\n===========response GET===========\n%@:\n%@", urlPath, error);
                                        if (block) {
                                            block(nil, error);
                                        }
                                    }];
            break;
        }
        case Post:
        {
            [[WMNetwork sharedInstance] POST:urlPath
                                  parameters:params
                                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                         DebugLog(@"\n===========response POST===========\n%@:\n%@", urlPath, responseObject);
                                         if (block) {
                                             block(responseObject, nil);
                                         }
                                     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                         DebugLog(@"\n===========response POST===========\n%@:\n%@", urlPath, error);
                                         if (block) {
                                             block(nil, error);
                                         }
                                     }];
            break;
        }
        case Put:
        {
            [[WMNetwork sharedInstance] PUT:urlPath
                                 parameters:params
                                    success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                        DebugLog(@"\n===========response PUT===========\n%@:\n%@", urlPath, responseObject);
                                        if (block) {
                                            block(responseObject, nil);
                                        }
                                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                        DebugLog(@"\n===========response PUT===========\n%@:\n%@", urlPath, error);
                                        if (block) {
                                            block(nil, error);
                                        }
                                    }];
            break;
        }
        case Delete:
        {
            [[WMNetwork sharedInstance] DELETE:urlPath
                                    parameters:params
                                       success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                           DebugLog(@"\n===========response DELETE===========\n%@:\n%@", urlPath, responseObject);
                                           if (block) {
                                               block(responseObject, nil);
                                           }
                                       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                           DebugLog(@"\n===========response DELETE===========\n%@:\n%@", urlPath, error);
                                           if (block) {
                                               block(nil, error);
                                           }
                                        }];
        }
    }
}

// 上传图片
+ (void)uploadImage:(UIImage *)image
        withFullUrl:(NSString *)urlPath
         withParams:(NSDictionary *)params
           withName:(NSString *)name
           andBlock:(NetworkBlock)block
      progerssBlock:(NetProgressdBlock)progress
{
    if (!urlPath || urlPath.length <= 0 || !image) {
        return;
    }
   
    DebugLog(@"\n===========uploadImage request===========\n%@:\n%@", urlPath, params);
    urlPath = [urlPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    // 压缩
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    if ((float)data.length/1024 > 1000) {
        data = UIImageJPEGRepresentation(image, 1024 * 1000.0 / (float)data.length);
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@_%@.jpg", name, str];
    DebugLog(@"\n uploadImage Size %@ : %.0f", fileName, (float)data.length / 1024);
    
    AFHTTPRequestOperation *operation =
    
    [[WMNetwork sharedInstance] POST:urlPath parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:data name:name fileName:fileName mimeType:@"image/jpeg"];//@"audio/mp3"//@"image/png"
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DebugLog(@"\n===========uploadImage response===========\n%@:\n%@", urlPath, responseObject);
        if (block) {
            block(responseObject, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DebugLog(@"\n===========uploadImage response===========\n%@:\n%@", urlPath, error);
        if (block) {
            block(nil, error);
        }
    }];
    
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        CGFloat progressValue = (float)totalBytesWritten / (float)totalBytesExpectedToWrite;
        if (progress) {
            progress(progressValue);
        }
    }];
    
    [operation start];
}

+ (AFHTTPRequestOperation *)upWithFile:(NSString *)filePath
                                 toUrl:(NSString *)urlPath
                           withParams:(NSDictionary *)params
                             andBlock:(NetworkBlock)block
                        progerssBlock:(NetProgressdBlock)progress
{
    if (!urlPath || urlPath.length <= 0 || !filePath || filePath.length <= 0) {
        return nil;
    }
    
    DebugLog(@"\n===========upWithFile request===========\n%@:\n%@\n%@", urlPath, params, filePath);
    urlPath = [urlPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *name = [[filePath lastPathComponent] stringByDeletingPathExtension];
    NSString *ext = [filePath pathExtension];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@_%@.%@", name, str, ext];
    
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    DebugLog(@"\n upWithFile Size %@ : %.0f", fileName, (float)data.length / 1024);
    
    NSString *mimeType;
    if ([ext isEqualToString:@"jpg"] || [ext isEqualToString:@"jpeg"] || [ext isEqualToString:@"png"] || [ext isEqualToString:@"tiff"] || [ext isEqualToString:@"gif"]) {
        mimeType = [NSString stringWithFormat:@"image/%@", ext];
    } else if ([ext isEqualToString:@"mp3"]) {
        mimeType = [NSString stringWithFormat:@"audio/%@", ext];
    } else if ([ext isEqualToString:@"zip"]) {
        mimeType = [NSString stringWithFormat:@"application/%@", ext];
    }
    if (!mimeType || !data || data.length<=0) {
        return nil;
    }
        
    AFHTTPRequestOperation *operation =
    
    [[WMNetwork sharedInstance] POST:urlPath parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:data name:name fileName:fileName mimeType:mimeType];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DebugLog(@"\n===========upWithFile response===========\n%@:\n%@", urlPath, responseObject);
        if (block) {
            block(responseObject, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DebugLog(@"\n===========upWithFile response===========\n%@:\n%@", urlPath, error);
        if (block) {
            block(nil, error);
        }
    }];
    
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        CGFloat progressValue = (float)totalBytesWritten / (float)totalBytesExpectedToWrite;
        if (progress) {
            progress(progressValue);
        }
    }];
    
    [operation start];
    return operation;
}

// 下载文件，最好是zip文件
+ (AFHTTPRequestOperation *)downWithUrl:(NSString *)urlPath
                             withParams:(NSDictionary *)params
                                 toPath:(NSString *)destPath
                               andBlock:(NetworkBlock)block
                          progerssBlock:(NetProgressdBlock)progress
{
    if (!urlPath || urlPath.length <= 0) {
        return nil;
    }
    
    DebugLog(@"\n===========downWithUrl request===========\n%@", urlPath);
    urlPath = [urlPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
   
    WMNetwork *mySelf = [WMNetwork sharedInstance];
    NSMutableURLRequest *request = [mySelf.requestSerializer requestWithMethod:@"GET" URLString:urlPath parameters:params error:nil];
    
    // 检查文件是否已经下载了一部分
    unsigned long long downloadedBytes = 0;
    if ([[NSFileManager defaultManager] fileExistsAtPath:destPath]) {
        // 获取已下载的文件长度
        downloadedBytes = [[WMNetwork sharedInstance] fileSizeForPath:destPath];
        if (downloadedBytes > 0) {
            NSString *requestRange = [NSString stringWithFormat:@"bytes=%llu-", downloadedBytes];
            [request setValue:requestRange forHTTPHeaderField:@"Range"];
        }
    }
    [request addValue:@"http://gre.kaomanfen.com/" forHTTPHeaderField: @"Referer"];
    //[request setTimeoutInterval:100];
    
    // 不使用缓存，避免断点续传出现问题
    [[NSURLCache sharedURLCache] removeCachedResponseForRequest:request];
    
    AFHTTPRequestOperation *operation = [mySelf HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DebugLog(@"\n===========downWithUrl response===========\n%@:\n%@", urlPath, responseObject);
        if (block) {
            block(responseObject, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DebugLog(@"\n===========downWithUrl response===========\n%@:\n%@", urlPath, error);
        if (block) {
            block(nil, error);
        }
    }];

    // 下载路径
    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:destPath append:YES];
    
    // 下载进度回调
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        // 下载进度
        CGFloat progressValue = ((float)totalBytesRead + downloadedBytes) / (totalBytesExpectedToRead + downloadedBytes);
        if (progress) {
            progress(progressValue);
        }
    }];
    
    [mySelf.operationQueue addOperation:operation];
   
    [operation start];
    return operation;
}

// 获取已下载的文件大小
+ (unsigned long long)fileSizeForPath:(NSString *)path
{
    signed long long fileSize = 0;
    
    // default is not thread safe
    NSFileManager *fileManager = [NSFileManager new];
    if ([fileManager fileExistsAtPath:path]) {
        
        NSError *error = nil;
        NSDictionary *fileDict = [fileManager attributesOfItemAtPath:path error:&error];
        if (!error && fileDict) {
            fileSize = [fileDict fileSize];
        }
    }
    return fileSize;
}

@end
