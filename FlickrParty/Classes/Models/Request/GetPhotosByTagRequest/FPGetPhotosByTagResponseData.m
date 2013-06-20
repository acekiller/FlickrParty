//
//  FPGetPhotosByTagResponseData.m
//  FlickrParty
//
//  Created by Bi Chen Ka Kit on 13年6月20日.
//  Copyright (c) 2013年 biworks. All rights reserved.
//

#import "FPGetPhotosByTagResponseData.h"
#import "NSString+SBJSON.h"
#import "FPPhoto.h"

@implementation FPGetPhotosByTagResponseData

- (void)dealloc
{
    [_pages release];
    [_total release];
    [_photos release];
    [_stat release];
    [super dealloc];
}

- (void)processResponseString
{
    NSDictionary *data =  [self.responseString JSONValue];
    if ([self isNormalResponse:data]) {
        self.succeed = YES;
        NSDictionary *responseDictionary = [data objectForKey:@"photos"];
        self.page = [[responseDictionary objectForKey:@"page"]integerValue];
        self.pages = [responseDictionary objectForKey:@"pages"];
        self.perPage = [[responseDictionary objectForKey:@"perpage"]integerValue];
        self.total = [responseDictionary objectForKey:@"total"];
        self.photos = [NSMutableArray array];
        NSArray *photos = [responseDictionary objectForKey:@"photo"];
        for (NSDictionary *dictionary in photos) {
            FPPhoto *photo = [FPPhoto photoWithDictionary:dictionary];
            [self.photos addObject:photo];
        }
        
    }else{
        self.succeed = NO;
        [self handleErrorResponse:data];
    }
}

- (BOOL)isNormalResponse:(id)response
{
    if (response) {
        NSString *stat = [response objectForKey:@"stat"];
        if ([stat isEqualToString:@"ok"]) {
            return YES;
        }
    }
    return NO;
}

- (void)handleErrorResponse:(NSDictionary*)resposne
{
    NSDictionary *meta = [resposne objectForKey:@"stat"];
    self.error = self.errorMessage = [meta objectForKey:@"message"];
}


@end
