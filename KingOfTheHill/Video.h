//
//  Video.h
//  KingOfTheHill
//
//  Created by Trace Pomplun on 3/10/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <Parse/Parse.h>
@class Vote;
@class User;

static NSString *videoKey = @"Video";

static NSString *annotationKeyOfVideo = @"annotation";
static NSString *locationKeyOfVideo = @"location";
static NSString *urlOfVideo = @"videoFile";
static NSString *urlOfThumbnail = @"thumbnail";
static NSString *titleOfVideoKey = @"name";
static NSString *userOfVideoKey = @"user";
static NSString *videoId = @"objectId";

@interface Video : PFObject <PFSubclassing>

// NOTE: PFObjects from Parse must be treated as Dictionaries. You cannot add properties/methods to them, they will just be returned nil
@property (nonatomic, strong) NSString *nameOfVideo;
@property (nonatomic, strong) User *ownerOfVideo;
@property (nonatomic) NSInteger videoAtIndex;
@property (nonatomic) UIImage *thumbnail;
@property (nonatomic, strong) NSString *videoFile;
@property (nonatomic, strong) Vote *votes;


@property (nonatomic, assign) CLLocationCoordinate2D location;
@property (nonatomic, strong) NSString *objectId;



@end