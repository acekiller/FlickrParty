//
//  FPBaseViewController.h
//  FlickrParty
//
//  Created by KK Chen on 20/6/13.
//  Copyright (c) 2013 biworks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface FPBaseViewController : UIViewController<MBProgressHUDDelegate>
{
	MBProgressHUD *HUD;
}

- (void)showHUDLoadingViewWithTitle:(NSString *)title;
- (void)showHUDErrorViewWithMessage:(NSString *)message;
- (void)hideHUDLoadingView;

@end
