//
//  BookDataSingleton.h
//  ProlificLibrarySWAG
//
//  Created by Basel Farag on 11/13/14.
//  Copyright (c) 2014 ABaselNotBasilProduction. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookDataSingleton : NSObject

@property (nonatomic) NSMutableArray *allBooksLibrary;

+(instancetype)sharedBookData;

@end
