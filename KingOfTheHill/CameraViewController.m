//
//  CameraViewController.m
//  KingOfTheHill
//
//  Created by Gabriel Guerrero on 3/13/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "CameraViewController.h"
#import "ProfileViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "LocationViewController.h"

@interface CameraViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic,strong) NSURL *videoURL;
@property (nonatomic,strong) MPMoviePlayerController *playerController;
@property (nonatomic,strong) UISwipeGestureRecognizer *swipeGesture;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LocationViewController *hiddenMapView = [LocationViewController new];
    hiddenMapView.view.hidden = YES;
    self.allowsEditing = YES;
    self.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.mediaTypes = [[NSArray alloc]initWithObjects:(NSString *) kUTTypeMovie, nil];
    [self setHidesBottomBarWhenPushed:YES];
    [self setVideoQuality:UIImagePickerControllerQualityTypeMedium];
    
    [self theSteezyProfile];
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    self.videoURL = info[UIImagePickerControllerMediaURL];
    [picker dismissViewControllerAnimated:YES completion:nil];
    self.playerController = [[MPMoviePlayerController alloc]initWithContentURL:self.videoURL];
    [self.playerController.view setFrame:self.view.bounds];
    [self.view addSubview:self.playerController.view];
    [self.playerController play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)theSteezyProfile {
    
    self.swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(bringUpProfile:)];
    
    [self.swipeGesture setDirection:(UISwipeGestureRecognizerDirectionUp)];
    
    [self.view addGestureRecognizer:self.swipeGesture];

    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"YOU TOUCHED THE CAMERA FOOL!");
}

- (void)bringUpProfile: (UISwipeGestureRecognizer *)recognizer {
    
    ProfileViewController *profileVC = [ProfileViewController new];
    profileVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    profileVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;;
    
    [self.parentViewController presentViewController:profileVC animated:YES completion:nil];
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
