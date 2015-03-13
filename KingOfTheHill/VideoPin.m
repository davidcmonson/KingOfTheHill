//
//  VideoPin.m
//  KingOfTheHill
//
//  Created by Gabriel Guerrero on 3/12/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "VideoPin.h"

@interface VideoPin ()
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, assign) CLLocationCoordinate2D theCoordinate;
@end

@implementation VideoPin

//@synthesize title = _title;
//@synthesize coordinate = _coordinate;



- (id)initWithName:(NSString *)name
       description:(NSString *)descrption
        coordinate:(CLLocationCoordinate2D)coordinate {
    self = [super init];
    if (self) {
        self.name = name;
        self.description = descrption;
        self.coordinate = coordinate;
    
    }
    return self;
}

- (NSString *)title {
    return _name;
}

- (NSString *)subtitle {
    return nil;
    //return _address;
}

- (CLLocationCoordinate2D)coordinate {
    return _theCoordinate;
}

- (MKMapItem*)mapItem {
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
    return nil;
}


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