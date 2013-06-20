//
//  FPGetPhotosByTagRequest.h
//  FlickrParty
//
//  Created by Bi Chen Ka Kit on 13年6月20日.
//  Copyright (c) 2013年 biworks. All rights reserved.
//

#import "SPBaseRequest.h"

@class FPGetPhotosByTagResponseData, FPGetPhotosByTagRequestData;

@protocol FPGetPhotosByTagRequestRequestDelegate <NSObject>

- (void)FPGetPhotosByTagRequestRequestDidFinish:(FPGetPhotosByTagResponseData*)response;

@end

@interface FPGetPhotosByTagRequest : SPBaseRequest

@property (nonatomic, retain) FPGetPhotosByTagRequestData *requestData;

+ (id)requestWithRequestData:(FPGetPhotosByTagRequestData*)data delegate:(id)delegate;

@end

