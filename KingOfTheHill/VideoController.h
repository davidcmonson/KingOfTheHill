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
@property (nonatomic, strong) NSMutableArray *arrayOfArrayAllVotes;


//@property (nonatomic) NSInteger voteCount;

+ (VideoController *)sharedInstance;
- (void)videoToParseWithFile:(PFFile *)file
                 andLocation:(PFGeoPoint *)currentLocationGeoPoint
                andThumbnail:(PFFile *)thumbnailFile andName:(NSString *)name;

+ (void)queryVideosForFeed;
- (void)queryForVotesOnVideo:(Video *)object;


@end

