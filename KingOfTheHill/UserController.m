//
//  UserController.m
//  KingOfTheHill
//
//  Created by Gabriel Guerrero on 3/13/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "UserController.h"

@implementation UserController

+ (UserController *)sharedInstance {
    
    static UserController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[UserController alloc] init];
    });
    return sharedInstance;
}

- (void)getProfileForCurrentUser:(User *)user
{
    self.currentUser = user[objectIdKey];
    self.currentUser.username = user.username;
    self.currentUser.email = user.email;
}

- (void)getProfileForUser:(User *)user
{
    user = user[userKey];
    user.email = user[emailKey];
}


- (NSUInteger)getAllVotesByUser
{
    return self.currentUser.userVote;
}

- (void)videoToUser:(Video *)video
{
    video.user = [UserController sharedInstance].currentUser;
    
    [video.user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
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


@end
