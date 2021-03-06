//
//  DocsViewController.m
//  KingOfTheHill
//
//  Created by Ryan S. Watt on 3/20/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "DocsViewController.h"
#import "LegalStuff.h"

@implementation DocsViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.8]];
    [self legal];
    [self fakeNavigationView];
    [self exit];
    
}
- (void)fakeNavigationView {
    UIView *theView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    theView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.95];
    [self.view addSubview:theView];
    
    UILabel *alphaTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    alphaTitleLabel.text = @"ALPHA LEGAL";
    alphaTitleLabel.textColor = [UIColor whiteColor];
    alphaTitleLabel.textAlignment = NSTextAlignmentCenter;
    alphaTitleLabel.font = [UIFont fontWithName:@"Futura-Medium" size:28];
    [theView addSubview:alphaTitleLabel];
    
}

-(void)legal {
    UIScrollView *legalScroll = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:legalScroll];
    UILabel *legalLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, self.view.bounds.size.width, 13800)];
    [legalLabel setNumberOfLines:0];
    //    legalLabel
    //    [legalLabel sizeToFit];
    legalLabel.text = [[LegalStuff legalDocs] objectForKey:LegalKey];
    legalLabel.textColor = [UIColor lightGrayColor];
    [legalScroll addSubview:legalLabel];
    [legalScroll setContentSize:CGSizeMake(self.view.frame.size.width, 13800)];

}

- (void)exit {
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(3, 10, 80, 50)];
    backButton.tintColor = [UIColor whiteColor];
    [backButton setTitle:@"BACK" forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont fontWithName:@"Futura-Medium" size:18];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [backButton addTarget:self action:@selector(backToProfile:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
}

- (void)backToProfile:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
