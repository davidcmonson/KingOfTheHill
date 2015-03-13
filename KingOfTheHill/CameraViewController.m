//
//  CameraViewController.m
//  KingOfTheHill
//
//  Created by Gabriel Guerrero on 3/13/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "CameraViewController.h"
#import "ProfileViewController.h"

@interface CameraViewController ()

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blueColor];
    [self theSteezyProfile];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
