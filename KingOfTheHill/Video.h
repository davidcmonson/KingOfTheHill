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

static NSString *videoAnnotationKey = @"videoAnnotation";
static NSString *videoKey = @"Video";
static NSString *videoLocationKey = @"videoLocation";

static NSString *titleOfVideoKey = @"title";
static NSString *ownerOfVideoKey = @"owner";
static NSString *coordinateOfVideoKey = @"coordinate";

@interface Video : PFObject <MKAnnotation>

@property (nonatomic, strong) NSString *titleOfVideo;
@property (nonatomic, strong) User *ownerOfVideo;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) MKAnnotationView *annotationView;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate andTitle:(NSString *)title;
- (void)setTitleOfVideo:(NSString *)titleOfVideo;
- (void)ownerOfVideo:(User *)ownerOfVideo;
- (MKAnnotationView *)annotation;

@end
