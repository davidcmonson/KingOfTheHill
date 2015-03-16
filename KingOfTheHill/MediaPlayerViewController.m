//
//  MediaPlayerViewController.m
//  KingOfTheHill
//
//  Created by Trace Pomplun on 3/16/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "CameraPickerControllerDelegate.h"
#import "MediaPlayerViewController.h"

@interface MediaPlayerViewController ()

@property (nonatomic, strong) CameraPickerControllerDelegate *delegate;

@end

@implementation MediaPlayerViewController

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    
////    MPMoviePlayerController *playerController = [[MPMoviePlayerController alloc]initWithContentURL:self.delegate.videoURL];
////    playerController.controlStyle = MPMovieControlStyleDefault;
////    [playerController.view setFrame:self.view.bounds];
////    [self.view addSubview:playerController.view];
////    [playerController prepareToPlay];
////    [playerController play];
//    
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
