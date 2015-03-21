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

@property (nonatomic, strong) Video *currentVideo;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *thumbnailImagePath;

// Required properties when using MKAnnotation
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic) CLLocationCoordinate2D coordinate;

@property (nonatomic, strong) VideoPin *clusterAnnotation;
@property (nonatomic, strong) NSArray *containedAnnotations;



- (id)initWithThumbnailImagePath:(NSString*)thumbnailImagePath
                           title:(NSString *)title
                        subtitle:(NSString *)subtitle
                      coordinate:(CLLocationCoordinate2D)coordinate;

- (id)initWithVideo:(Video *)video;

- (void)updateSubtitleIfNeeded;



@end