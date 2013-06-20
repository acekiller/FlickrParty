//
//  FPPhoto.h
//  FlickrParty
//
//  Created by Bi Chen Ka Kit on 13年6月20日.
//  Copyright (c) 2013年 biworks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FPPhoto : NSObject

@property (nonatomic, retain) NSString *photoId;
@property (nonatomic, retain) NSString *owner;
@property (nonatomic, retain) NSString *secret;
@property (nonatomic, retain) NSString *server;
@property (nonatomic, assign) NSInteger farm;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSURL *imageURL;
@property (nonatomic, retain) NSURL *thumbnailURL;

+(id)photoWithDictionary:(NSDictionary *)dictionary;
-(id)initWithDictionary:(NSDictionary *)dictionary;

@end
