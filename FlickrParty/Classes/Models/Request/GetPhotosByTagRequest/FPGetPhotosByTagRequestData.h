//
//  FPGetPhotosByTagRequestData.h
//  FlickrParty
//
//  Created by Bi Chen Ka Kit on 13年6月20日.
//  Copyright (c) 2013年 biworks. All rights reserved.
//

#import "SPBaseRequestData.h"

@interface FPGetPhotosByTagRequestData : SPBaseRequestData

@property (nonatomic, retain) NSString *tag;
@property (nonatomic, assign) NSInteger page;

+(id)dataWithTag:(NSString *)tag page:(NSInteger)page;
-(id)initWithTag:(NSString *)tag page:(NSInteger)page;

@end
