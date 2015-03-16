//
//  Video.h
//  KingOfTheHill
//
//  Created by Trace Pomplun on 3/10/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <Parse/Parse.h>
@class User;

static NSString *videoKey = @"Video";

static NSString *annotationKeyOfVideo = @"annotation";
static NSString *locationKeyOfVideo = @"location";
static NSString *urlOfVideo = @"videoFile";
static NSString *titleOfVideoKey = @"name";
static NSString *userOfVideoKey = @"user";
static NSString *videoId = @"objectId";

@interface Video : PFObject

@property (nonatomic, strong) NSString *nameOfVideo;
@property (nonatomic, strong) User *ownerOfVideo;
@property (nonatomic, strong) NSString *videoId;
@property (nonatomic, assign) CLLocationCoordinate2D location;
@property (nonatomic) NSInteger videoAtIndex;

@end