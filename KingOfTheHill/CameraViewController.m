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

@interface CameraViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic,strong) NSURL *videoURL;
@property (nonatomic,strong) MPMoviePlayerController *playerController;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.allowsEditing = YES;
    self.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.mediaTypes = [[NSArray alloc]initWithObjects:(NSString *) kUTTypeMovie, nil];
    [self setHidesBottomBarWhenPushed:YES];
    [self setVideoQuality:UIImagePickerControllerQualityTypeMedium];

    //self.view.backgroundColor = [UIColor blueColor];
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
