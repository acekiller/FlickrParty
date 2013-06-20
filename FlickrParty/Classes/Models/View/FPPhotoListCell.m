//
//  FPPhotoListCell.m
//  FlickrParty
//
//  Created by Bi Chen Ka Kit on 13年6月20日.
//  Copyright (c) 2013年 biworks. All rights reserved.
//

#import "FPPhotoListCell.h"
#import "FPPhoto.h"
#import "UIImageView+WebCache.h"
#import <QuartzCore/QuartzCore.h>

@implementation FPPhotoListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.photoImageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.photoImageView.layer setCornerRadius:5.0f];
    [self.photoImageView.layer setMasksToBounds:YES];
}

- (void) setPhoto:(FPPhoto *)photo
{
    if (_photo!= photo)
    {
        [_photo release];
        _photo = [photo retain];
    }
    [self.photoImageView setImageWithURL:self.photo.imageURL];
}

- (void)dealloc
{
    [_photo release];
    [_photoImageView release];
    [super dealloc];
}

@end
