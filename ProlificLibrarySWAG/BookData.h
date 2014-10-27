//
//  BookData.h
//  ProlificLibrarySWAG
//
//  Created by Basel Farag on 10/24/14.
//  Copyright (c) 2014 ABaselNotBasilProduction. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookData : NSObject

@property (nonatomic) NSString *author;
@property (nonatomic) NSString *categories;
@property (nonatomic) id ID;
@property (nonatomic) NSDate *lastCheckedOutDate;
@property (nonatomic) NSString *lastDateCheckedOutBy;
@property (nonatomic) NSString *publisher;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *url;

@end
