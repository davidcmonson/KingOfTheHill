//
//  PageViewController.m
//  KingOfTheHill
//
//  Created by Ryan S. Watt on 3/12/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//
#import "SwipePageViewController.h"
#import "VideoFeedViewController.h"
#import "LocationViewController.h"
#import "ProfileViewController.h"
#import "CameraViewController.h"
#import <ParseUI/ParseUI.h>
#import "User.h"

#import "AAPLCameraViewController.h"
#import "VideoController.h"



@interface SwipePageViewController () <UIPageViewControllerDataSource,UIPageViewControllerDelegate,PFLogInViewControllerDelegate,PFSignUpViewControllerDelegate,CLLocationManagerDelegate>

@property (nonatomic, strong) UIPageViewController *pageViewController;
//@property (nonatomic, strong) CameraViewController *cameraVC;
@property (nonatomic, strong) VideoFeedViewController *videoVC;
@property (nonatomic, strong) ProfileViewController *profileVC;
@property (nonatomic, strong) LocationViewController *mapVC;
@property (nonatomic, strong) AAPLCameraViewController *cameraVC;

@property (nonatomic, strong) CLLocationManager *locationManager;


@end

@implementation SwipePageViewController


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
    if (![PFUser currentUser]) { // No user logged in
        // Create the log in view controller
        PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
        [logInViewController setDelegate:self]; // Set ourselves as the delegate
        
        // Create the sign up view controller
        PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
        [signUpViewController setDelegate:self]; // Set ourselves as the delegate
        
        // Assign our sign up controller to be displayed from the login controller
        [logInViewController setSignUpController:signUpViewController];
        
        // Present the log in view controller
        [self presentViewController:logInViewController animated:YES completion:NULL];
    }
}


// Gets rough estimate of user location so when user goes to the map, it shouldn't start in the middle of the ocean
- (void)getLocation
{
    // Required method to notify user if it can use your current location
    // NOTE: Put notification later telling users why it will need to use their location
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    if (_locationManager == nil) {
        self.locationManager = [[CLLocationManager alloc]init]; // initializing locationManager
        self.locationManager.delegate = self; // we set the delegate of locationManager to self.
        self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers; // setting the accuracy
        
        // Put location fetcher on background thread.
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self.locationManager startUpdatingLocation];  //requesting location updates
        });
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Found Location of User!");
        });
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundBlues"]]];
    
    [VideoController queryVideosForFeed];
    self.cameraVC = [AAPLCameraViewController new];
    [self getLocation];
    //    self.cameraVC = [CameraViewController new]; // OLD CAMERA
    self.videoVC = [VideoFeedViewController new];
    
    self.mapVC = [LocationViewController new];
    self.mapVC.locationManager = self.locationManager;
    
    
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    
    [self.pageViewController setViewControllers:@[self.cameraVC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    
    [self addChildViewController:self.pageViewController];
    [self.pageViewController didMoveToParentViewController:self];
    [self.view addSubview:self.pageViewController.view];
    
    
    
}

-(void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers {
    //    NSLog(@"YOU ARE UGLY");
}

// Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
    // Check if both fields are completed
    if (username && password && username.length != 0 && password.length != 0) {
        return YES; // Begin login process
    }
    
    [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                message:@"Make sure you fill out all of the information!"
                               delegate:nil
                      cancelButtonTitle:@"ok"
                      otherButtonTitles:nil] show];
    return NO; // Interrupt login process
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"Failed to log in...");
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    [self.navigationController popViewControllerAnimated:YES];
}

// Sent to the delegate to determine whether the sign up request should be submitted to the server.
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info {
    BOOL informationComplete = YES;
    
    // loop through all of the submitted data
    for (id key in info) {
        NSString *field = [info objectForKey:key];
        if (!field || field.length == 0) { // check completion
            informationComplete = NO;
            break;
        }
    }
    
    // Display an alert if a field wasn't completed
    if (!informationComplete) {
        [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                    message:@"Make sure you fill out all of the information!"
                                   delegate:nil
                          cancelButtonTitle:@"ok"
                          otherButtonTitles:nil] show];
    }
    
    return informationComplete;
}

// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    //[self dismissModalViewControllerAnimated:YES]; // Dismiss the PFSignUpViewController
    [self dismissViewControllerAnimated:YES completion:nil]; // Dismiss the PFSignUpViewController
}

// Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
    NSLog(@"Failed to sign up...");
}

// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController {
    NSLog(@"User dismissed the signUpViewController");
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    if (viewController == self.videoVC) {
        return nil;
    } else if (viewController == self.cameraVC) {
        return self.videoVC;
    } else {
        return self.cameraVC;
    }
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if (viewController == self.videoVC) {
        return self.cameraVC;
    } else if (viewController == self.cameraVC) {
        return self.mapVC;
    } else {
        return nil;
    }
}



@end
