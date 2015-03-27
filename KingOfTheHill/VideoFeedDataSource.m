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

@property (nonatomic, strong) NSArray *voteCount;

@end

@implementation VideoFeedDataSource

- (void)registerTableView:(UITableView *)tableView {
    
    [tableView registerClass:[VideoFeedTableViewCell class] forCellReuseIdentifier:NSStringFromClass([VideoFeedTableViewCell class])];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [VideoController sharedInstance].arrayOfThumbnails.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoFeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([VideoFeedTableViewCell class])];
    if (cell == nil){
        cell = [VideoFeedTableViewCell new];
    }
    UIImage *thumbnail = [VideoController sharedInstance].arrayOfThumbnails[indexPath.row];
    cell.photoImageView.image = thumbnail;
    cell.contentView.backgroundColor = [UIColor blackColor];
    
    //Video *currentVideo = [VideoController sharedInstance].arrayOfVideoForFeed[indexPath.row];
    //cell.arrayOfUsers = [[VideoController sharedInstance] queryForVotesOnVideo:currentVideo];
    NSArray *arrayOfUsersForCell = [VideoController sharedInstance].arrayOfArrayAllVotes[indexPath.row];
    cell.voteCount.text = [NSString stringWithFormat:@"%lu", arrayOfUsersForCell.count];
    
    return cell;
}


@end
