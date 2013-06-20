//
//  FPGetPhotosByTagRequest.m
//  FlickrParty
//
//  Created by Bi Chen Ka Kit on 13年6月20日.
//  Copyright (c) 2013年 biworks. All rights reserved.
//

#import "FPGetPhotosByTagRequest.h"
#import "FPGetPhotosByTagRequestData.h"
#import "FPGetPhotosByTagResponseData.h"
#import "ASIFormDataRequest.h"

#define API_KEY @"e0fa89dd02b957ed686ea55e53763747"

@implementation FPGetPhotosByTagRequest

+ (id)requestWithRequestData:(FPGetPhotosByTagRequestData*)data delegate:(id)delegate
{
    return [[[self alloc]initWithRequestData:data delegate:delegate]autorelease];
}

- (id)initWithRequestData:(FPGetPhotosByTagRequestData*)data delegate:(id)delegate
{
    self = [super initWithDelegate:delegate];
    if (self) {
        self.requestData = data;
    }
    return self;
}

- (NSString *)urlString
{
    NSString *urlString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&format=json&nojsoncallback=1&per_page=50&page=%d",API_KEY,self.requestData.tag,self.requestData.page];
    return urlString;
}

- (void)retrieve
{
    NSLog(@"URL = %@",[self url]);
    
    NSURL *urlToRequest = [self url];
    
    if (!urlToRequest){
        return;
    }
    
    self.request = [ASIFormDataRequest requestWithURL:urlToRequest];
    
    for (NSString *key in [self.parameters allKeys]) {
        [(ASIFormDataRequest*)self.request setPostValue:[self.parameters objectForKey:key] forKey:key];
    }
    
    [self.request setValidatesSecureCertificate:NO];
    [self.request setRequestMethod:@"GET"];
	self.request.delegate = self;
    self.request.timeOutSeconds = 30;
	[self.request startAsynchronous];
    
	[self retain];
	[self.delegate retain];
}

- (FPGetPhotosByTagResponseData *)responseHandlerWithResponse:(NSString*)response
{
    return [FPGetPhotosByTagResponseData responseWithString:response];
}

- (void)responseToDelegate
{
    if ([self.delegate respondsToSelector:@selector(FPGetPhotosByTagRequestRequestDidFinish:)]) {
        [self.delegate FPGetPhotosByTagRequestRequestDidFinish:self.response];
    }
}

- (void)dealloc
{
    [_requestData release];
    [super dealloc];
}

@end