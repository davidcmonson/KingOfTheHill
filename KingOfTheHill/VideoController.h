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

@property (nonatomic, strong) NSArray *arrayOfVideoForFeed;
@property (nonatomic, strong) NSArray *arrayOfVideosNearLocation;
@property (nonatomic ,strong) NSArray *arrayOfThumbnails;

+ (VideoController *)sharedInstance;
+ (void)queryVideosForFeed;
- (void)videoToParseWithFile:(PFFile *)file;
- (void)userToVoteToVideo:(Video *)video;
- (NSInteger)totalVotesOnVideoWithIdentifier:(NSString *)identifier;

@end

