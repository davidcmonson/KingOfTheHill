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

- (MKAnnotationView *)annotation;

@end