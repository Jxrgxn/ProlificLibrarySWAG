//
//  BookDataSingleton.m
//  ProlificLibrarySWAG
//
//  Created by Basel Farag on 11/13/14.
//  Copyright (c) 2014 ABaselNotBasilProduction. All rights reserved.
//

#import "BookDataSingleton.h"
#import "BookData.h"
#import "APIConnectionHelper.h"

@implementation BookDataSingleton

+(instancetype)sharedBookData
{
    static BookDataSingleton *bookDataSingletonInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bookDataSingletonInstance = [[BookDataSingleton alloc] init];
    });
    return bookDataSingletonInstance;
}


@end
