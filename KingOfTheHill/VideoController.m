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


- (void)userToParse//:(User *)user video:(Video *)video
{
#warning if (user) & if (video) stuff
    User *user = (User *)[PFObject objectWithClassName:userKey];
    user[usernameKey] = user.username;
    user[passwordKey] = user.password;
    user[emailKey] = user.email;
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"userKey saved");
        }
        else {
            NSLog(@"%@", error);
        }
    }];
}

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