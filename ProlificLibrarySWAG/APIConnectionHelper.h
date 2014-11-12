//
//  APIConnectionHelper.h
//  ProlificLibrarySWAG
//
//  Created by Basel Farag on 10/29/14.
//  Copyright (c) 2014 ABaselNotBasilProduction. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIConnectionHelper : NSObject

+ (void) addLibraryBook:(NSString *)title
                 author:(NSString *)author
             categories:(NSString *)categories
              publisher:(NSString *)publisher;

+ (void) updateLibraryBook:(NSString *)title
                    author:(NSString *)author
                categories:(NSString *)categories
                 publisher:(NSString *)publisher
                    bookID:(id)bookID
          lastCheckedOutBy:(NSString *)lastCheckedOutBy;

+ (void) checkedOutBook:(NSString *)currentName
                 author:(NSString *)author
                 bookID:(id)bookID
         checkedOutDate:(NSDate *)checkedOutDate;

+ (void) deleteAll:(void (^)(BOOL success))completionBlock;

+ (void) deleteSingleBook:(id)bookID
               completion:(void (^)(BOOL success))completionBlock;


+(void)getAllBooksListWithSuccess:(void (^)(NSArray *books))success failure:(void (^)(NSError *error))failure;

@end
