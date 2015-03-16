//
//  UserController.m
//  KingOfTheHill
//
//  Created by Gabriel Guerrero on 3/5/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import <CloudKit/CloudKit.h>
#import "VideoController.h"
#import "UserController.h"
#import "CameraViewController.h"

@implementation VideoController

+ (VideoController *)sharedInstance {
    
    static VideoController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[VideoController alloc] init];
    });
    return sharedInstance;
}

- (void)videoToParseWithFile:(PFFile *)file location:(CLLocation *)location
{
    Video *videoObject = [Video object];
    videoObject[videoLocationKey] = location;
    videoObject[videoFileKey] = file;
    [videoObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"videoKey saved");
        }
        else {
            NSLog(@"%@", error);
        }
    }];
}


//- (void)videoToParse
//{
//    Video *video = (Video *)[PFObject objectWithClassName:videoKey];
////    video[nameOfVideoKey] = video.nameOfVideo;
//    video[@"user"] = video.ownerOfVideo;
////    video[videoLocationKey] = video.location;
//    video[@"videoFile"] = @"file";

- (void)queryForAllVideosNearLocation:(CLLocationCoordinate2D)coordinates
                       withinDistance:(double)radiusFromLocationInMeters
{
    // Parse query calls.
    PFQuery *queryForVideos = [PFQuery queryWithClassName:videoKey];
    PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:coordinates.latitude
                                                  longitude:coordinates.longitude];
    [queryForVideos whereKey:videoLocationKey
                nearGeoPoint:geoPoint
            withinKilometers:radiusFromLocationInMeters];
    
    [queryForVideos findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        }
        else {
            NSMutableArray *arrayOfVideos = [[NSMutableArray alloc] initWithArray:objects];
            [self dropPinAtCoordinatesForVideosInVideosArray];
            
            self.arrayOfVideos = arrayOfVideos;
            NSLog(@"%ld",(unsigned long)self.arrayOfVideos.count);
            
        }
    }];
    
}

- (NSArray *)dropPinAtCoordinatesForVideosInVideosArray {
    
    for (NSInteger index = 0; index < self.arrayOfVideos.count; index++) {
        // Create video instance to make it easier to read when getting coordinates from it.
        PFObject *videoDictionaryAtIndex = self.arrayOfVideos[index];
        PFGeoPoint *geoPointOfVideo = videoDictionaryAtIndex[videoLocationKey];
        //Create your annotation
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        // Set your annotation to point at your coordinate
        
        NSMutableArray *mutable = [[NSMutableArray alloc] initWithArray:self.arrayOfVideos];

        point.coordinate = [self convertPFGeoPointToLocationCoordinate2D:geoPointOfVideo];
        
        //    If you want to clear other pins/annotations this is how to do it
        //        for (id annotation in self.map.annotations) {
        //            [self.map removeAnnotation:annotation];
        //        }
        //    Drop pin on map
        [mutable addObject:point];
    }
    return self.arrayOfVideos;
}

-(CLLocationCoordinate2D)convertPFGeoPointToLocationCoordinate2D:(PFGeoPoint *)geoPoint {
    CLLocationCoordinate2D coordinates;
    coordinates.latitude = geoPoint.latitude;
    coordinates.longitude = geoPoint.longitude;
    return coordinates;
}

- (NSInteger)totalVotesOnVideoWithIdentifier:(NSString *)identifier
{
    PFQuery *votesOnVideo = [PFQuery queryWithClassName:voteKey];
    [votesOnVideo whereKey:@"toVideo" equalTo:identifier];
    return [votesOnVideo countObjects];
}

@end
