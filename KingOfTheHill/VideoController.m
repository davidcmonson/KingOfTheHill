//
//  UserController.m
//  KingOfTheHill
//
//  Created by Gabriel Guerrero on 3/5/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "VideoController.h"

@implementation VideoController

+ (VideoController *)sharedInstance {
    
    static VideoController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[VideoController alloc] init];
    });
    return sharedInstance;
}

- (NSArray *)addVideoToMap
{
    NSMutableArray *mutable = [[NSMutableArray alloc] initWithArray:self.arrayOfVideos];
    
    MKPointAnnotation *marker = [MKPointAnnotation new];
    marker.coordinate = CLLocationCoordinate2DMake(41.1456, 104.8019);
    [mutable addObject:marker];
    
    MKPointAnnotation *marker2 = [MKPointAnnotation new];
    marker2.coordinate = CLLocationCoordinate2DMake(39.7392, 104.9903);
    [mutable addObject:marker2];
    
    self.arrayOfVideos = mutable;
    
    return self.arrayOfVideos;
}

@end
