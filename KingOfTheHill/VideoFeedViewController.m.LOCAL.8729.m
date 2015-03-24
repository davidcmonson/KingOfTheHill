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
//#import "LocationViewController.h"
#import "LoadingStatus.h"
#import "SectionHeaderView.h"

@interface VideoFeedViewController () <UITableViewDelegate>

//@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) VideoFeedDataSource *dataSource;

@property (nonatomic, strong) UIButton *headerButton;

@end

@implementation VideoFeedViewController

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
    NSLog(@"Selected Row %ld", indexPath.row);
    [self bringUpPlayer:indexPath.row];
    
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    CGRect frame = CGRectMake(0, 0, tableView.frame.size.width, [SectionHeaderView headerHeight]);
    
    SectionHeaderView *sectionHeader = [[SectionHeaderView alloc] initWithFrame:frame];
    [sectionHeader updateWithUserName:@"Ted" votes:1 andUpVotes:self.headerButton];
    
    return sectionHeader;
    
}

//

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)bringUpPlayer:(NSInteger)index {
    
    AnnotationVideoPlayerViewViewController *videoVC = [AnnotationVideoPlayerViewViewController new];
    videoVC.videoAtIndex = index;
    videoVC.edgesForExtendedLayout = UIRectEdgeNone;
    videoVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    videoVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;;
    [self presentViewController:videoVC animated:YES completion:nil];
    
    //    if (!UIAccessibilityIsReduceTransparencyEnabled) {
    //        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    //        UIVisualEffectView *viewWithBlurredBackground = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    //        viewWithBlurredBackground.frame = self.view.bounds;
    //        [self.view addSubview:viewWithBlurredBackground];
    
    //only apply the blur if the user hasn't disabled transparency effects
    
    //if you have more UIViews on screen, use insertSubview:belowSubview: to place it underneath the lowest view
    
    //add auto layout constraints so that the blur fills the screen upon rotating device
    //viewWithBlurredBackground.setTranslatesAutoresizingMaskIntoConstraints(false);
    //        self.view.addConstraint(NSLayoutConstraint(item: blurEffectView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0));
    //        self.view.addConstraint(NSLayoutConstraint(item: blurEffectView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0));
    //        self.view.addConstraint(NSLayoutConstraint(item: blurEffectView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0));
    //        self.view.addConstraint(NSLayoutConstraint(item: blurEffectView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0));
    //    } else {
    //        self.view.backgroundColor = [UIColor blackColor];
    //    }
}




@end