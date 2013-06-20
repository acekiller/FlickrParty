//
//  FPPhotoListCell.h
//  FlickrParty
//
//  Created by Bi Chen Ka Kit on 13年6月20日.
//  Copyright (c) 2013年 biworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FPPhoto;
@interface FPPhotoListCell : UITableViewCell

@property (nonatomic, retain) FPPhoto *photo;

@property (nonatomic, assign) id delegate;

@property (retain, nonatomic) IBOutlet UIImageView *photoImageView;


@end
