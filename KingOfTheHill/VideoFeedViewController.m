//
//  VideoFeedViewController.m
//  KingOfTheHill
//
//  Created by Ryan S. Watt on 3/12/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "VideoFeedViewController.h"
#import "VideoFeedTableViewCell.h"
#import "VideoFeedDataSource.h"
#import "Video.h"
#import "VideoController.h"
#import "AnnotationVideoPlayerViewViewController.h"
#import "LoadingStatus.h"


@interface VideoFeedViewController () <UITableViewDelegate, Player>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) VideoFeedDataSource *dataSource;

@property (nonatomic, strong) UIButton *headerButton;

@end

@implementation VideoFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [VideoFeedDataSource new];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(-15, 0, self.view.frame.size.width, self.view.frame.size.height + 10) style:UITableViewStylePlain];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.delegate = self;
    
    [self.dataSource registerTableView:self.tableView];
    self.tableView.dataSource = _dataSource;

    [self.view addSubview:self.tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    UIImage *image = [VideoController sharedInstance].arrayOfThumbnails[indexPath.row];
    UIImageView *thumbnailView = [[UIImageView alloc] initWithImage:image];
    return thumbnailView.frame.size.height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self bringUpPlayer:indexPath.row];
    NSLog(@"Selected Row %ld", (long)indexPath.row);
}

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
}

@end
