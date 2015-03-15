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

//#import "AnnotationVideoPlayerViewViewController.h"
//#import <AVKit/AVKit.h>
//#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#import "VideoPin.h"


@interface LocationViewController () <MKMapViewDelegate, CLLocationManagerDelegate, MKAnnotation>

@property (nonatomic, strong) NSArray *thumbnails;
@property (nonatomic, strong) MKMapView *allAnnotationsMapView;

@property (nonatomic, strong) MKMapView *mainMapView;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) Video *video;
@property (nonatomic) CLLocationCoordinate2D myCoordinates;
@property (nonatomic, strong) NSArray *arrayOfVideos;
@property (nonatomic, strong) UIButton *backButton;

@property (nonatomic, strong) AVPlayer *player;

@end

@implementation LocationViewController



//////////////// TEST VIDEO ///////////////
//
//- (void)viewDidAppear:(BOOL)animated {
//    
//    PFFile *videoFile = self.arrayOfVideos[1][videoFileKey];
//    NSURL *videoURL = [NSURL URLWithString:videoFile.url];
//    AVAsset *video = [AVAsset assetWithURL:videoURL];
//    AVPlayerItem *item = [[AVPlayerItem alloc] initWithAsset:video];
//    AVPlayer *player = [AVPlayer playerWithPlayerItem:item];
//    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:player];
//    UIView *playerView = [[UIView alloc]initWithFrame:self.view.bounds];
//    layer.frame = self.view.frame;
//    [playerView.layer addSublayer:layer];
//    [self.view addSubview: playerView];
//    [player play];
//}
//// This will be put in AnnotationVideoPlayerViewController
////////////////////////////////////////////



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self mapView];
    
    UIView *mapSwipeBarView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50)];
    mapSwipeBarView.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    [self.view addSubview:mapSwipeBarView];
    
    UILabel *mapSwipeBarLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 40, self.view.frame.size.width, 30)];
    mapSwipeBarLabel.text = @">> Swipe Back To Camera >>";
    mapSwipeBarLabel.font = [UIFont fontWithName:@"Avenir-BlackOblique" size:18];
    mapSwipeBarLabel.textAlignment = NSTextAlignmentCenter;
    mapSwipeBarLabel.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    [self.view addSubview:mapSwipeBarLabel];
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    /////////////// TEMP CODE for Simulator purposes
    //    CLLocation *tempLocation = [[CLLocation alloc] initWithLatitude:40.1 longitude:-111.1];
    //    self.myCoordinates = tempLocation.coordinate;
    // This hard codes a coordinate for tests on iOS Simulator
    ////////////////
    
    [self queryForAllVideosNearLocation:self.myCoordinates withinDistance:20000];
    [self.mainMapView setCenterCoordinate:self.mainMapView.userLocation.location.coordinate animated:YES];
    
    MKCoordinateRegion adjustedRegionForInitialZoomLevel = [self.mainMapView regionThatFits:MKCoordinateRegionMakeWithDistance(self.myCoordinates, 3000, 3000)];
    [self.mainMapView setRegion:adjustedRegionForInitialZoomLevel animated:YES];
    
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
        [self.mainMapView addAnnotation:point];
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
    self.mainMapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    self.mainMapView.mapType = MKMapTypeStandard;
    [self.view addSubview:self.mainMapView];
    
    self.mainMapView.delegate = self;
    self.mainMapView.showsUserLocation = YES; // Must be YES in order for the MKMapView protocol to fire.
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
    self.myCoordinates = self.mainMapView.userLocation.location.coordinate;
    [self.mainMapView setCenterCoordinate:self.mainMapView.userLocation.location.coordinate animated:YES];
}


- (void)queryForAllVideosNearLocation:(CLLocationCoordinate2D)coordinates
                       withinDistance:(double)radiusFromLocationInMeters
{
    // Parse query calls.
    
    PFQuery *queryForVideos = [PFQuery queryWithClassName:@"Video"];
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



//- (void)mapView:(MKMapView *)aMapView regionDidChangeAnimated:(BOOL)animated {
//    
//    [self updateVisibleAnnotations];
//}



- (void)mapView:(MKMapView *)aMapView didAddAnnotationViews:(NSArray *)views {
    
    for (MKAnnotationView *annotationView in views) {
        if (![annotationView.annotation isKindOfClass:[VideoPin class]]) {
            continue;
        }
        
        VideoPin *annotation = (VideoPin *)annotationView.annotation;
        
        if (annotation.clusterAnnotation != nil) {
            // animate the annotation from it's old container's coordinate, to its actual coordinate
            CLLocationCoordinate2D actualCoordinate = annotation.coordinate;
            CLLocationCoordinate2D containerCoordinate = annotation.clusterAnnotation.coordinate;
            
            // since it's displayed on the map, it is no longer contained by another annotation,
            // (We couldn't reset this in -updateVisibleAnnotations because we needed the reference to it here
            // to get the containerCoordinate)
            annotation.clusterAnnotation = nil;
            
            annotation.coordinate = containerCoordinate;
            
            [UIView animateWithDuration:0.3 animations:^{
                annotation.coordinate = actualCoordinate;
            }];
        }
    }
}




#pragma mark Annotations section
- (MKAnnotationView *)mapView:(MKMapView *)aMapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    
    static NSString *annotationIdentifier = @"VideoPin";
    
    if (aMapView != self.mainMapView)
        return nil;
    
    if ([annotation isKindOfClass:[VideoPin class]]) {
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[self.mainMapView dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
        if (annotationView == nil)
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationIdentifier];
        
        annotationView.canShowCallout = YES;
        
        UIButton *disclosureButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        annotationView.rightCalloutAccessoryView = disclosureButton;
        
        return annotationView;
    }
    
    return nil;

    
    
    
//    MKPinAnnotationView *pin = (MKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:videoAnnotationKey];
//    if ([annotation isKindOfClass:[MKUserLocation class]]) {
//        return nil;
//    }
//    if (pin == nil) {
//        pin = [[MKPinAnnotationView alloc] initWithAnnotation: annotation
//                                              reuseIdentifier: videoAnnotationKey];
//    } else {
//        annotation = [VideoPin new];
//        pin.annotation = annotation;
//    }
//    pin.image = [UIImage imageNamed:@"Skateboarding-50"];
//    pin.enabled = YES;
//    pin.canShowCallout = YES;
//    
//    pin.pinColor = MKPinAnnotationColorGreen;    // We can pick the color of the Pin!! Woohoo!
//    pin.animatesDrop = YES;
//    
//    // We can add a target/action by separating UIButton as a separate instance.
//    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//    [rightButton addTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
//    pin.rightCalloutAccessoryView = rightButton;
//    
//    
//    // Add a custom image to the left side of the callout.
//    UIImageView *myCustomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Skateboarding-50"]];
//    pin.leftCalloutAccessoryView = myCustomImage;
//    
//    
//    return pin;
    
    
    
    
//
//        if ([annotation isKindOfClass:[MKUserLocation class]]) {
//            return nil;
//        }
//    
//        if ([annotation isKindOfClass:[Video class]]) {
//    
//            Video *video = (Video *)annotation;
//    
//            MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:videoAnnotationKey];
//    
//            // Add to mapView:viewForAnnotation: after setting the image on the annotation view
//            annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//            annotationView.annotation = annotation;
//            
//            if (annotationView == nil) {
//                annotationView = video.annotationView;
//            }
//            else {
//                annotationView.annotation = annotation;
//    
//                return annotationView;
//            }
//        }
//        return nil;
    
    
}

// user tapped the call out accessory or the "bubble" that pops up
- (void)mapView:(MKMapView *)aMapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
    VideoPin *annotation = (VideoPin *)view.annotation;
    
    NSMutableArray *photosToShow = [NSMutableArray arrayWithObject:annotation];
    [photosToShow addObjectsFromArray:annotation.containedAnnotations];
    
    // This sets up the
//    PhotosViewController *viewController = [[PhotosViewController alloc] init];
//    viewController.edgesForExtendedLayout = UIRectEdgeNone;
//    viewController.photosToShow = photosToShow;

//  [self.navigationController pushViewController:viewController animated:YES];
}


- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
    if ([view.annotation isKindOfClass:[VideoPin class]])
    {
        VideoPin *annotation = (VideoPin *)view.annotation;
        [annotation updateSubtitleIfNeeded];
    }
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
