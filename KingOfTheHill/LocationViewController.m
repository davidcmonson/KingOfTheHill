//
//  LocationViewController.m
//  KingOfTheHill
//
//  Created by Trace Pomplun on 3/9/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "LocationViewController.h"
#import "VideoController.h"

@interface LocationViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) MKMapView *map;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) Video *video;

@property (nonatomic, strong) NSArray *arrayOfVideos;

@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self mapView];
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }

    [self.map addAnnotations:self.arrayOfVideos];
}

- (void)mapView
{
    self.map = [[MKMapView alloc] initWithFrame:self.view.bounds];
    self.map.mapType = MKMapTypeHybrid;
    [self.view addSubview:self.map];
    
    self.map.delegate = self;
    self.map.showsUserLocation = YES;
}

- (CLLocationManager *)locationManager
{
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    }
    return _locationManager;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    [self.map setCenterCoordinate:self.map.userLocation.location.coordinate animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:userLocationKey object:self.map.userLocation];
}

- (void)queryForAllVideosNearLocation:(CLLocation *)currentLocation withinDistance:(CLLocationAccuracy *)distanceFromUser
{
    PFQuery *queryForVideos = [PFQuery queryWithClassName:videoKey];
    
    PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:currentLocation.coordinate.latitude longitude:currentLocation.coordinate.longitude];
    [queryForVideos whereKey:userLocationKey nearGeoPoint:geoPoint withinKilometers:kCLDistanceFilterNone];
    
    [queryForVideos findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        }
        else {
            NSMutableArray *arrayOfVideos = [[NSMutableArray alloc] initWithArray:objects];
            
            for (PFObject *video in objects) {
                [arrayOfVideos addObject:video];
            }
            
            self.arrayOfVideos = arrayOfVideos;
        }
    }];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    if ([annotation isKindOfClass:[Video class]]) {
    
        Video *video = (Video *)annotation;
        
        MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:videoAnnotationKey];
        
        if (annotationView == nil) {
            annotationView = video.annotationView;
        }
        else {
            annotationView.annotation = annotation;
            
            return annotationView;
        }
    }
        return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
