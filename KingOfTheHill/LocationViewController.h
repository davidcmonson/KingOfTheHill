//
//  LocationViewController.h
//  KingOfTheHill
//
//  Created by Trace Pomplun on 3/9/15.
//  Rewritten by Gabriel Guerrero 3/15/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface LocationViewController : UIViewController

@property (nonatomic) CLLocationCoordinate2D myCoordinates;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

