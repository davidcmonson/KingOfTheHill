//
//  Video.m
//  KingOfTheHill
//
//  Created by Trace Pomplun on 3/10/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "Video.h"

@implementation Video

@dynamic titleOfVideo;
@dynamic ownerOfVideo;
@dynamic coordinate;
@dynamic annotationView;

- (void)registerForNotifications
{
//    [NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initWithCoordinate:andTitle) name:userl object:<#(id)#>
}

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate andTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        self.coordinate = coordinate;
        self.titleOfVideo = title;
    }
    return self;
}

- (MKAnnotationView *)annotation
{
    MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:videoAnnotationKey];
    
    annotationView.enabled = YES;
    annotationView.canShowCallout = YES;
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeCustom];
    
    return annotationView;
}

- (void)setTitleOfVideo:(NSString *)titleOfVideo
{
    self.titleOfVideo = titleOfVideo;
}

- (void)ownerOfVideo:(User *)ownerOfVideo
{
    self.ownerOfVideo = ownerOfVideo;
}

@end
