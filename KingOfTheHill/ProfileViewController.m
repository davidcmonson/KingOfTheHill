//
//  ProfileViewController.m
//  KingOfTheHill
//
//  Created by Ryan S. Watt on 3/12/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "ProfileViewController.h"
#import <UIKit/UIKit.h>

@interface ProfileViewController ()

@property (nonatomic, strong)UITextField *usernameTextField;
@property (nonatomic, strong)UITextField *bioTextField;
@property (nonatomic, strong)UITextField *favoriteSpotTextField;
@property (nonatomic, strong)UITextField *contactInfoTextField;
@property (nonatomic, strong)UILabel *locationsLabel;
@property (nonatomic, strong)UILabel *usernameLabel;
@property (nonatomic, strong)UILabel *bioLabel;
@property (nonatomic, strong)UILabel *favoriteSpotLabel;
@property (nonatomic, strong)UILabel *contactInfoLabel;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5]];
    [self profileStructure];
    [self exitProfile];
    //    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundBlackWhite"]]];
    self.view.opaque = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    //    UIVisualEffectView *viewWithBlurredBackground = [[UIVisualEffectView alloc] initWithEffect:effect];
    //    [self.view addSubview:viewWithBlurredBackground];
    
    //    [self.view setBackgroundColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5]];
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView *viewWithBlurredBackground = [[UIVisualEffectView alloc] initWithEffect:effect];
    [self.view addSubview:viewWithBlurredBackground];
    
    self.view.opaque = NO;
    
}

- (void)profileStructure {
    
    self.usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 72, 100, 30)];
    self.usernameLabel.textAlignment = NSTextAlignmentRight;
    self.usernameLabel.text = @"User Name";
    self.usernameLabel.textColor = [UIColor blackColor];
    self.usernameLabel.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:18];
    [self.view addSubview:self.usernameLabel];
    
    self.usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(160, 75, 200, 30)];
    self.usernameTextField.placeholder = @"Enter User Name";
    self.usernameTextField.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:self.usernameTextField];
    
    self.bioLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 112, 100, 30)];
    self.bioLabel.textAlignment = NSTextAlignmentRight;
    self.bioLabel.text = @"Your Sport";
    self.bioLabel.textColor = [UIColor blueColor];
    self.bioLabel.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:18];
    [self.view addSubview:self.bioLabel];
    
    self.bioTextField = [[UITextField alloc] initWithFrame:CGRectMake(160, 115, 200, 30)];
    self.bioTextField.placeholder = @"Enter Sport";
    self.bioTextField.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:self.bioTextField];
    
    self.favoriteSpotLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 152, 150, 30)];
    self.favoriteSpotLabel.textAlignment = NSTextAlignmentRight;
    self.favoriteSpotLabel.text = @"Favorite Spot";
    self.favoriteSpotLabel.textColor = [UIColor blackColor];
    self.favoriteSpotLabel.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:18];
    [self.view addSubview:self.favoriteSpotLabel];
    
    self.favoriteSpotTextField = [[UITextField alloc] initWithFrame:CGRectMake(160, 155, 200, 30)];
    self.favoriteSpotTextField.placeholder = @"Enter Name of Location";
    self.favoriteSpotTextField.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:self.favoriteSpotTextField];
    
    self.contactInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 192, 100, 30)];
    self.contactInfoLabel.textAlignment = NSTextAlignmentRight;
    self.contactInfoLabel.text = @"Contact Info";
    self.contactInfoLabel.textColor = [UIColor blueColor];
    self.contactInfoLabel.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:18];
    [self.view addSubview:self.contactInfoLabel];
    
    self.contactInfoTextField = [[UITextField alloc] initWithFrame:CGRectMake(160, 195, 200, 30)];
    self.contactInfoTextField.placeholder = @"Enter contact info";
    self.contactInfoTextField.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:self.contactInfoTextField];
    [self.view setBackgroundColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5]];
    
}

- (void)exitProfile {
    
    UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismissProfile:)];
    [gestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [self.view addGestureRecognizer:gestureRecognizer];
    
}

- (void)dismissProfile: (UISwipeGestureRecognizer *)recognizer {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end
