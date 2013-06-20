//
//  FPPhotoViewController.m
//  FlickrParty
//
//  Created by KK Chen on 20/6/13.
//  Copyright (c) 2013 biworks. All rights reserved.
//

#import "FPPhotoViewController.h"
#import "FPPhoto.h"
#import "UIImageView+WebCache.h"

@interface FPPhotoViewController ()

@end

@implementation FPPhotoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.photoImageView setImageWithURL:self.photo.imageURL];
    [self.photoTitleView setText:self.photo.title];
    [self.photoTitleView setFont:[UIFont fontWithName:@"Cubano-Regular" size:20]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_photoImageView release];
    [_photoTitleView release];
    [_photo release];
    [super dealloc];
}

- (IBAction)closeButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
