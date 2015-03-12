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
//#import <Parse/Parse.h>
//#import <ParseUI/ParseUI.h>

@interface LocationViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) MKMapView *map;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) Video *video;
@property (nonatomic) CLLocationCoordinate2D myCoordinates;
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

    //[self.map addAnnotations:self.arrayOfVideos]; <--- does nothing
}


- (void)dropPinAtCoordinatesForVideosInVideosArray:(NSArray *)array {
    
    for (NSInteger index = 0; index < array.count; index++) {
        // Create video instance to make it easier to read when getting coordinates from it.
        PFObject *videoDictionaryAtIndex = array[index];
        PFGeoPoint *geoPointOfVideo = videoDictionaryAtIndex[videoLocationKey];
        //Create your annotation
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        // Set your annotation to point at your coordinate
        point.coordinate = [self convertPFGeoPointToLocationCoordinate2D:geoPointOfVideo];
        //    If you want to clear other pins/annotations this is how to do it
        //        for (id annotation in self.map.annotations) {
        //            [self.map removeAnnotation:annotation];
        //        }
        //    Drop pin on map
        [self.map addAnnotation:point];
    }
}

-(CLLocationCoordinate2D)convertPFGeoPointToLocationCoordinate2D:(PFGeoPoint *)geoPoint {
    CLLocationCoordinate2D coordinates;
    coordinates.latitude = geoPoint.latitude;
    coordinates.longitude = geoPoint.longitude;
    return coordinates;
}


- (void)mapView
{
    self.map = [[MKMapView alloc] initWithFrame:self.view.bounds];
    self.map.mapType = MKMapTypeHybrid;
    [self.view addSubview:self.map];
    
    self.map.delegate = self;
    self.map.showsUserLocation = YES; // Must be YES in order for the MKMapView protocol to fire.
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

#pragma mark MKMapView delegate
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    self.myCoordinates = self.map.userLocation.location.coordinate;
    //NSLog(@"%f %f",self.myCoordinates.latitude,self.myCoordinates.longitude);
    [self queryForAllVideosNearLocation:self.myCoordinates withinDistance:20000];
    [self.map setCenterCoordinate:self.map.userLocation.location.coordinate animated:YES];
}


- (void)queryForAllVideosNearLocation:(CLLocationCoordinate2D)coordinates
                       withinDistance:(double)radiusFromLocationInMeters
{
    // Parse query calls.
    PFQuery *queryForVideos = [PFQuery queryWithClassName:videoKey];
    PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:coordinates.latitude
                                                  longitude:coordinates.longitude];
    [queryForVideos whereKey:videoLocationKey
                nearGeoPoint:geoPoint
            withinKilometers:radiusFromLocationInMeters];
    
    [queryForVideos findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        }
        else {
            NSMutableArray *arrayOfVideos = [[NSMutableArray alloc] initWithArray:objects];
            [self dropPinAtCoordinatesForVideosInVideosArray:arrayOfVideos];
            
            self.arrayOfVideos = arrayOfVideos;
            NSLog(@"%ld",self.arrayOfVideos.count);
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
