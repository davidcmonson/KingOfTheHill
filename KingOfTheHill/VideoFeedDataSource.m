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
    
    [self.presentVideoGesture requireGestureRecognizerToFail:self.presentVoteGesture];
    
    self.votes = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 55, 55)];
    self.votes.text = [NSString stringWithFormat:@"%ld", (long)[VideoController sharedInstance].arrayOfVotes.count];
    self.votes.textColor = [UIColor blackColor];
    [self.cell.imageView addSubview:self.votes];
    return self.cell;
}


@end
