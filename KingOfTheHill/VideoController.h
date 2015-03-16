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
#import "VideoPin.h"

@interface VideoController : NSObject

@property (nonatomic, strong) NSArray *arrayOfVideos;
@property (nonatomic, strong) VideoPin *annotation;

+ (VideoController *)sharedInstance;
- (void)videoToParseWithFile:(PFFile *)file location:(CLLocation *)location;
- (NSInteger)totalVotesOnVideoWithIdentifier:(NSString *)identifier;
- (void)queryForAllVideosNearLocation:(CLLocationCoordinate2D)coordinates
                       withinDistance:(double)radiusFromLocationInMeters;
- (NSArray *)dropPinAtCoordinatesForVideosInVideosArray;

@end
