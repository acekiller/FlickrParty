//
//  FPPhotoGridCell.m
//  FlickrParty
//
//  Created by Bi Chen Ka Kit on 13年6月20日.
//  Copyright (c) 2013年 biworks. All rights reserved.
//

#import "FPPhotoGridCell.h"
#import <QuartzCore/QuartzCore.h>
#import "FPPhoto.h"
#import "UIButton+WebCache.h"

@implementation FPPhotoGridCell

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

- (void)dealloc
{
    [_photos release];
    [_photoViews release];
    [super dealloc];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.photoViews = [self.photoViews sortedArrayWithOptions:NSSortStable
                                            usingComparator:^NSComparisonResult(UIView *obj1, UIView *obj2) {
                                                if (obj1.tag > obj2.tag) {
                                                    return NSOrderedDescending;
                                                } else if (obj1.tag < obj2.tag) {
                                                    return NSOrderedAscending;
                                                }
                                                return NSOrderedSame;
                                            }];
    self.photoButtons = [self.photoButtons sortedArrayWithOptions:NSSortStable
                                                                usingComparator:^NSComparisonResult(UIButton *obj1, UIButton *obj2) {
                                                                    if (obj1.tag > obj2.tag) {
                                                                        return NSOrderedDescending;
                                                                    } else if (obj1.tag < obj2.tag) {
                                                                        return NSOrderedAscending;
                                                                    }
                                                                    return NSOrderedSame;
                                                                }];
    for (UIButton *button in self.photoButtons) {
        [button.imageView setContentMode:UIViewContentModeScaleAspectFill];
        [button.imageView.layer setCornerRadius:5.0f];
        [button.imageView.layer setMasksToBounds:YES];
    }
}

- (void)setPhotos:(NSMutableArray *)photos{
    if (_photos!= photos)
    {
        [_photos release];
        _photos = [photos retain];
    }
    
    for (UIView *view in self.photoViews) {
        view.hidden = YES;
    }
    for (NSInteger i = 0;i < self.photos.count; i++) {
        UIView *photoView = [self.photoViews objectAtIndex:i];
        photoView.hidden = NO;
        FPPhoto *photo = [self.photos objectAtIndex:i];
        UIButton *button = [self.photoButtons objectAtIndex:i];
        [button setImageWithURL:photo.thumbnailURL forState:UIControlStateNormal];
    }
}

- (IBAction)imageButtonPressed:(id)sender {
    UIButton *button = sender;
    if ([self.delegate respondsToSelector:@selector(FPPhotoGridCellDidSelectPhoto:)]) {
        [self.delegate FPPhotoGridCellDidSelectPhoto:[self.photos objectAtIndex:button.tag]];
    }
}

@end
