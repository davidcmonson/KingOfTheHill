//
//  VideoFeedViewController.m
//  KingOfTheHill
//
//  Created by Ryan S. Watt on 3/12/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//
#import "UIColor+AlphaRed.h"
#import "VideoFeedViewController.h"
#import "VideoFeedTableViewCell.h"
#import "VideoFeedDataSource.h"
#import "Video.h"
#import "VideoController.h"
#import "AnnotationVideoPlayerViewViewController.h"
#import "LoadingStatus.h"
#import "SectionHeaderView.h"
#import "Vote.h"

@interface VideoFeedViewController () <UITableViewDelegate>

//@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) VideoFeedDataSource *dataSource;

@property (nonatomic, strong) UIButton *headerButton;
@property (nonatomic, strong) Video *videoSelected;

@end

@implementation VideoFeedViewController

- (void)viewDidAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTable) name:@"updateCellVotes" object:nil];
    [self reloadTable];
}

- (void)reloadTable
{
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.dataSource = [VideoFeedDataSource new];
    self.dataSource.dimensionsOfScreen = self.view.frame;
    //self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor alphaRed];
    // This allows each cell to "snap" to the top/bottom edges as user scrolls through the cells
    //self.tableView.pagingEnabled = YES; // DISABLED: snaps weirdly
    
    [self.dataSource registerTableView:self.tableView];
    self.tableView.dataSource = _dataSource;
    
    //    UITapGestureRecognizer *snowboardTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToSnowboardFeed:)];
    //    [snowboardTapGesture setNumberOfTouchesRequired:1];
    //    [snowboarderView addGestureRecognizer:snowboardTapGesture];

    // Refresh Table View
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"
                                                                attributes: @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIRefreshControl *refresh = [UIRefreshControl new];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithAttributedString:title];
    refresh.tintColor = [UIColor whiteColor];
    [refresh addTarget:self action:@selector(refreshFeed) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    

}

-(void)refreshFeed {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [VideoController queryVideosForFeed];
        [self.tableView reloadData];
        [self stopRefresh];
    });
}

- (void)stopRefresh
{
    [self.refreshControl endRefreshing];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    UIImage *image = [VideoController sharedInstance].arrayOfThumbnails[indexPath.row];
    UIImageView *imageViewInCell = [[UIImageView alloc]initWithImage:image];
    imageViewInCell.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width);
    imageViewInCell.contentMode = UIViewContentModeScaleAspectFit;

    return self.view.frame.size.width;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.videoSelected = [Video new];
    self.videoSelected = [VideoController sharedInstance].arrayOfVideoForFeed[indexPath.row];
    
    [self bringUpPlayer:self.videoSelected];
    [self.tableView reloadData];
    NSLog(@"Selected Row %ld", (long)indexPath.row);
}

// add header view
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return [SectionHeaderView headerHeight];
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    
//    CGRect frame = CGRectMake(0, 0, tableView.frame.size.width, [SectionHeaderView headerHeight]);
//    
//    SectionHeaderView *sectionHeader = [[SectionHeaderView alloc] initWithFrame:frame];
//    [sectionHeader updateWithUserName:@"Ted" votes:1 andUpVotes:self.headerButton];
//    
//    return sectionHeader;
//    
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    
//    CGRect frame = CGRectMake(0, 0, tableView.frame.size.width, [SectionHeaderView headerHeight]);
//    
//    SectionHeaderView *sectionHeader = [[SectionHeaderView alloc] initWithFrame:frame];
//    [sectionHeader updateWithUserName:@"Ted" votes:1 andUpVotes:self.headerButton];
//    
//    return sectionHeader;
//    
//}

//

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)bringUpPlayer:(Video *)video {
    
    AnnotationVideoPlayerViewViewController *videoVC = [AnnotationVideoPlayerViewViewController new];

    [videoVC updateWithVideo:video];
    videoVC.edgesForExtendedLayout = UIRectEdgeNone;
    videoVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    videoVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:videoVC animated:YES completion:nil];
}

- (void)unregisterForNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"updateCellVotes" object:nil];
}

- (void)dealloc
{
    [self unregisterForNotifications];
}

@end
