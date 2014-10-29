//
//  APIConnectionHelper.m
//  ProlificLibrarySWAG
//
//  Created by Basel Farag on 10/29/14.
//  Copyright (c) 2014 ABaselNotBasilProduction. All rights reserved.
//

#import "APIConnectionHelper.h"
#import "Constants.h"
#include "AFNetworking.h"

@implementation APIConnectionHelper

+ (void)addLibraryBook:(NSString *)title author:(NSString *)author categories:(NSString *)categories publisher:(NSString *)publisher
{
    NSString *addBookURL = [NSString stringWithFormat:@"%@books", apiPath];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    [manager POST:addBookURL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"Success!");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Failure dude!");
    }];
}

+ (void)


@end
