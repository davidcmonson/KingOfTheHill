//
//  VideoPin.m
//  KingOfTheHill
//
//  Created by Gabriel Guerrero on 3/12/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "VideoPin.h"
#import <CoreLocation/CoreLocation.h>

@implementation VideoPin

@synthesize title = _title;
@synthesize coordinate = _coordinate;
@synthesize subtitle = _subtitle;


- (id)initWithThumbnailImagePath:(NSString*)thumbnailImagePath
                           title:(NSString *)title
                     subtitle:(NSString *)subtitle
                      coordinate:(CLLocationCoordinate2D)coordinate {
    self = [super init];
    if (self) {
    self.thumbnailImagePath = thumbnailImagePath;
    self.title = title;
    self.subtitle = subtitle;
    self.coordinate = coordinate;
    }
    return self;
}

- (NSString *)title {
    
    if (self.containedAnnotations.count > 0) {
        return [NSString stringWithFormat:@"%zd Photos", self.containedAnnotations.count + 1];
    }
    
    return _title;
}

- (NSString *)subtitle {
    return _subtitle;
}


- (CLLocationCoordinate2D)coordinate {
    return _coordinate;
}

- (UIImage *)thumbnail {
    
    if (!_image && self.thumbnailImagePath) {
        _image = [UIImage imageWithContentsOfFile:self.thumbnailImagePath];
    }
    return _image;
}

- (NSString *)stringForPlacemark:(CLPlacemark *)placemark {
    
    NSMutableString *string = [[NSMutableString alloc] init];
    if (placemark.locality) {
        [string appendString:placemark.locality];
    }
    
    if (placemark.administrativeArea) {
        if (string.length > 0)
            [string appendString:@", "];
        [string appendString:placemark.administrativeArea];
    }
    
    if (string.length == 0 && placemark.name)
        [string appendString:placemark.name];
    
    return string;
}

// Changes the subtitle to make approximation location name. Ex: "Near Salt Lake Convention Center"
- (void)updateSubtitleIfNeeded {
    
    if (self.subtitle == nil) {
        // for the subtitle, we reverse geocode the lat/long for a proper location string name
        CLLocation *location = [[CLLocation alloc] initWithLatitude:self.coordinate.latitude longitude:self.coordinate.longitude];
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
            if (placemarks.count > 0) {
                CLPlacemark *placemark = placemarks[0];
                self.subtitle = [NSString stringWithFormat:@"Near %@", [self stringForPlacemark:placemark]];
            }
        }];
    }
}


//- (MKMapItem*)mapItem {
////    NSDictionary *addressDict = @{(NSString*)kABPersonAddressStreetKey : _address};
//    
//    MKPlacemark *placemark = [[MKPlacemark alloc]
//                              initWithCoordinate:self.coordinate
//                              addressDictionary:addressDict];
//    
//    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
//    mapItem.name = self.title;
//    
//    return mapItem;
//    return nil;
//}


//- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate
//{
//    self.video.location = newCoordinate;
//    _coordinate = newCoordinate;
//}

//- (void)setTitle:(NSString *)title
//{
//    self.video.nameOfVideo = @"TITLE OF VIDEO"; //title;
//    _title = @"TEXT"; //title;
//}

//
//- (MKAnnotationView *)annotation
//{
//    MKAnnotationView *videoPinView = [[MKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:videoPinKey];
//    videoPinView.enabled = YES;
//    videoPinView.canShowCallout = YES;
//    videoPinView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeCustom];
//    //    videoPinView.image = [UIImage imageNamed:<#(NSString *)#>];
//    return videoPinView;
//}

@end