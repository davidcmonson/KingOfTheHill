//
//  ProfileViewController.m
//  KingOfTheHill
//
//  Created by Ryan S. Watt on 3/12/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "ProfileViewController.h"
#import "LegalStuff.h"
#import "UILabel+DynamicLabel.h"
#import "DocsViewController.h"
#import <UIKit/UIKit.h>

@interface ProfileViewController () <UITextFieldDelegate>

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.9]];
    //    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundBlackWhite"]]];
    self.view.opaque = NO;
    [self alphaLabel];
    [self goToDocsButton];
    [self exitProfile];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView *viewWithBlurredBackground = [[UIVisualEffectView alloc] initWithEffect:effect];
    [self.view addSubview:viewWithBlurredBackground];
    
    self.view.opaque = NO;
    
}

- (void)exitProfile {
    UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismissProfile)];
    [gestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [self.view addGestureRecognizer:gestureRecognizer];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"YOU TOUCHED THE PROFILE VIEEEEEWWWW");
}

- (void)dismissProfile {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)alphaLabel {
    UILabel *alphaLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width /2 - 162.5, self.view.frame.size.height / 2 - 125 , 325, 250)];
    alphaLabel.text = @"ALPHA";
    alphaLabel.textAlignment = NSTextAlignmentCenter;
    alphaLabel.textColor = [UIColor whiteColor];
    alphaLabel.font = [UIFont fontWithName:@"Futura-Medium" size:48];
    [self.view addSubview:alphaLabel];

}

-(void)goToDocsButton {
    UIButton *goToDocs = [UIButton buttonWithType:UIButtonTypeCustom];
    goToDocs.frame = CGRectMake(self.view.frame.size.width /2 - 62.5 , self.view.frame.size.height - 100, 125, 40);
    goToDocs.clipsToBounds = YES;
//    goToDocs.layer.cornerRadius = 5;
    goToDocs.layer.borderWidth = 3.0f;
    goToDocs.layer.borderColor = [UIColor whiteColor].CGColor;
    [goToDocs setTitle:@"LEGAL" forState:UIControlStateNormal];
    goToDocs.titleLabel.font = [UIFont fontWithName:@"Futura-Medium" size:14];
    [goToDocs setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [goToDocs addTarget:self action:@selector(docsPage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goToDocs];
}

-(void)docsPage:(id)sender {
    
    DocsViewController *docsPageViewController = [DocsViewController new];
    [self presentViewController:docsPageViewController animated:YES completion:nil];
    
}





@end
