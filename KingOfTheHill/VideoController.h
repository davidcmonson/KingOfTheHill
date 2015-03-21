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

@property (nonatomic, assign) NSInteger *videoIndex;

@property (nonatomic, assign) NSString *numberOfVotesForVideo;

@property (nonatomic, assign) NSIndexPath *indexPathOfThumbnail;

+ (VideoController *)sharedInstance;
- (void)videoToParseWithFile:(PFFile *)file
                 andLocation:(PFGeoPoint *)currentLocationGeoPoint
                andThumbnail:(PFFile *)thumbnailFile;


- (void)videoToParseWithFile:(PFFile *)file andLocation:(PFGeoPoint *)currentLocationGeoPoint;
- (void)saveVoteToParse:(NSString *)vote;
//- (void)relationshipBetweenVote:(NSArray *)votes Video:(Video *)video;
+ (void)queryVideosForFeed;
- (void)queryForVotes:(Vote *)vote onVideo:(Video *)video;
- (void)queryForIndividualVote:(Vote *)vote;


@end

