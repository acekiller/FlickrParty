//
//  FPGetPhotosByTagRequestData.m
//  FlickrParty
//
//  Created by Bi Chen Ka Kit on 13年6月20日.
//  Copyright (c) 2013年 biworks. All rights reserved.
//

#import "FPGetPhotosByTagRequestData.h"

@implementation FPGetPhotosByTagRequestData

- (void)dealloc
{
    [_tag release];
    [super dealloc];
}

+(id)dataWithTag:(NSString *)tag page:(NSInteger)page
{
    return [[[self alloc]initWithTag:tag page:page]autorelease];
}

-(id)initWithTag:(NSString *)tag page:(NSInteger)page
{
    self = [super init];
    if (self) {
        self.tag = tag;
        self.page = page;
    }
    return self;
}


@end
