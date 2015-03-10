//
//  Video.h
//  KingOfTheHill
//
//  Created by Gabriel Guerrero on 3/5/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <Foundation/Foundation.h>
#import "User.h"
//#import "Location.h"

static NSString *videoAnnotationKey = @"videoAnnotation";
static NSString *videoReferenceKey = @"video";

static NSString *uniqueVideoIDKey = @"uniqueID";
static NSString *locationKey = @"location";
static NSString *videoOwnderKey = @"user";

@interface Video : NSObject <MKAnnotation>

@property (nonatomic, strong) User *videoOwner;
@property (nonatomic, strong) NSString *uniqueVideoID;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (id)initWithVideoTitle:(NSString *)title atLocation:(CLLocationCoordinate2D)location;
- (MKAnnotationView *)annotationView;

@end
