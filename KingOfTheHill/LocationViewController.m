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
#import <ImageIO/ImageIO.h>

#import "LoadingStatus.h"

#import "VideoPin.h"


@interface LocationViewController () <MKMapViewDelegate, CLLocationManagerDelegate, MKAnnotation>

@property (nonatomic, strong) NSArray *thumbnails;
@property (nonatomic, strong) MKMapView *allAnnotationsMapView;

@property (nonatomic, strong) MKMapView *mainMapView;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) Video *video;
@property (nonatomic) CLLocationCoordinate2D myCoordinates;
//@property (nonatomic, strong) NSArray *arrayOfVideos;
@property (nonatomic, strong) UIButton *backButton;
// Bool to zoom only once on initial launch
@property (nonatomic) BOOL zoomedOnce;


@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.zoomedOnce = NO;
    [self showMainMapView];
    
    
    //////////////////// Sets up Swipe bar
    UIView *mapSwipeBarView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50)];
    mapSwipeBarView.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    [self.view addSubview:mapSwipeBarView];
    
    UILabel *mapSwipeBarLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 40, self.view.frame.size.width, 30)];
    mapSwipeBarLabel.text = @">> Swipe Back To Camera >>";
    mapSwipeBarLabel.font = [UIFont fontWithName:@"Avenir-BlackOblique" size:18];
    mapSwipeBarLabel.textAlignment = NSTextAlignmentCenter;
    mapSwipeBarLabel.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    [self.view addSubview:mapSwipeBarLabel];
    /////////////////////
    
    }

- (void)centerAndZoomToLocation:(CLLocationCoordinate2D)coordinate {
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
        [self queryForAllVideosNearLocation:self.myCoordinates withinDistance:20000];
       // [self dropPinAtCoordinatesForVideosInVideosArray:[VideoController sharedInstance].arrayOfVideos];
        self.zoomedOnce = YES;
    }
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
            //[self dropPinAtCoordinatesForVideosInVideosArray:arrayOfVideos];
            
            [VideoController sharedInstance].arrayOfVideos = arrayOfVideos;
             [self dropPinAtCoordinatesForVideosInVideosArray:[VideoController sharedInstance].arrayOfVideos];
            NSLog(@"%ld",[VideoController sharedInstance].arrayOfVideos.count);
        }
    }];
    
}


- (void)dropPinAtCoordinatesForVideosInVideosArray:(NSArray *)array {

    for (NSInteger index = 0; index < array.count; index++) {
        // Create video instance to make it easier to read when getting coordinates from it.
        PFObject *videoDictionaryAtIndex = array[index];
        PFGeoPoint *geoPointOfVideo = videoDictionaryAtIndex[videoLocationKey];
        // Convert GeoPoint to CLLocaation
        CLLocationCoordinate2D coordinateOfVideo = [self convertPFGeoPointToLocationCoordinate2D:geoPointOfVideo];
        // Adding annotations
        VideoPin *videoPin = [[VideoPin alloc]initWithThumbnailImagePath:nil
                                                                   title:videoDictionaryAtIndex[nameOfVideoKey]
                                                                subtitle:@"Name of Location"
                                                              coordinate:coordinateOfVideo];
        
        //    If you want to clear other pins/annotations this is how to do it
        //        for (id annotation in self.map.annotations) {
        //            [self.map removeAnnotation:annotation];
        //        }
        
        //    Drop pin on map
        [self.mainMapView addAnnotation:videoPin];
    }
}

-(CLLocationCoordinate2D)convertPFGeoPointToLocationCoordinate2D:(PFGeoPoint *)geoPoint {
    CLLocationCoordinate2D coordinates;
    coordinates.latitude = geoPoint.latitude;
    coordinates.longitude = geoPoint.longitude;
    return coordinates;
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
}



//- (CLLocationManager *)locationManager
//{
//    if (_locationManager == nil) {
//        _locationManager = [[CLLocationManager alloc] init];
//        _locationManager.delegate = self;
//        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    }
//    return _locationManager;
//}




/*
 
 
 - (NSArray *)thumbnailSetFromPath:(NSString *)path {
 
 NSMutableArray *thumbnails = [[NSMutableArray alloc] init];
 
 // The bulk of our work here is going to be loading the files and looking up metadata
 // Thus, we see a major speed improvement by loading multiple photos simultaneously
 //
 NSOperationQueue *queue = [[NSOperationQueue alloc] init];
 [queue setMaxConcurrentOperationCount: 8];
 
 NSArray *thumbnailPaths = [[NSBundle mainBundle] pathsForResourcesOfType:@"jpg" inDirectory:path];
 for (NSString *thumbnailPath in thumbnailPaths) {
 [queue addOperationWithBlock:^{
 NSData *imageData = [NSData dataWithContentsOfFile:thumbnailPath];
 CGDataProviderRef dataProvider = CGDataProviderCreateWithCFData((CFDataRef)imageData);
 CGImageSourceRef imageSource = CGImageSourceCreateWithDataProvider(dataProvider, NULL);
 NSDictionary *imageProperties = (NSDictionary *)CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(imageSource,0, NULL));
 
 // check if the image is geotagged
 NSDictionary *gpsInfo = imageProperties[(NSString *)kCGImagePropertyGPSDictionary];
 if (gpsInfo) {
 CLLocationCoordinate2D coord;
 coord.latitude = [gpsInfo[(NSString *)kCGImagePropertyGPSLatitude] doubleValue];
 coord.longitude = [gpsInfo[(NSString *)kCGImagePropertyGPSLongitude] doubleValue];
 if ([gpsInfo[(NSString *)kCGImagePropertyGPSLatitudeRef] isEqualToString:@"S"])
 coord.latitude = coord.latitude * -1;
 if ([gpsInfo[(NSString *)kCGImagePropertyGPSLongitudeRef] isEqualToString:@"W"])
 coord.longitude = coord.longitude * -1;
 
 NSString *fileName = [[thumbnailPath lastPathComponent] stringByDeletingPathExtension];
 VideoPin *photo = [[VideoPin alloc] initWithThumbnailImagePath:thumbnailPath title:fileName description:@"test" coordinate:coord];
 
 @synchronized(thumbnails) {
 [thumbnails addObject:photo];
 }
 }
 
 if (imageSource)
 CFRelease(imageSource);
 
 if (imageProperties)
 CFRelease(CFBridgingRetain(imageProperties));
 
 if (dataProvider)
 CFRelease(dataProvider);
 }];
 }
 
 [queue waitUntilAllOperationsAreFinished];
 
 return thumbnails;
 }
 
 - (void)populateWorldWithAllPhotoAnnotations {
 
 // add a temporary loading view
 LoadingStatus *loadingStatus = [LoadingStatus defaultLoadingStatusWithWidth:CGRectGetWidth(self.view.frame)];
 [self.view addSubview:loadingStatus];
 
 // loading/processing photos might take a while -- do it asynchronously
 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
 NSArray *thumbnails = [self thumbnailSetFromPath:@"PhotoSet"];
 NSAssert(thumbnails != nil, @"No videos found");
 
 self.thumbnails = thumbnails;
 
 dispatch_async(dispatch_get_main_queue(), ^{
 [_allAnnotationsMapView addAnnotations:self.thumbnails];
 [self updateVisibleAnnotations];
 
 [loadingStatus removeFromSuperviewWithFade];
 });
 });
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
 static float bucketSize = 60.0;
 
 // find all the annotations in the visible area + a wide margin to avoid popping annotation views in and out while panning the map.
 MKMapRect visibleMapRect = [self.mainMapView visibleMapRect];
 MKMapRect adjustedVisibleMapRect = MKMapRectInset(visibleMapRect, -marginFactor * visibleMapRect.size.width, -marginFactor * visibleMapRect.size.height);
 
 // determine how wide each bucket will be, as a MKMapRect square
 CLLocationCoordinate2D leftCoordinate = [self.mainMapView convertPoint:CGPointZero toCoordinateFromView:self.view];
 CLLocationCoordinate2D rightCoordinate = [self.mainMapView convertPoint:CGPointMake(bucketSize, 0) toCoordinateFromView:self.view];
 double gridSize = MKMapPointForCoordinate(rightCoordinate).x - MKMapPointForCoordinate(leftCoordinate).x;
 MKMapRect gridMapRect = MKMapRectMake(0, 0, gridSize, gridSize);
 
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
 
 
 - (void)viewDidLoad {
 [super viewDidLoad];
 
 
 MKCoordinateRegion newRegion;
 newRegion.center = self.myCoordinates;
 newRegion.span.latitudeDelta = 5.0;
 newRegion.span.longitudeDelta = 5.0;
 self.mainMapView.region = newRegion;
 
 
 _allAnnotationsMapView = [[MKMapView alloc] initWithFrame:CGRectZero];
 
 // now load all photos from Resources and add them as annotations to the mapview
 [self populateWorldWithAllPhotoAnnotations];
 
 
 [self mainMapView];
 
 
 //    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
 //        [self.locationManager requestWhenInUseAuthorization];
 //    }
 //
 //    /////////////// TEMP CODE for Simulator purposes
 //    //    CLLocation *tempLocation = [[CLLocation alloc] initWithLatitude:40.1 longitude:-111.1];
 //    //    self.myCoordinates = tempLocation.coordinate;
 //    // This hard codes a coordinate for tests on iOS Simulator
 //    ////////////////
 //
 //    [self queryForAllVideosNearLocation:self.myCoordinates withinDistance:20000];
 //    [self.mainMapView setCenterCoordinate:self.mainMapView.userLocation.location.coordinate animated:YES];
 //
 
 
 }
 
 

 
 
 - (void)mapView:(MKMapView *)aMapView regionDidChangeAnimated:(BOOL)animated {
 
 [self updateVisibleAnnotations];
 }
 
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
 
 */


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
