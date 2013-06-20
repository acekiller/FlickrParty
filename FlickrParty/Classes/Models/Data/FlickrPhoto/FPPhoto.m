//
//  FPPhoto.m
//  FlickrParty
//
//  Created by Bi Chen Ka Kit on 13年6月20日.
//  Copyright (c) 2013年 biworks. All rights reserved.
//

#import "FPPhoto.h"

@implementation FPPhoto

- (void)dealloc
{
    [_photoId release];
    [_owner release];
    [_secret release];
    [_server release];
    [_title release];
    [_imageURL release];
    [super dealloc];
}

+(id)photoWithDictionary:(NSDictionary *)dictionary
{
    return [[[self alloc]initWithDictionary:dictionary]autorelease];
}

-(id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.photoId = [dictionary objectForKey:@"id"];
        self.owner = [dictionary objectForKey:@"owner"];
        self.secret = [dictionary objectForKey:@"secret"];
        self.server = [dictionary objectForKey:@"server"];
        self.farm = [[dictionary objectForKey:@"farm"]integerValue];
        self.title = [dictionary objectForKey:@"title"];
        NSString *imageURLString = [NSString stringWithFormat:@"http://farm%d.staticflickr.com/%@/%@_%@.jpg",self.farm,self.server,self.photoId,self.secret];
        NSString *thumbnailURLString = [NSString stringWithFormat:@"http://farm%d.staticflickr.com/%@/%@_%@_m.jpg",self.farm,self.server,self.photoId,self.secret];
        self.imageURL = [NSURL URLWithString:imageURLString];
        self.thumbnailURL = [NSURL URLWithString:thumbnailURLString];
    }
    return self;
}

@end
