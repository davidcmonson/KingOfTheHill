//
//  VideoFeedDataSource.m
//  KingOfTheHill
//
//  Created by Ryan S. Watt on 3/16/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "VideoFeedDataSource.h"
#import "VideoController.h"
#import "Video.h"

#import <Parse/Parse.h>
#import <AVFoundation/AVFoundation.h>

@interface VideoFeedDataSource () <UIGestureRecognizerDelegate>

@property (nonatomic) NSIndexPath *currentIndex;
@property (nonatomic, strong) VideoFeedTableViewCell *cell;
@property (nonatomic, strong) UILabel *votes;
@property (nonatomic, strong) NSArray *arrayOfVotes;

@end

@implementation VideoFeedDataSource

- (void)registerTableView:(UITableView *)tableView {
    
    [tableView registerClass:[VideoFeedTableViewCell class] forCellReuseIdentifier:NSStringFromClass([VideoFeedTableViewCell class])];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [VideoController sharedInstance].arrayOfVideoForFeed.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoFeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([VideoFeedTableViewCell class])];
    
    UIImage *thumbnail = [VideoController sharedInstance].arrayOfThumbnails[indexPath.row];
    UIImageView *imageViewInCell = [[UIImageView alloc]initWithImage:thumbnail];
    imageViewInCell.frame = CGRectMake(0, 0, self.dimensionsOfScreen.size.width, thumbnail.size.height);
    imageViewInCell.contentMode = UIViewContentModeScaleAspectFit;
    
    [cell.contentView addSubview:imageViewInCell];
    cell.contentView.backgroundColor = [UIColor blackColor];
    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    return cell;
}

@end
