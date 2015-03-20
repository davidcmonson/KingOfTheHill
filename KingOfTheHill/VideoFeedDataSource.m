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

@property (nonatomic, strong) UITapGestureRecognizer *presentVideoGesture;
@property (nonatomic, strong) UITapGestureRecognizer *presentVoteGesture;

@end

@implementation VideoFeedDataSource

//- (void)registerForNotifications
//{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ifWorks:) name:@"upVote" object:nil];
//}

- (void)registerTableView:(UITableView *)tableView {
    
    [tableView registerClass:[VideoFeedTableViewCell class] forCellReuseIdentifier:NSStringFromClass([VideoFeedTableViewCell class])];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [VideoController sharedInstance].arrayOfVideoForFeed.count;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    self.cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([VideoFeedTableViewCell class])];
    self.cell.imageView.image = [VideoController sharedInstance].arrayOfThumbnails[indexPath.row];
    self.cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.presentVoteGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ifWorks:)];
    [self.presentVoteGesture setNumberOfTapsRequired:2];
    [self.cell.contentView addGestureRecognizer:self.presentVoteGesture];
    
    self.presentVideoGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(putPlayer:)];
    [self.presentVideoGesture setNumberOfTapsRequired:1];
    [self.cell.contentView addGestureRecognizer:self.presentVideoGesture];
    
    [self.presentVideoGesture requireGestureRecognizerToFail:self.presentVoteGesture];
    
    self.votes = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 55, 55)];
    self.votes.text = @"";
    self.votes.textColor = [UIColor whiteColor];
    [self.cell.imageView addSubview:self.votes];
    return self.cell;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return NO;
}

- (void)putPlayer:(id)sender {
    
    if (self.presentVideoGesture) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"presentVideo" object:nil];
    }
//    else if (self.presentVoteGesture) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"upVote" object:nil];
//    }

    
    
//    [self imageAtIndexPath]
//    PFFile *videoFile = [VideoController sharedInstance].arrayOfVideoForFeed[self.currentIndex.row][urlOfVideo];
//    NSURL *videoURL = [NSURL URLWithString:videoFile.url];
//    AVAsset *video = [AVAsset assetWithURL:videoURL];
//    AVPlayerItem *item = [[AVPlayerItem alloc] initWithAsset:video];
//    AVPlayer *player = [AVPlayer playerWithPlayerItem:item];
//    
//    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:player];
//    layer.frame = self.cell.contentView.frame;
//    
//    UIView *playerView = [[UIView alloc]initWithFrame:self.cell.contentView.bounds];
//    [playerView.layer addSublayer:layer];
//
//    [self.cell.contentView addSubview: playerView];
//    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        //[loadingStatus removeFromSuperviewWithFade];
//        [player play];
    
//    });

}

- (void)ifWorks:(id)sender {
    
//    [self imageAtIndexPath]
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:[VideoController sharedInstance].arrayOfVotes];
    [array addObject:sender];
    [array lastObject];
    [VideoController sharedInstance].arrayOfVotes = array;
    
    self.votes.text = [NSString stringWithFormat:@"%ld", (long)[VideoController sharedInstance].arrayOfVotes.count];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"turnOffVote" object:nil];
    NSLog(@"vote");
}

- (void)deregisterNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"turnOffVote" object:nil];
}

- (void)dealloc
{
    [self deregisterNotifications];
}

@end
