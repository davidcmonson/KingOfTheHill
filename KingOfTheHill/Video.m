//
//  Video.m
//  KingOfTheHill
//
//  Created by Gabriel Guerrero on 3/5/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "Video.h"

@implementation Video

- (id)initWithVideoTitle:(NSString *)title atLocation:(CLLocationCoordinate2D)location
{
    self = [super init];
    if (self) {
        _title = title;
        _coordinate = location;
    }
    return self;
}

- (MKAnnotationView *)annotationView
{
    MKAnnotationView *customView = [[MKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:videoAnnotationKey];
    customView.enabled = YES;
    customView.canShowCallout = YES;
    customView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    return customView;
}

@end
