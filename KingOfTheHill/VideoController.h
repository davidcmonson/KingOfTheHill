//
//  UserController.h
//  KingOfTheHill
//
//  Created by Gabriel Guerrero on 3/5/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "Video.h"
#import "Vote.h"

@interface VideoController : NSObject

@property (nonatomic, strong) NSArray *arrayOfVideos;

+ (VideoController *)sharedInstance;
//- (void)relationshipBetweenVideoAndUser;
//- (void)relationshipBetweenVoteAndVideo;
- (void)videoToParse;
- (void)userToParse;
- (void)userToVoteToVideo;
- (NSInteger)totalVotesOnVideoWithIdentifier:(NSString *)identifier;

@end
