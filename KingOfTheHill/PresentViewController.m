//
//  PresentViewController.m
//  KingOfTheHill
//
//  Created by Ryan S. Watt on 3/8/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "PresentViewController.h"
#import "ContentViewController.h"
#import "VideoViewController.h"
#import "ProfileViewController.h"
#import "MapViewController.h"


@interface PresentViewController () <UIPageViewControllerDataSource>

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) ContentViewController *contentVC;
@property (nonatomic, strong) VideoViewController *videoVC;
@property (nonatomic, strong) ProfileViewController *profileVC;
@property (nonatomic, strong) MapViewController *mapVC;
@end

@implementation PresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundBlues"]]];
    
    self.contentVC = [ContentViewController new];
    self.videoVC = [VideoViewController new];
    self.profileVC = [ProfileViewController new];
    self.mapVC = [MapViewController new];
    
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageViewController.dataSource = self;
    
    [self.pageViewController setViewControllers:@[self.contentVC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    
    [self addChildViewController:self.pageViewController];
    [self.pageViewController didMoveToParentViewController:self];
    [self.view addSubview:self.pageViewController.view];
    
    
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    if (viewController == self.videoVC) {
        return nil;
    } else if (viewController == self.contentVC) {
        return self.videoVC;
    } else {
        return self.contentVC;
    }
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if (viewController == self.videoVC) {
        return self.contentVC;
    } else if (viewController == self.contentVC) {
        return self.mapVC;
    } else {
        return nil;
    }
}



@end
