//
//  FPPhotoGridCell.h
//  FlickrParty
//
//  Created by Bi Chen Ka Kit on 13年6月20日.
//  Copyright (c) 2013年 biworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FPPhoto;
@protocol FPPhotoGridCellDelegate <NSObject>

- (void)FPPhotoGridCellDidSelectPhoto:(FPPhoto *)photo;

@end

@interface FPPhotoGridCell : UITableViewCell

@property (nonatomic, retain) NSMutableArray *photos;
@property (nonatomic, retain) IBOutletCollection(UIView) NSArray *photoViews;
@property (nonatomic, retain) IBOutletCollection(UIButton) NSArray *photoButtons;

@property (nonatomic, assign) id delegate;

- (IBAction)imageButtonPressed:(id)sender;

@end
