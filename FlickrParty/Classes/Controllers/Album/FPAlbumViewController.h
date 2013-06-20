//
//  FPAlbumViewController.h
//  FlickrParty
//
//  Created by KK Chen on 20/6/13.
//  Copyright (c) 2013 biworks. All rights reserved.
//

#import "FPBaseViewController.h"
#import "EGORefreshTableHeaderView.h"

@interface FPAlbumViewController : FPBaseViewController
<EGORefreshTableHeaderDelegate, UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate>{
	EGORefreshTableHeaderView *_refreshHeaderView;
	BOOL _reloading;
}

@property (retain, nonatomic) IBOutlet UITableView *photoTableVIew;
@property (retain, nonatomic) NSMutableArray *photos;
@property (assign, nonatomic) BOOL isGridView;
@property (assign, nonatomic) NSInteger nextPage;

@end
