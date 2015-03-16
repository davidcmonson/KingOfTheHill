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

// Test Purposes
#import "AnnotationVideoPlayerViewViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "AVPlayerDemoPlaybackView.h"

#import <AVKit/AVKit.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>




//#import <Parse/Parse.h>
//#import <ParseUI/ParseUI.h>

@interface LocationViewController () <MKMapViewDelegate, CLLocationManagerDelegate>



@property (nonatomic, strong) MKMapView *map;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) Video *video;
@property (nonatomic) CLLocationCoordinate2D myCoordinates;
@property (nonatomic, strong) NSArray *arrayOfVideos;
@property (nonatomic, strong) UIButton *backButton;

@property (nonatomic, strong) AVPlayer *player;
//@property (nonatomic, strong) VideoPin *pin;

@end

@implementation LocationViewController

////////////// TEST VIDEO ///////////////
- (void)viewDidAppear:(BOOL)animated {
    
    //AnnotationVideoPlayerViewViewController *viewPlayer = [AnnotationVideoPlayerViewViewController new];
    //[self.view addSubview:viewPlayer.view];
    PFFile *videoFile = self.arrayOfVideos[1][videoFileKey];
    NSURL *videoURL = [NSURL URLWithString:videoFile.url];
//    NSLog(@"%@",videoFile.url);
    
    
    //    MPMoviePlayerController *player = [[MPMoviePlayerController alloc] initWithContentURL:videoURL];
    //    [player.view setFrame:self.view.bounds];
    //    [player play];
    //    [self.view addSubview:player.view];
    
    //    UIView *playerView = [[UIView alloc]initWithFrame:self.view.bounds];
    //
    //    [self.view addSubview:playerView];
    //
    self.player = [[AVPlayer alloc] initWithURL:videoURL];
    [self.player play];
    
    //AVPlayerLayer *playerLayer = [[AVPlayer alloc] initWithURL:videoURL];
    //    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    
    
    
//    [self.map addAnnotations:[VideoController sharedInstance].arrayOfVideos];
    
//    NSLog(@"%@",videoFile);
    
}
//////////////////////////////////////////

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self mapView];
    
    UIView *mapSwipeBarView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50)];
    mapSwipeBarView.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    [self.view addSubview:mapSwipeBarView];
    
    UILabel *mapSwipeBarLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 40, self.view.frame.size.width, 30)];
    mapSwipeBarLabel.text = @"-----";
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
    ////////////////
    
    [[VideoController sharedInstance] queryForAllVideosNearLocation:self.myCoordinates withinDistance:20000];
    [self.map setCenterCoordinate:self.map.userLocation.location.coordinate animated:YES];
    [[VideoController sharedInstance] dropPinAtCoordinatesForVideosInVideosArray];
    
    MKCoordinateRegion adjustedRegionForInitialZoomLevel = [self.map regionThatFits:MKCoordinateRegionMakeWithDistance(self.myCoordinates, 3000, 3000)];
    [self.map setRegion:adjustedRegionForInitialZoomLevel animated:YES];
    
}

- (void)mapView
{
    self.map = [[MKMapView alloc] initWithFrame:self.view.bounds];
    self.map.mapType = MKMapTypeStandard;
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
    [self.map setCenterCoordinate:self.map.userLocation.location.coordinate animated:YES];
}

#pragma mark Annotations section
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKPinAnnotationView *pin = (MKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:videoPinKey];
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    if (pin == nil) {
        pin = [[MKPinAnnotationView alloc] initWithAnnotation: annotation
                                              reuseIdentifier: videoPinKey];
    } else {
        pin.annotation = annotation;
    }
    pin.image = [UIImage imageNamed:@"Skateboarding-50"];
    
    pin.enabled = YES;
    pin.canShowCallout = YES;
    //pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    pin.pinColor = MKPinAnnotationColorGreen;    // We can pick the color of the Pin!! Woohoo!
    pin.animatesDrop = YES;
    
    // We can add a target/action by separating UIButton as a separate instance.
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [rightButton addTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
    pin.rightCalloutAccessoryView = rightButton;
    
    // Add a custom image to the left side of the callout.
    UIImageView *myCustomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Skateboarding-50"]];
    pin.leftCalloutAccessoryView = myCustomImage;
    
    
    return pin;
    
    // Don't really know whats going on here....
    //    if ([annotation isKindOfClass:[MKUserLocation class]]) {
    //        return nil; // Not a good idea to hav
    //    }
    //
    //    if ([annotation isKindOfClass:[Video class]]) {
    //
    //        Video *video = (Video *)annotation;
    //
    //        MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:videoAnnotationKey];
    //
    //        // Add to mapView:viewForAnnotation: after setting the image on the annotation view
    //        annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
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
    //    return nil;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    //    InfoView *infoView = [[InfoView alloc]initWithNibName:@"InfoView" bundle:nil];
    //    [self.navigationController pushViewController:infoView animated:YES];
    NSLog(@"Pin was tapped");
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
