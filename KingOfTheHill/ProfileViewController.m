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
@property (nonatomic, assign)BOOL profileRunning;
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

- (void)idiotProofing{
    if (_profileRunning == YES) {
    
    }
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
    
    // labels
    self.usernameLabel = [[UILabel alloc] init];
    self.usernameLabel.text = @"User Name";
    self.usernameLabel.textColor = [UIColor whiteColor];
    self.usernameLabel.font = [UIFont fontWithName:@"Sans-Serif" size:18];
    [self.view addSubview:self.usernameLabel];
    
    self.bioLabel = [[UILabel alloc] init];
    self.bioLabel.text = @"Your Sport";
    self.bioLabel.textColor = [UIColor whiteColor];
    self.bioLabel.font = [UIFont fontWithName:@"Sans-Serif" size:18];
    [self.view addSubview:self.bioLabel];
    
    self.favoriteSpotLabel = [[UILabel alloc] init];
    self.favoriteSpotLabel.text = @"Your Spot";
    self.favoriteSpotLabel.textColor = [UIColor whiteColor];
    self.favoriteSpotLabel.font = [UIFont fontWithName:@"Sans-Serif" size:18];
    [self.view addSubview:self.favoriteSpotLabel];
    
    self.contactInfoLabel = [[UILabel alloc] init];
    self.contactInfoLabel.text = @"Contact Info";
    self.contactInfoLabel.textColor = [UIColor whiteColor];
    self.contactInfoLabel.font = [UIFont fontWithName:@"Sans-Serif" size:18];
    [self.view addSubview:self.contactInfoLabel];
    
    // textFields
    self.usernameTextField = [[UITextField alloc] init];
    self.usernameTextField.placeholder = @"Enter User Name";
    [self.view addSubview:self.usernameTextField];
    
    
    self.bioTextField = [[UITextField alloc] init];
    self.bioTextField.placeholder = @"Enter Sport";
    [self.view addSubview:self.bioTextField];
    
    self.favoriteSpotTextField = [[UITextField alloc] init];
    self.favoriteSpotTextField.placeholder = @"Enter Name of Location";
    [self.view addSubview:self.favoriteSpotTextField];
    
    self.contactInfoTextField = [[UITextField alloc] init];
    self.contactInfoTextField.placeholder = @"Enter contact info";
    [self.view addSubview:self.contactInfoTextField];
    
    [self autoLayout];
}



- (void)autoLayout

{
    
    [self.usernameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.bioLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.favoriteSpotLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contactInfoLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.usernameTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.bioTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.favoriteSpotTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contactInfoTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // user
    NSDictionary *userLayout = NSDictionaryOfVariableBindings(_usernameLabel, _usernameTextField);
    NSArray *userHorizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_usernameLabel]-(>=8)-[_usernameTextField]-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:userLayout];
    NSArray *userVertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-60-[_usernameLabel]" options:0 metrics:nil views:userLayout];
    
    [self.view addConstraints:userHorizontal];
    [self.view addConstraints:userVertical];
    
    // bio
    NSDictionary *bioLayout = NSDictionaryOfVariableBindings(_bioLabel, _bioTextField);
    NSArray *bioHorizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_bioLabel]-(>=8)-[_bioTextField]-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:bioLayout];
    NSArray *bioVertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[_bioLabel]" options:0 metrics:nil views:bioLayout];
    
    [self.view addConstraints:bioHorizontal];
    [self.view addConstraints:bioVertical];
    
    // favoriteSpot
    NSDictionary *favoriteSpotLayout = NSDictionaryOfVariableBindings(_favoriteSpotLabel, _favoriteSpotTextField);
    NSArray *favoriteSpotHorizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_favoriteSpotLabel]-(>=8)-[_favoriteSpotTextField]-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:favoriteSpotLayout];
    NSArray *favoriteSpotVertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-140-[_favoriteSpotLabel]" options:0 metrics:nil views:favoriteSpotLayout];
    [self.view addConstraints:favoriteSpotHorizontal];
    [self.view addConstraints:favoriteSpotVertical];
    
    
    // contactInfo
    NSDictionary *contactInfoLayout = NSDictionaryOfVariableBindings(_contactInfoLabel, _contactInfoTextField);
    NSArray *contactInfoHorizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_contactInfoLabel]-(>=8)-[_contactInfoTextField]-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:contactInfoLayout];
    NSArray *contactInfoVertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-180-[_contactInfoLabel]" options:0 metrics:nil views:contactInfoLayout];
    [self.view addConstraints:contactInfoHorizontal];
    [self.view addConstraints:contactInfoVertical];
    
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


@end
