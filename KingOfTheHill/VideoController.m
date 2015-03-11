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

//- (void)relationshipBetweenVideoAndUser
//{
//    // create user object
//    PFObject *user = [PFObject objectWithClassName:@"User"];
//    
//    // user video
//    PFObject *video = [PFObject objectWithClassName:@"Video"];
//    
//    // set who the video is creatd by
//    [video setObject:user forKeyedSubscript:@"ownerOfVideo"];
//}
//
//- (void)relationshipBetweenVoteAndVideo
//{
//    PFObject *video = [PFObject objectWithClassName:@"video"];
//    
//    PFObject *vote = [PFObject objectWithClassName:@"vote"];
//    
//    [vote setObject:video forKeyedSubscript:@"voteSetOnVideo"];
//}

- (void)videoToParse
{
    Video *video = (Video *)[PFObject objectWithClassName:videoKey];
    video[titleOfVideoKey] = video.titleOfVideo;
    video[ownerOfVideoKey] = video.ownerOfVideo;
#warning come back here
    //    video[coordinateOfVideoKey] = video.coordinate;
    [video pin];
    [video saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"videoKey saved");
        }
        else {
            NSLog(@"%@", error);
        }
    }];
}

- (void)userToParse
{
    User *user = (User *)[PFObject objectWithClassName:userKey];
    user[userVideoKey] = user.video;
    user[userVoteKey] = user.votes;
    [user pin];
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"userKey saved");
                  }
                  else {
                      NSLog(@"%@", error);
                  }
                  }];
}

- (void)userToVoteToVideo
{
    PFObject *likedVideo = [PFObject objectWithClassName:videoKey];
    PFObject *vote = [PFObject objectWithClassName:voteKey];
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
