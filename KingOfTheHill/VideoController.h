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

@property (nonatomic, strong) NSArray *objectArrayFromParse;

@property (nonatomic, strong) NSArray *arrayOfVideoForFeed;
@property (nonatomic, strong) NSArray *arrayOfVideosNearLocation;
@property (nonatomic ,strong) NSArray *arrayOfThumbnails;
@property (nonatomic, strong) NSArray *arrayOfVotes;
@property (nonatomic, strong) NSArray *votesSpecificToVideo;

@property (nonatomic, assign) NSInteger *videoIndex;

@property (nonatomic, assign) NSString *numberOfVotesForVideo;

@property (nonatomic, assign) NSIndexPath *indexPathOfThumbnail;

@property (nonatomic) int currentVotesOnVideo;

+ (VideoController *)sharedInstance;
- (void)videoToParseWithFile:(PFFile *)file
                 andLocation:(PFGeoPoint *)currentLocationGeoPoint
                andThumbnail:(PFFile *)thumbnailFile;


- (void)videoToParseWithFile:(PFFile *)file andLocation:(PFGeoPoint *)currentLocationGeoPoint;
- (void)saveVoteToParse:(NSString *)vote;
+ (void)queryVideosForFeed;
- (void)queryForIndividualVote:(Vote *)vote;
- (void)queryForVotesOnVideo:(Video *)video;


@end

