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
    
    return [VideoController sharedInstance].arrayOfVideoForFeed.count;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    self.cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([VideoFeedTableViewCell class])];
    self.cell.imageView.image = [VideoController sharedInstance].arrayOfThumbnails[indexPath.row];
    self.cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    UITapGestureRecognizer *newGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ifWorks:)];
    [newGesture setNumberOfTapsRequired:2];
    [self.cell.contentView addGestureRecognizer:newGesture];
    
    UITapGestureRecognizer *newOneTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(putPlayer)];
    [newOneTapGesture setNumberOfTapsRequired:1];
    [self.cell.contentView addGestureRecognizer:newOneTapGesture];
    
    [newOneTapGesture requireGestureRecognizerToFail:newGesture];
    
    self.votes = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 55, 55)];
    self.votes.text = @"Voterific";
    self.votes.textColor = [UIColor whiteColor];
    [self.cell.imageView addSubview:self.votes];
    return self.cell;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return NO;
}

- (void)putPlayer {
    NSLog(@"ONE TAP");
    
    PFFile *videoFile = [VideoController sharedInstance].arrayOfVideoForFeed[self.currentIndex.row][urlOfVideo];
    NSURL *videoURL = [NSURL URLWithString:videoFile.url];
    AVAsset *video = [AVAsset assetWithURL:videoURL];
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithAsset:video];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:item];
    
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:player];
    layer.frame = self.cell.contentView.frame;
    
    UIView *playerView = [[UIView alloc]initWithFrame:self.cell.contentView.bounds];
    [playerView.layer addSublayer:layer];

    [self.cell.contentView addSubview: playerView];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //[loadingStatus removeFromSuperviewWithFade];
        [player play];
        
    });

}

- (void)ifWorks:(id)sender {
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:self.arrayOfVotes];
    [array addObject:sender];
//    int number = (int)[array lastObject];
//    NSNumber *nsender = [NSNumber numberWithInt:number];
//    nsender = [NSNumber numberWithInt:number + 1];
    self.arrayOfVotes = array;
    
    self.votes.text = [NSString stringWithFormat:@"%ld", self.arrayOfVotes.count];
    
    NSLog(@"it works");
}

@end
