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
    NSString *addBookURL = [NSString stringWithFormat:@"%@books/", apiPath];

    NSDictionary *params = @{@"title":title, @"author":author, @"categories":categories, @"publisher":publisher};

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    [manager POST:addBookURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"Success! JSON: %@", responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Failure dude!");
    }];
}

+ (void) updateLibraryBook:(NSString *)title author:(NSString *)author categories:(NSString *)categories publisher:(NSString *)publisher bookID:(id)bookID lastCheckedOutBy:(NSString *)lastCheckedOutBy
{
    NSString *updateBookURL = [NSString stringWithFormat:@"%@books/%@", apiPath, bookID];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    NSDictionary *updateParam = @{@"title":title, @"author":author, @"categories":categories, @"publisher":publisher, @"lastCheckedOutBy":lastCheckedOutBy};

    [manager PUT:updateBookURL parameters:updateParam success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"Success");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Failure");
    }];
}

+ (void)checkedOutBook:(NSString *)currentName author:(NSString *)author bookID:(id)bookID checkedOutDate:(NSDate *)checkedOutDate
{
    NSString *checkedOutURL = [NSString stringWithFormat:@"%@books/%@", apiPath, bookID];

    NSDictionary *checkedOutParam = @{@"lastCheckedOutBy":currentName, @"lastCheckedOut":checkedOutDate};

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    [manager PUT:checkedOutURL parameters:checkedOutParam success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"Success! JSON: %@", responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Failure");
    }];
}


+ (void)deleteAll
{
    NSString *deleteAllBooks = [NSString stringWithFormat:@"%@clean", apiPath];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    [manager DELETE:deleteAllBooks parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"Success!");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Failure!");
    }];
}

+(void)deleteSingleBook:(id)bookID
{
    NSString *deleteSingleBook = [NSString stringWithFormat:@"%@books/%@", apiPath, bookID];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    [manager DELETE:deleteSingleBook parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"Success!");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Failure. Bummer");
    }];
}
@end
