//
//  FPGetPhotosByTagResponseData.h
//  FlickrParty
//
//  Created by Bi Chen Ka Kit on 13年6月20日.
//  Copyright (c) 2013年 biworks. All rights reserved.
//

#import "SPBaseResponseData.h"

@interface FPGetPhotosByTagResponseData : SPBaseResponseData

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, retain) NSString *pages;
@property (nonatomic, assign) NSInteger perPage;
@property (nonatomic, retain) NSString *total;
@property (nonatomic, retain) NSMutableArray *photos;
@property (nonatomic, retain) NSString *stat;
@property (nonatomic, assign) BOOL succeed;

@end
