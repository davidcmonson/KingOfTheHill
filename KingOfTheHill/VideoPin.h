//
//  VideoPin.h
//  KingOfTheHill
//
//  Created by Gabriel Guerrero on 3/12/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <Foundation/Foundation.h>
#import "Video.h"

static NSString *videoPinKey = @"videoPin";

@interface VideoPin : NSObject <MKAnnotation>


@property (nonatomic, strong) Video *video;
@property (nonatomic, strong) UIImage *image;

// Required properties when using MKAnnotation
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic) CLLocationCoordinate2D coordinate;

@property (nonatomic, strong) NSString *thumbnailImagePath;
@property (nonatomic, strong) VideoPin *clusterAnnotation;
@property (nonatomic, strong) NSArray *containedAnnotations;


- (id)initWithThumbnailImagePath:(NSString*)thumbnailImagePath
                           title:(NSString *)title
                        subtitle:(NSString *)subtitle
                      coordinate:(CLLocationCoordinate2D)coordinate;

- (void)updateSubtitleIfNeeded;
//- (CLLocationCoordinate2D)coordinate;
//- (MKMapItem*)mapItem;


@end