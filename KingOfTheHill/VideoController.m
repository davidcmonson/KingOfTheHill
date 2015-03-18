//
//  UserController.m
//  KingOfTheHill
//
//  Created by Gabriel Guerrero on 3/5/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import <CloudKit/CloudKit.h>
#import "VideoController.h"

@implementation VideoController

+ (VideoController *)sharedInstance {
    
    static VideoController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[VideoController alloc] init];
    });
    return sharedInstance;
}

- (void)videoToParseWithFile:(PFFile *)file
{
    Video *video = (Video *)[PFObject objectWithClassName:videoKey];
    //video[@"name"] = video.nameOfVideo;
    video[@"videoFile"] = file;
#warning come back here
    //    video[coordinateOfVideoKey] = video.coordinate;
    // [video pin];
    [video saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"videoKey saved");
        }
        else {
            NSLog(@"%@", error);
        }
    }];
}

// Method to fetch videos
//
//
//
//
//

- (void)userToVoteToVideo:(Video *)video
{
    PFObject *likedVideo = [PFObject objectWithClassName:videoKey];
    PFObject *vote = [PFObject objectWithClassName:voteKey];
#warning attach vote to Video
    [vote setObject:[PFUser currentUser] forKey:@"fromUser"];
    [vote setValue:likedVideo forKey:@"toVideo"];
    [vote saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"two way relation from user to vote to video saved");
        }
        else {
            NSLog(@"%@", error);
        }
    }];
}

- (NSInteger)totalVotesOnVideoWithIdentifier:(NSString *)identifier
{
    PFQuery *votesOnVideo = [PFQuery queryWithClassName:voteKey];
    [votesOnVideo whereKey:@"toVideo" equalTo:identifier];
    return [votesOnVideo countObjects];
}

@end