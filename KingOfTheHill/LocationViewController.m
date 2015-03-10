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

@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    testObject[@"foo"] = @"bar";
    [testObject saveInBackground];
    
    self.map = [[MKMapView alloc] initWithFrame:self.view.bounds];
    self.map.mapType = MKMapTypeHybrid;
    [self.view addSubview:self.map];
    
    self.map.delegate = self;
    self.map.showsUserLocation = YES;
    
    self.locationManager = [CLLocationManager new];
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.delegate = self;

}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    [self.map setCenterCoordinate:self.map.userLocation.location.coordinate animated:YES];
}

//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
//{
////    if ([annotation isKindOfClass:[MKUserLocation class]]) {
////        return nil;
////    }
//    
//    if ([annotation isKindOfClass:[Video class]]) {
//    
//        Video *video = (Video *)annotation;
//        
//        MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:videoAnnotationKey];
//        
//        if (annotationView == nil) {
//            annotationView = video.annotationView;
//        }
//        else {
//            annotationView.annotation = annotation;
//            
//            return annotationView;
//        }
//    }
//        return nil;
//}

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
