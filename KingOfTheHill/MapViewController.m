//
//  MapViewController.m
//  KingOfTheHill
//
//  Created by Ryan S. Watt on 3/9/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "MapViewController.h"
#import "ViewController.h"
#import "ContentViewController.h"

@interface MapViewController ()
@property (nonatomic, strong)UIView *view;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"map"]]];
}

@end
