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

@interface VideoFeedViewController () <UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) VideoFeedDataSource *dataSource;

@end

@implementation VideoFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [VideoFeedDataSource new];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.delegate = self;
    
    
    [self.dataSource registerTableView:self.tableView];
    self.tableView.dataSource = _dataSource;
    
//    UITapGestureRecognizer *snowboardTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToSnowboardFeed:)];
//    [snowboardTapGesture setNumberOfTouchesRequired:1];
//    [snowboarderView addGestureRecognizer:snowboardTapGesture];
    [self.view addSubview:self.tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [VideoFeedTableViewCell cellHeight];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
