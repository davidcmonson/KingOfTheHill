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
    
    return [VideoController sharedInstance].arrayOfVideoForFeed.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoFeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([VideoFeedTableViewCell class])];
    UIImage *thumbnail = [VideoController sharedInstance].arrayOfThumbnails[indexPath.row];
    cell.photoImageView.image = thumbnail;
    cell.contentView.backgroundColor = [UIColor blackColor];
    
    Video *currentVideo = [VideoController sharedInstance].arrayOfVideoForFeed[indexPath.row];
    
    [[VideoController sharedInstance] queryForVotesOnVideo:currentVideo];
    cell.voteCount.text = [NSString stringWithFormat:@"%lu", [VideoController sharedInstance].voteCount];
    
    //    NSMutableArray *mutable = [[NSMutableArray alloc] initWithArray:[VideoController sharedInstance].arrayOfVotes];
    //
    //    for (NSArray *array in mutable) {
    //
    //        for (NSInteger index = 0; index < array.count; index++)
    //        {
    //            NSArray *voteCount = mutable[indexPath.row];
    //           cell.voteCount.text = [NSString stringWithFormat:@"%ld", (long)voteCount.count];
    //        }
    //}
    
    //    for (NSArray *array in [VideoController sharedInstance].arrayOfVotes) {
    //        NSArray *voteCount = array[indexPath.row];
    //        cell.voteCount.text = [NSString stringWithFormat:@"%ld", (long)voteCount.count];
    //    }
    
    return cell;
}

@end
