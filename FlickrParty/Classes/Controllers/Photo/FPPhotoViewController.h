//
//  FPPhotoViewController.h
//  FlickrParty
//
//  Created by KK Chen on 20/6/13.
//  Copyright (c) 2013 biworks. All rights reserved.
//

#import "FPBaseViewController.h"

@class FPPhoto;
@interface FPPhotoViewController : FPBaseViewController

@property (retain, nonatomic) IBOutlet UIImageView *photoImageView;
@property (retain, nonatomic) IBOutlet UILabel *photoTitleView;
@property (nonatomic, retain) FPPhoto *photo;

@end
