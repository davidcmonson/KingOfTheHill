//
//  CameraViewController.m
//  KingOfTheHill
//
//  Created by Ryan S. Watt on 3/12/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "CameraViewController.h"
#import "ProfileViewController.h"
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
//#import "SCTouchDetector.h"
//#import "SCRecorderViewController.h"
//#import "SCAudioTools.h"
//#import "SCVideoPlayerViewController.h"
//#import "SCImageDisplayerViewController.h"
//#import "SCRecorder.h"
//#import <AssetsLibrary/AssetsLibrary.h>
//#import "SCSessionListViewController.h"
//#import "SCRecordSessionManager.h"
//#import <MobileCoreServices/MobileCoreServices.h>


@interface CameraViewController () {
    SCRecorder *recorder;
    SCRecordSession *_recordSession;
    
}
@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self theSteezyProfile];
    // Create the recorder
    recorder = [SCRecorder recorder]; // You can also use +[SCRecorder sharedRecorder]
    recorder.sessionPreset = [SCRecorderTools bestSessionPresetCompatibleWithAllDevices];
    recorder.maxRecordDuration = CMTimeMake(5, 1);
    recorder.autoSetVideoOrientation = YES;
    recorder.delegate = self;
    // Initialize the audio and video inputs using the parameters set in the SCRecorder
    [recorder openSession: ^(NSError *sessionError, NSError *audioError, NSError *videoError, NSError *photoError) {
        // Start the flow of inputs
        [recorder startRunningSession];
    }];
    
    // View for the Recorder Camera
    UIView *previewView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    recorder.previewView = previewView;
    self.previewView = previewView;
    
    UIButton *recordButton = [[UIButton alloc] initWithFrame:CGRectMake(145, 590, 80, 80)];
    [recordButton setImage:[UIImage imageNamed:@"record"]  forState:UIControlStateNormal];
    [recordButton setImage:[UIImage imageNamed:@"recordPressed"]  forState:UIControlStateHighlighted];
    
    //    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchedVideo:)];
    //    recordButton addGestureRecognizer:<#(UIGestureRecognizer *)#>
    
    
    [self.view addSubview:previewView];
    [self.view addSubview:recordButton];
    
    //    recorder.initializeRecordSessionLazily = YES;
    //    [recorder openSession:^(NSError *sessionError, NSError *audioError, NSError *videoError, NSError *photoError) {
    //        NSError *error = nil;
    //        NSLog(@"%@", error);
    //        NSLog(@"==== Opened session ====");
    //        NSLog(@"Session error: %@", sessionError.description);
    //        NSLog(@"Audio error : %@", audioError.description);
    //        NSLog(@"Video error: %@", videoError.description);
    //        NSLog(@"Photo error: %@", photoError.description);
    //        NSLog(@"=======================");
    //        [self prepareCamera];
    //    }];
    //
    //}
    //
    ////- (void)handleTouchDetected:(SCTouchDetector*)touchDetector {
    ////    if (touchDetector.state == UIGestureRecognizerStateBegan) {
    ////        //ghostImageView.hidden = YES;
    ////        [recorder record];
    ////    } else if (touchDetector.state == UIGestureRecognizerStateEnded) {
    ////        [recorder pause];
    ////        //[self updateGhostImage];
    ////    }
    ////}
    //
    //
    //- (void) prepareCamera {
    //    if (recorder.recordSession == nil) {
    //
    //        SCRecordSession *session = [SCRecordSession recordSession];
    //        session.fileType = AVFileTypeQuickTimeMovie;
    //
    //        recorder.recordSession = session;
    //    }
    //}
}
//
//- (void)handleTouchDetected:(SCTouchDetector*)touchDetector {
//    if (touchDetector.state == UIGestureRecognizerStateBegan) {
//        _ghostImageView.hidden = YES;
//        [_recorder record];
//    } else if (touchDetector.state == UIGestureRecognizerStateEnded) {
//        [_recorder pause];
//        [self updateGhostImage];
//    }

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


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

