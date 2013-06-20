//
//  FPBaseViewController.m
//  FlickrParty
//
//  Created by KK Chen on 20/6/13.
//  Copyright (c) 2013 biworks. All rights reserved.
//

#import "FPBaseViewController.h"

@interface FPBaseViewController ()

@end

@implementation FPBaseViewController

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
	// Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_wild_oliva"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showHUDLoadingViewWithTitle:(NSString *)title
{
    [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:NO];
    
    if (HUD.hidden || HUD == nil) {
        HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        HUD.delegate = self;
    }
    HUD.square = YES;
    [self.navigationController.view addSubview:HUD];
    HUD.labelText = title;
    [HUD show:YES];
}

- (void)showHUDErrorViewWithMessage:(NSString *)message
{
    [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:NO];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:HUD];
	HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_error"]] autorelease];
	HUD.mode = MBProgressHUDModeCustomView;
	HUD.delegate = self;
	HUD.labelText = message;
    [HUD show:YES];
    [HUD hide:YES afterDelay:1];
}

- (void)hideHUDLoadingView{
    
    [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:NO];
    
    if (HUD.hidden == NO) {
        [HUD hide:YES];
    }
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	[HUD removeFromSuperview];
	[HUD release];
	HUD = nil;
}

@end
