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

@interface VideoFeedViewController () <UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) VideoFeedDataSource *dataSource;

@end

@implementation VideoFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [VideoFeedDataSource new];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(-15, 0, self.view.frame.size.width + 15, self.view.frame.size.height) style:UITableViewStylePlain];
//    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.delegate = self;
    
    
    [self.dataSource registerTableView:self.tableView];
    self.tableView.dataSource = _dataSource;
    
//    UITapGestureRecognizer *snowboardTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToSnowboardFeed:)];
//    [snowboardTapGesture setNumberOfTouchesRequired:1];
//    [snowboarderView addGestureRecognizer:snowboardTapGesture];
    [self.view addSubview:self.tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Video *video = [VideoController sharedInstance].arrayOfVideos[indexPath.row];
    PFFile *thumbnailImage = video[urlOfThumbnail];
    NSURL *urlOfThumbnail = [NSURL URLWithString:thumbnailImage.url];
    NSData *dataOfThumbnail = [NSData dataWithContentsOfURL:urlOfThumbnail];
    UIImage *image = [UIImage imageWithData:dataOfThumbnail];
    UIImageView *thumbnailView = [[UIImageView alloc] initWithImage:image];
    return thumbnailView.frame.size.height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
