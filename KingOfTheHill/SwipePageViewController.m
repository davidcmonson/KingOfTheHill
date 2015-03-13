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

@interface SwipePageViewController () <UIPageViewControllerDataSource>

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) CameraViewController *cameraVC;
@property (nonatomic, strong) VideoFeedViewController *videoVC;
@property (nonatomic, strong) ProfileViewController *profileVC;
@property (nonatomic, strong) LocationViewController *mapVC;

@end

@implementation SwipePageViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundBlues"]]];
    
    self.cameraVC = [CameraViewController new];
    self.videoVC = [VideoFeedViewController new];
    self.profileVC = [ProfileViewController new];
    self.mapVC = [LocationViewController new];
    
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageViewController.dataSource = self;
    
    [self.pageViewController setViewControllers:@[self.cameraVC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    
    [self addChildViewController:self.pageViewController];
    [self.pageViewController didMoveToParentViewController:self];
    [self.view addSubview:self.pageViewController.view];
    
    
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
