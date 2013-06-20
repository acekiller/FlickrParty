//
//  FPAlbumViewController.m
//  FlickrParty
//
//  Created by KK Chen on 20/6/13.
//  Copyright (c) 2013 biworks. All rights reserved.
//

#import "FPAlbumViewController.h"
#import "FPPhoto.h"
#import "FPPhotoGridCell.h"
#import "FPPhotoListCell.h"
#import "FPGetPhotosByTagRequest.h"
#import "FPGetPhotosByTagRequestData.h"
#import "FPGetPhotosByTagResponseData.h"
#import "FPPhotoViewController.h"

@interface FPAlbumViewController ()

@end

@implementation FPAlbumViewController

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
    if (_refreshHeaderView == nil) {
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.photoTableVIew.bounds.size.height, self.navigationController.view.frame.size.width, self.photoTableVIew.bounds.size.height)];
		view.delegate = self;
		[self.photoTableVIew addSubview:view];
		_refreshHeaderView = view;
		[view release];
	}
    self.nextPage = 1;
    [self setIsGridViewButton:NO];
    [self sendGetPhotosByTagRequest:@"party" page:self.nextPage];
    
    [self.navigationItem setTitleView:[[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo_partytime"]]autorelease]];
    
}

- (void)setIsGridViewButton:(BOOL)isGridView
{
    if (!isGridView) {
        
        
        UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [barButton setFrame:CGRectMake(0, 0, 30, 31)];
        [barButton setImage:[UIImage imageNamed:@"button_grid"] forState:UIControlStateNormal];
        [barButton addTarget:self action:@selector(viewStyleButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:barButton];
        [self.navigationItem setRightBarButtonItem:barButtonItem];
        [barButtonItem release];
        self.isGridView = NO;

    }else{
        
        UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [barButton setFrame:CGRectMake(0, 0, 30, 31)];
        [barButton setImage:[UIImage imageNamed:@"button_list"] forState:UIControlStateNormal];
        [barButton addTarget:self action:@selector(viewStyleButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:barButton];
        [self.navigationItem setRightBarButtonItem:barButtonItem];
        [barButtonItem release];
        self.isGridView = YES;
        
    }
    [self.photoTableVIew reloadData];
}

- (IBAction)viewStyleButtonPressed:(id)sender{
    UIButton *rightButton = sender;
    if (self.isGridView) {
        self.isGridView = NO;
        [rightButton setImage:[UIImage imageNamed:@"button_grid"] forState:UIControlStateNormal];
    }else{
        self.isGridView = YES;
        [rightButton setImage:[UIImage imageNamed:@"button_list"] forState:UIControlStateNormal];
    }
    [self.photoTableVIew reloadData];
    [self.photoTableVIew scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_photoTableVIew release];
    [_photos release];
    [super dealloc];
}

- (void)sendGetPhotosByTagRequest:(NSString *)tag page:(NSInteger)page
{
    FPGetPhotosByTagRequestData *data = [FPGetPhotosByTagRequestData dataWithTag:tag page:page];
    FPGetPhotosByTagRequest *request = [FPGetPhotosByTagRequest requestWithRequestData:data delegate:self];
    [request retrieve];
    if (!_reloading) {
        [self showHUDLoadingViewWithTitle:@"Loading..."];
    }
}

- (void)FPGetPhotosByTagRequestRequestDidFinish:(FPGetPhotosByTagResponseData*)response
{
    if (_reloading) {
        self.nextPage = 1;
        [self doneLoadingTableViewData];
    }else{
        [self hideHUDLoadingView];
    }
    FPGetPhotosByTagResponseData *data = response;
    if (data.succeed) {
        if (self.photos) {
            [self.photos addObjectsFromArray:data.photos];
        }else{
            self.photos = data.photos;
        }
        if (data.page == [data.pages integerValue]) {
            //Handle Last Page
            self.nextPage = 0;
        }else{
            self.nextPage ++;
        }
        [self.photoTableVIew reloadData];
    }else{
        [self showHUDErrorViewWithMessage:data.error];
    }
}

#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 && self.photos) {
        if (self.isGridView) {
            NSInteger photoNumberPerCell = 3;
            NSInteger wholeRow = [self.photos count]/photoNumberPerCell;
            if( [self.photos count]%photoNumberPerCell == 0 )
                return wholeRow;
            else {
                return wholeRow + 1;
            }
        }else
        {
            return [self.photos count];
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && self.photos) {
        if (self.isGridView) {
            static NSString *CellIdentifier = @"FPPhotoGridCell";
            
            FPPhotoGridCell *cell = (FPPhotoGridCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell == nil)
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"FPPhotoGridCell" owner:nil options:nil] objectAtIndex:0 ];
            }
            cell.delegate = self;
            NSInteger postNumber = 3;
            NSInteger cellNumber = indexPath.row * postNumber;
            NSMutableArray *mutableArray = [[[NSMutableArray alloc] initWithCapacity:3] autorelease];
            for( int i=0; i<postNumber; i++ )
            {
                if( cellNumber <= [self.photos count]-1 )
                {
                    FPPhoto *product = [self.photos objectAtIndex:cellNumber];
                    [mutableArray addObject:product];
                }
                cellNumber ++;
            }
            [cell setPhotos:mutableArray];
            return cell;
        }else{
            static NSString *CellIdentifier = @"FPPhotoListCell";
            
            FPPhotoListCell *cell = (FPPhotoListCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell == nil)
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"FPPhotoListCell" owner:nil options:nil] objectAtIndex:0 ];
            }
            cell.delegate = self;
            FPPhoto *photo = [self.photos objectAtIndex:indexPath.row];
            cell.photo = photo;
            return cell;
        }
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isGridView) {
        return 110;
    }
    return 310;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        if (self.nextPage == 0) {
            return 0;
        }
        if (self.photos && self.photos.count != 0) {
            return 50;
        }
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *view = [[[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f - self.photoTableVIew.bounds.size.height, self.navigationController.view.frame.size.width, 50)]autorelease];
        [view setBackgroundColor:[UIColor clearColor]];
        UILabel *label = [[[UILabel alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.navigationController.view.frame.size.width, 50)]autorelease];
        [label setFont:[UIFont fontWithName:@"Cubano-Regular" size:20]];
        [label setText:@"Loading"];
        [label setTextColor:[UIColor whiteColor]];
        [label setCenter:view.center];
        [view addSubview:label];
        if (!_reloading) {
            [self sendGetPhotosByTagRequest:@"tag" page:self.nextPage];
        }
        return view;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.isGridView) {
        FPPhotoViewController *viewController = [[FPPhotoViewController alloc]initWithNibName:@"FPPhotoViewController" bundle:nil];
        viewController.photo = [self.photos objectAtIndex:indexPath.row];
        [self.navigationController presentViewController:viewController animated:YES completion:nil];
        [viewController release];
    }
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)reloadAll{
    _reloading = YES;
    [self.photoTableVIew reloadData];
	[self sendGetPhotosByTagRequest:@"party" page:self.nextPage];
}

- (void)reloadTableViewDataSource{
	_reloading = YES;
    [self.photoTableVIew reloadData];
    self.nextPage = 1;
	[self sendGetPhotosByTagRequest:@"party" page:self.nextPage];
}

- (void)doneLoadingTableViewData{
	_reloading = NO;
    if (self.photoTableVIew && _refreshHeaderView) {
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.photoTableVIew];
    }
	
}

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	[self reloadTableViewDataSource];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	return _reloading;
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	return [NSDate date];
	
}

- (void)FPPhotoGridCellDidSelectPhoto:(FPPhoto *)photo
{
    FPPhotoViewController *viewController = [[FPPhotoViewController alloc]initWithNibName:@"FPPhotoViewController" bundle:nil];
    viewController.photo = photo;
    [self.navigationController presentViewController:viewController animated:YES completion:nil];
    [viewController release];
}

#pragma mark - ScrollView Delegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}


@end
