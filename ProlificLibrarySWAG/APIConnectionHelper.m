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
#include "BookData.h"

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

+(void)deleteSingleBook:(id)bookID completion:(void (^)(BOOL))completionBlock
//+(void)deleteSingleBook:(void (^)(id *bookID))success failure:(void (^)(NSError *error))failure
{
    NSString *deleteSingleBook = [NSString stringWithFormat:@"%@books/%@", apiPath, bookID];
    NSOperationQueue *backgroundQueue = [[NSOperationQueue alloc] init];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    [manager DELETE:deleteSingleBook parameters:nil
            success:^(NSURLSessionDataTask *task, id responseObject)
    {
        [backgroundQueue addOperationWithBlock:^{
            completionBlock(YES);
        }];
        NSLog(@"Success!");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Failure. Bummer");
    }];
}

+(void)getAllBooksListWithSuccess:(void (^)(NSArray *books))success failure:(void (^)(NSError *error))failure
{
    NSString *getAll = [NSString stringWithFormat:@"%@books", apiPath];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:getAll parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if ([responseObject isKindOfClass:[NSArray class]]) {
            NSArray *responseArray = responseObject;
            NSMutableArray *addBooks = [NSMutableArray new];
            for (NSDictionary *allGetDict in responseArray){
                {
                    BookData *tempObject = [BookData new];

                    if ([allGetDict objectForKey:@"title"] == [NSNull null]){
                        tempObject.title = @"N/A";
                    }
                    else {
                        tempObject.title = [allGetDict objectForKey:@"title"];
                    }
                    if ([allGetDict objectForKey:@"author"] == [NSNull null]){
                        tempObject.author = @"N/A";
                    }
                    else
                    {
                        tempObject.author = [allGetDict objectForKey:@"author"];
                    }

                    if ([allGetDict objectForKey:@"lastCheckedOutBy"] == [NSNull null])
                    {
                        tempObject.lastDateCheckedOutBy = @"N/A";
                    }else{
                        tempObject.lastDateCheckedOutBy = [allGetDict objectForKey:@"lastCheckedOutBy"];
                    }
                    if ([allGetDict objectForKey:@"lastCheckedOut"] == [NSNull null])
                    {
                        tempObject.lastCheckedOutDate = nil;
                    }else {
                        tempObject.lastCheckedOutDate = [allGetDict objectForKey:@"lastCheckedOut"];
                    }
                    tempObject.categories = [allGetDict objectForKey:@"categories"];
                    tempObject.publisher = [allGetDict objectForKey:@"publisher"];
                    tempObject.ID = [allGetDict objectForKey:@"id"];


                    [addBooks addObject:tempObject];

                }
            }
            NSLog(@"Array contains: %@", addBooks);
            success(addBooks);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
    
    NSLog(@"Exit");

}

@end
