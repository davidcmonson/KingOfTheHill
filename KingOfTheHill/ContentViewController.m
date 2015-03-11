//
//  ContentViewController.m
//  KingOfTheHill
//
//  Created by Ryan S. Watt on 3/8/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "ContentViewController.h"
#import "ProfileViewController.h"

@interface ContentViewController ()

@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"camera"]]];
    [self theSteezyProfile];
}

- (void)theSteezyProfile {
    
    UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(bringUpProfile:)];
    [gestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [self.view addGestureRecognizer:gestureRecognizer];
    
}

- (void)bringUpProfile: (UISwipeGestureRecognizer *)recognizer {
    ProfileViewController *profileVC = [ProfileViewController new];
    profileVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    profileVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;;
    [self presentViewController:profileVC animated:YES completion:nil];
//    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
//    UIVisualEffectView *viewWithBlurredBackground = [[UIVisualEffectView alloc] initWithEffect:effect];
//    [self.view addSubview:viewWithBlurredBackground];

    
}

-(void)didReceiveMemoryWarning
{
    return;
}

@end
