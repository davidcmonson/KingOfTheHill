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

static NSString *videoAnnotationKey = @"Annotation";

static NSString *videoLocationKey = @"location";
static NSString *videoFileKey = @"videoFile";
static NSString *nameOfVideoKey = @"name";
static NSString *ownerOfVideoKey = @"user";

@interface Video : PFObject <PFSubclassing>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSURL *videoFile;
@property (nonatomic, strong) User *user;
@property (nonatomic, assign) id location;

+ (NSString *)parseClassName;

@end