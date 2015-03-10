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

@interface Video : NSObject <MKAnnotation>

//@property (nonatomic, strong) CKRecord *asset;
//@property (nonatomic, strong) Location *location;
//@property (nonatomic, strong) User *userName;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) NSString *videoUniqueId;

- (id)initWithVideoTitle:(NSString *)title atLocation:(CLLocationCoordinate2D)location;
- (MKAnnotationView *)annotationView;

@end
