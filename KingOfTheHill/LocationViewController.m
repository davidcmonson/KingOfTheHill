//
//  LocationViewController.m
//  KingOfTheHill
//
//  Created by Trace Pomplun on 3/9/15.
//  Rewritten by Gabriel Guerrero 3/15/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "LocationViewController.h"

#import "UIColor+AlphaRed.h"
#import "VideoController.h"
#import "VideoPin.h"
#import "AnnotationVideoPlayerViewViewController.h"
#import <AVFoundation/AVFoundation.h>

//#import <AVKit/AVKit.h>
//#import <UIKit/UIKit.h>

#import <ImageIO/ImageIO.h>
#import "LoadingStatus.h"

@interface LocationViewController () <MKMapViewDelegate, CLLocationManagerDelegate, MKAnnotation>

@property (nonatomic, strong) MKMapView *allAnnotationsMapView;
@property (nonatomic, strong) NSArray *arrayOfAllVideoPins;
@property (nonatomic, strong) MKMapView *mainMapView;

// Bool to zoom only once on initial launch
@property (nonatomic) BOOL zoomedOnce;
@property (nonatomic, strong) AnnotationVideoPlayerViewViewController *videoVC;

@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.zoomedOnce = NO;
    [self showMainMapView];
    [self setUpSwipeBar];
    [self setUpZoomToCurrentLocationButton];
    self.allAnnotationsMapView = [[MKMapView alloc] initWithFrame:CGRectZero];
    
    // Required method to notify user if it can use your current location
    // NOTE: Put notification later telling users why it will need to use their location
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    /////////////// TEMP CODE for Simulator purposes
    ////////////// This hard codes a coordinate for tests on iOS Simulator
    //    CLLocation *tempLocation = [[CLLocation alloc] initWithLatitude:40.1 longitude:-111.1];
    //    self.myCoordinates = tempLocation.coordinate;
    ///////////
}

- (void) setUpZoomToCurrentLocationButton {
    UIButton *zoom = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    zoom.layer.cornerRadius = 25;
    zoom.frame = CGRectMake(self.view.frame.size.width - 65, self.view.frame.size.height - 65, 50, 50);
    UIImageView *icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"homelocation"]];
    icon.frame = CGRectMake(5, 5, zoom.frame.size.width * 0.75, zoom.frame.size.width * 0.75);
    [zoom addSubview:icon];
    zoom.tintColor = [UIColor whiteColor];
    zoom.backgroundColor = [UIColor alphaRed];
    [self.view addSubview:zoom];
    [zoom addTarget:self action:@selector(centerAndZoomToLocation:) forControlEvents:UIControlEventTouchUpInside];
}

// Sets up bar at the bottom of the screen for users to swipe back to the main screen (camera)
- (void)setUpSwipeBar {
    
    //UIView *thumbTabView = [[UIView alloc] initWithFrame:CGRectMake(-20, 581, 103, 55)];
    UIView *thumbTabView = [[UIView alloc] initWithFrame:CGRectMake(-20, 500, 103, 55)];
    thumbTabView.backgroundColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:0.55];
    thumbTabView.clipsToBounds = YES;
    thumbTabView.layer.cornerRadius = thumbTabView.bounds.size.width/4.0f;
    [self.mainMapView addSubview:thumbTabView];
    [self.mainMapView clipsToBounds];
    
    UIButton *cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cameraButton.frame = CGRectMake(16, 584, 53, 46);
    cameraButton.clipsToBounds = YES;
    cameraButton.layer.cornerRadius = cameraButton.bounds.size.width/3.0f;
    cameraButton.layer.borderWidth = 1.0f;
    cameraButton.layer.borderColor = [UIColor clearColor].CGColor;
    [cameraButton setBackgroundImage:[UIImage imageNamed:@"Camera-50"] forState:UIControlStateNormal];
    [self.view addSubview:cameraButton];
    
}

- (void)centerAndZoomToLocation:(CLLocationCoordinate2D)coordinate {
    // If there's no specified location, it sets coordinate to the user's current location
    if (CLLocationCoordinate2DIsValid(coordinate)) {
        coordinate = self.myCoordinates;
    }
    MKCoordinateRegion adjustedRegionForInitialZoomLevel = [self.mainMapView regionThatFits:MKCoordinateRegionMakeWithDistance(coordinate, 3000 , 3000)];
    adjustedRegionForInitialZoomLevel.center = coordinate;
    [self.mainMapView setRegion:adjustedRegionForInitialZoomLevel animated:YES];
}

- (void)showMainMapView {
    self.mainMapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.mainMapView];
    self.mainMapView.mapType = MKMapTypeStandard;
    self.mainMapView.delegate = self;
    self.mainMapView.showsUserLocation = YES; // Must be YES in order for the MKMapView protocol to fire.
}

#pragma mark MKMapView delegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    // Resets myCoordinates property to current location.
    self.myCoordinates = self.mainMapView.userLocation.location.coordinate;
    if (self.zoomedOnce == NO) {
        [self centerAndZoomToLocation:self.mainMapView.userLocation.location.coordinate];
        [self queryForAllVideosNearLocation:self.myCoordinates withinMileRadius:200];
        // [self dropPinAtCoordinatesForVideosInVideosArray:[VideoController sharedInstance].arrayOfVideos];
        self.zoomedOnce = YES;
    }
}

- (void)queryForAllVideosNearLocation:(CLLocationCoordinate2D)coordinates
                     withinMileRadius:(double)radiusFromLocationInMiles
{
    
    // Parse query calls.
    
    PFQuery *queryForVideos = [PFQuery queryWithClassName:@"Video"];
    PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:coordinates.latitude
                                                  longitude:coordinates.longitude];
    [queryForVideos whereKey:locationKeyOfVideo
                nearGeoPoint:geoPoint
                 withinMiles:radiusFromLocationInMiles];
    [queryForVideos findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        }
        else {
            NSArray *arrayOfVideos = [[NSMutableArray alloc] initWithArray:objects];
            
            NSMutableArray *mutableArray = [[NSMutableArray alloc]initWithArray:self.arrayOfAllVideoPins];
            for (Video *video in arrayOfVideos) {
                VideoPin *videoPin = [[VideoPin alloc]initWithVideo:video];
                [mutableArray addObject:videoPin];
            }
            self.arrayOfAllVideoPins = mutableArray;
            
            [VideoController sharedInstance].arrayOfVideosNearLocation = arrayOfVideos;
            [self.allAnnotationsMapView addAnnotations:mutableArray];
            [self updateVisibleAnnotations];
            
            NSLog(@"Videos Near Location: %ld",[VideoController sharedInstance].arrayOfVideosNearLocation.count);
        }
    }];
}

-(CLLocationCoordinate2D)convertPFGeoPointToLocationCoordinate2D:(PFGeoPoint *)geoPoint {
    
    CLLocationCoordinate2D coordinates;
    coordinates.latitude = geoPoint.latitude;
    coordinates.longitude = geoPoint.longitude;
    
    return coordinates;
}



#pragma mark Annotations section

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

// Dresses the pin
// This checks whether annotation is a VideoPin class, if it is, creates a "i" button/ "more info" button
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
        annotationView.animatesDrop = NO;
        
        // Disabled: Pins show up too fast for custom image to be initialized.
        // annotationView.image = [UIImage imageNamed:@"Skateboarding-50"];
        
        UIButton *disclosureButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        annotationView.rightCalloutAccessoryView = disclosureButton;
        
        // Add a custom image to the left side of the callout.
        UIImageView *myCustomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Skateboarding-50"]];
        annotationView.leftCalloutAccessoryView = myCustomImage;
        
        return annotationView;
    }
    
    return nil;
}

// user tapped the call out accessory or the "i"/the "bubble" in the annotation
- (void)mapView:(MKMapView *)aMapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
    VideoPin *pinAtAnnotation = view.annotation;
    
    Video *videoPicked = pinAtAnnotation.currentVideo;
    
    NSMutableArray *videosToShow = [NSMutableArray arrayWithObject:pinAtAnnotation];
    [videosToShow addObjectsFromArray:pinAtAnnotation.containedAnnotations];
    
    [self bringUpPlayerWithVideo:videoPicked];
    
}

- (void)bringUpPlayerWithVideo:(Video *)video {
    
    self.videoVC = [AnnotationVideoPlayerViewViewController new];
    [self.videoVC updateWithVideo:video];
    self.videoVC.edgesForExtendedLayout = UIRectEdgeNone;
    self.videoVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    self.videoVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;;
    [self presentViewController:self.videoVC animated:YES completion:nil];
    
    if (!UIAccessibilityIsReduceTransparencyEnabled) {
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        UIVisualEffectView *viewWithBlurredBackground = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        viewWithBlurredBackground.frame = self.view.bounds;
        [self.view addSubview:viewWithBlurredBackground];
        
        //only apply the blur if the user hasn't disabled transparency effects
        
        //if you have more UIViews on screen, use insertSubview:belowSubview: to place it underneath the lowest view
        
        //add auto layout constraints so that the blur fills the screen upon rotating device
        //viewWithBlurredBackground.setTranslatesAutoresizingMaskIntoConstraints(false);
        //        self.view.addConstraint(NSLayoutConstraint(item: blurEffectView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0));
        //        self.view.addConstraint(NSLayoutConstraint(item: blurEffectView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0));
        //        self.view.addConstraint(NSLayoutConstraint(item: blurEffectView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0));
        //        self.view.addConstraint(NSLayoutConstraint(item: blurEffectView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0));
    } else {
        self.view.backgroundColor = [UIColor blackColor];
    }
}

// When the user taps/selects the PIN, updates if there's mutiple pins inside
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
    if ([view.annotation isKindOfClass:[VideoPin class]])
    {
        VideoPin *annotation = (VideoPin *)view.annotation;
        [annotation updateSubtitleIfNeeded];
    }
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



- (id<MKAnnotation>)annotationInGrid:(MKMapRect)gridMapRect usingAnnotations:(NSSet *)annotations {
    
    // first, see if one of the annotations we were already showing is in this mapRect
    NSSet *visibleAnnotationsInBucket = [self.mainMapView annotationsInMapRect:gridMapRect];
    NSSet *annotationsForGridSet = [annotations objectsPassingTest:^BOOL(id obj, BOOL *stop) {
        BOOL returnValue = ([visibleAnnotationsInBucket containsObject:obj]);
        if (returnValue)
        {
            *stop = YES;
        }
        return returnValue;
    }];
    
    if (annotationsForGridSet.count != 0) {
        return [annotationsForGridSet anyObject];
    }
    
    // otherwise, sort the annotations based on their distance from the center of the grid square,
    // then choose the one closest to the center to show
    MKMapPoint centerMapPoint = MKMapPointMake(MKMapRectGetMidX(gridMapRect), MKMapRectGetMidY(gridMapRect));
    NSArray *sortedAnnotations = [[annotations allObjects] sortedArrayUsingComparator:^(id obj1, id obj2) {
        MKMapPoint mapPoint1 = MKMapPointForCoordinate(((id<MKAnnotation>)obj1).coordinate);
        MKMapPoint mapPoint2 = MKMapPointForCoordinate(((id<MKAnnotation>)obj2).coordinate);
        
        CLLocationDistance distance1 = MKMetersBetweenMapPoints(mapPoint1, centerMapPoint);
        CLLocationDistance distance2 = MKMetersBetweenMapPoints(mapPoint2, centerMapPoint);
        
        if (distance1 < distance2) {
            return NSOrderedAscending;
        } else if (distance1 > distance2) {
            return NSOrderedDescending;
        }
        
        return NSOrderedSame;
    }];
    
    return sortedAnnotations[0];
}

#pragma mark ---------------------------




- (void)updateVisibleAnnotations {
    
    // This value to controls the number of off screen annotations are displayed.
    // A bigger number means more annotations, less chance of seeing annotation views pop in but decreased performance.
    // A smaller number means fewer annotations, more chance of seeing annotation views pop in but better performance.
    static float marginFactor = 2.0;
    
    // Adjust this roughly based on the dimensions of your annotations views.
    // Bigger numbers more aggressively coalesce annotations (fewer annotations displayed but better performance).
    // Numbers too small result in overlapping annotations views and too many annotations on screen.
    static float bucketSize = 60; //60 default
    
    // find all the annotations in the visible area + a wide margin to avoid popping annotation views in and out while panning the map.
    MKMapRect visibleMapRect = [self.mainMapView visibleMapRect];
    MKMapRect adjustedVisibleMapRect = visibleMapRect; //MKMapRectInset(visibleMapRect, -marginFactor * visibleMapRect.size.width, -marginFactor * visibleMapRect.size.height);
    
    // determine how wide each bucket will be, as a MKMapRect square
    CLLocationCoordinate2D leftCoordinate = [self.mainMapView convertPoint:CGPointZero toCoordinateFromView:self.view];
    CLLocationCoordinate2D rightCoordinate = [self.mainMapView convertPoint:CGPointMake(bucketSize, 0) toCoordinateFromView:self.view];
   double gridSize = MKMapPointForCoordinate(rightCoordinate).x - MKMapPointForCoordinate(leftCoordinate).x;
//    MKMapRect gridMapRect = MKMapRectMake(leftCoordinate.latitude, leftCoordinate.longitude, gridSize, gridSize);
    
    
    MKMapRect gridMapRect = MKMapRectMake(0, 0, gridSize, gridSize);

    
    //NSLog(@"%f, %f", leftCoordinate.latitude, leftCoordinate.longitude);
    //NSLog(@"/////////////////  %f, %f", rightCoordinate.latitude, rightCoordinate.longitude);
    
    
    
    // condense annotations, with a padding of two squares, around the visibleMapRect
    double startX = floor(MKMapRectGetMinX(adjustedVisibleMapRect) / gridSize) * gridSize;
    double startY = floor(MKMapRectGetMinY(adjustedVisibleMapRect) / gridSize) * gridSize;
    double endX = floor(MKMapRectGetMaxX(adjustedVisibleMapRect) / gridSize) * gridSize;
    double endY = floor(MKMapRectGetMaxY(adjustedVisibleMapRect) / gridSize) * gridSize;
    
    // for each square in our grid, pick one annotation to show
    gridMapRect.origin.y = startY;
    while (MKMapRectGetMinY(gridMapRect) <= endY) {
        gridMapRect.origin.x = startX;
        
        while (MKMapRectGetMinX(gridMapRect) <= endX) {
            NSSet *allAnnotationsInBucket = [self.allAnnotationsMapView annotationsInMapRect:gridMapRect];
            NSSet *visibleAnnotationsInBucket = [self.mainMapView annotationsInMapRect:gridMapRect];
            
            // we only care about PhotoAnnotations
            NSMutableSet *filteredAnnotationsInBucket = [[allAnnotationsInBucket objectsPassingTest:^BOOL(id obj, BOOL *stop) {
                return ([obj isKindOfClass:[VideoPin class]]);
            }] mutableCopy];
            
            if (filteredAnnotationsInBucket.count > 0) {
                VideoPin *annotationForGrid = (VideoPin *)[self annotationInGrid:gridMapRect usingAnnotations:filteredAnnotationsInBucket];
                
                [filteredAnnotationsInBucket removeObject:annotationForGrid];
                
                // give the annotationForGrid a reference to all the annotations it will represent
                annotationForGrid.containedAnnotations = [filteredAnnotationsInBucket allObjects];
                
                [self.mainMapView addAnnotation:annotationForGrid];
                
                for (VideoPin *annotation in filteredAnnotationsInBucket) {
                    // give all the other annotations a reference to the one which is representing them
                    annotation.clusterAnnotation = annotationForGrid;
                    annotation.containedAnnotations = nil;
                    
                    // remove annotations which we've decided to cluster
                    if ([visibleAnnotationsInBucket containsObject:annotation]) {
                        CLLocationCoordinate2D actualCoordinate = annotation.coordinate;
                        [UIView animateWithDuration:0.3 animations:^{
                            annotation.coordinate = annotation.clusterAnnotation.coordinate;
                        } completion:^(BOOL finished) {
                            annotation.coordinate = actualCoordinate;
                            [self.mainMapView removeAnnotation:annotation];
                        }];
                    }
                }
            }
            
            gridMapRect.origin.x += gridSize;
        }
        
        gridMapRect.origin.y += gridSize;
    }
}

- (void)mapView:(MKMapView *)aMapView regionDidChangeAnimated:(BOOL)animated {
    
    [self updateVisibleAnnotations];
}






//  // now load all photos from Resources and add them as annotations to the mapview
// [self populateWorldWithAllPhotoAnnotations];


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
