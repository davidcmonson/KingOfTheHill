//
//  VideoPin.m
//  KingOfTheHill
//
//  Created by Gabriel Guerrero on 3/12/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "VideoPin.h"

@implementation VideoPin

@synthesize title = _title;
@synthesize coordinate = _coordinate;

- (void)setTitle:(NSString *)title
{
    self.video.nameOfVideo = title;
    _title = title;
}

- (NSString *)title
{
    return _title;
}

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate
{
    self.video.location = newCoordinate;
    _coordinate = newCoordinate;
}

- (CLLocationCoordinate2D)coordinate
{
    return _coordinate;
}

- (MKAnnotationView *)annotation
{
    MKAnnotationView *videoPinView = [[MKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:videoPinKey];
    videoPinView.enabled = YES;
    videoPinView.canShowCallout = YES;
    videoPinView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeCustom];
    //    videoPinView.image = [UIImage imageNamed:<#(NSString *)#>];
    return videoPinView;
}

@end