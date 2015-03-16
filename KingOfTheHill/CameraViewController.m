//
//  CameraViewController.m
//  KingOfTheHill
//
//  Created by Gabriel Guerrero on 3/13/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "VideoController.h"
#import "Video.h"
//@import MapKit;
#import "CameraViewController.h"
#import "ProfileViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>
@import AssetsLibrary;
@import AVFoundation;
#import "CameraPickerControllerDelegate.h"

@interface CameraViewController ()

//@property (nonatomic, strong) UIGestureRecognizer *record;
//@property (nonatomic, strong) UIButton *cameraRecord;
//@property (nonatomic) BOOL isrecording;
@property (strong, nonatomic) CameraPickerControllerDelegate *delegate;

@end

@implementation CameraViewController

//+ (void)clearTempDirectory
//{
//    NSArray *tempDirectory = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:NSTemporaryDirectory() error:NULL];
//    for (NSString *file in tempDirectory) {
//        [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@%@", NSTemporaryDirectory(), file] error:NULL];
//    }
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self theSteezyProfile];
    

//    self.cameraRecord = [[UIButton alloc] initWithFrame:CGRectMake(20, 50, 50, 50)];
//    self.cameraRecord.layer.cornerRadius = 10;
//    self.cameraRecord.layer.borderWidth = 1;
//    self.cameraRecord.layer.borderColor = [UIColor whiteColor].CGColor;
//    [self.cameraRecord setTitle:@"-" forState:UIControlStateNormal];
//    [self.cameraRecord setTitle:@"---" forState:UIControlStateHighlighted];
//    [self.cameraRecord addTarget:self action:@selector(videoRecording:) forControlEvents:UIControlEventTouchUpInside];
//    [self.cameraOverlayView addSubview:self.cameraRecord];
    
//    self.record.view.multipleTouchEnabled = YES;
//    self.record = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(videoRecording:)];
//    [self.cameraOverlayView addGestureRecognizer:self.record];
}

- (void)viewDidAppear:(BOOL)animated
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        self.allowsEditing = YES;
        self.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.mediaTypes = [[NSArray alloc]initWithObjects:(NSString *) kUTTypeMovie, nil];
        //    self.showsCameraControls = NO;
        [self setHidesBottomBarWhenPushed:YES];
        [self setVideoQuality:UIImagePickerControllerQualityTypeMedium];
        
        
        
    }
}

//- (void)videoRecording:(id)sender
//{
//    if (!self.isrecording) {
//        self.isrecording = YES;
//        [self startVideoCapture];
//        NSLog(@"tapped");
//    }
//    else {
//        self.isrecording = NO;
//        [self stopVideoCapture];
//        NSLog(@"%@", self.videoURL);
//    }
//}
//
//- (BOOL)startVideoCapture
//{
//    return YES;
//}

//- (void)saveVideoToCameraRoll
//{
//    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
//    [library writeVideoAtPathToSavedPhotosAlbum:self.videoURL completionBlock:^(NSURL *assetURL, NSError *error) {
//        if (error) {
//            NSLog(@"%@",error);
//        }
//        else {
//            [CameraViewController clearTempDirectory];
//        }
//    }];
//}

// get metadata off data
// upload to parse

//-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
//
//    self.videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
//    
//    ALAssetsLibrary *videoLibrary = [ALAssetsLibrary new];
//    [videoLibrary writeVideoAtPathToSavedPhotosAlbum:self.videoURL completionBlock:^(NSURL *assetURL, NSError *error) {
//        if (assetURL) {
//            [videoLibrary assetForURL:self.videoURL resultBlock:^(ALAsset *asset) {
//                ALAssetRepresentation *rep = [asset defaultRepresentation];
//                NSDictionary *metadata = rep.metadata;
//                NSLog(@"%@", metadata);
//                
//                CGImageRef iref = [rep fullScreenImage] ;
//                
//                if (iref) {
//                    NSLog(@"Everything is awesome");
//                }
//            } failureBlock:^(NSError *error) {
//                // error handling
//            }];
//        }
//    }];

//    [videoLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
//        [group setAssetsFilter:[ALAssetsFilter allVideos]];
        
//        [group enumerateAssetsAtIndexes:[NSIndexSet indexSetWithIndex:0] options:0 usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
//            if (result) {
//                ALAssetRepresentation *representation = [result defaultRepresentation];
//                NSURL *url = [representation nil];
//                AVAsset *avAsset = [AVU]
//            }
//        }];
//    } failureBlock:^(NSError *error) {
//        NSLog(@"%@", error);
//    }];
    
//    MPMoviePlayerController *playerController = [[MPMoviePlayerController alloc]initWithContentURL:[info objectForKey:UIImagePickerControllerReferenceURL]];
//    playerController.controlStyle = MPMovieControlStyleDefault;
//    [playerController.view setFrame:self.view.bounds];
//    [self.view addSubview:playerController.view];
//    [playerController prepareToPlay];
//    [playerController play];
//

//
//    NSString *moviePath = [self.videoURL path];
//    
//    NSDictionary *data = [info objectForKey:UIImagePickerControllerMediaMetadata];
//    NSLog(@"%@", data);
//    
//    if ( UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(moviePath) ) {
//        
//        ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc] init];
//        
//        [assetLibrary assetForURL:self.videoURL resultBlock:^(ALAsset *asset) {
//            
//            CLLocation *location = [asset valueForProperty:ALAssetPropertyLocation];
//            NSLog(@"Location Meta: %@", location);
//            
//        } failureBlock:^(NSError *error) {
//            NSLog(@"Video Date Error: %@", error);
//        }];
//        
//    }

//    NSData *data = [NSData dataWithContentsOfURL:self.videoURL];
//    PFFile *file = [PFFile fileWithData:data];

//    [[VideoController sharedInstance] videoToParseWithFile:file location:self.locationManager];
    
//    if (self.videoURL) {
//        ALAssetsLibraryAssetForURLResultBlock resultBlock = ^(ALAsset *videoAsset) {
//            CLLocation *location = [videoAsset valueForProperty:ALAssetPropertyLocation];
//            self.video.location = location;
//            NSLog(@"%@", self.video.location);
//        };
//        ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error) {
//            NSLog(@"%@", error);
//        };
//        ALAssetsLibrary *assestLibrary = [ALAssetsLibrary new];
//        [assestLibrary assetForURL:self.videoURL resultBlock:resultBlock failureBlock:failureBlock];
//    }
    
    
//    NSString *mediaType = [NSString stringWithFormat:@"%@", self.videoURL];
    
//    if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]) {
//        NSURL *url = [info objectForKey:UIImagePickerControllerReferenceURL];
//        if (self.videoURL) {
//            ALAssetsLibraryAssetForURLResultBlock resultBlock = ^(ALAsset *videoAsset) {
//                CLLocation *location = [videoAsset valueForProperty:ALAssetPropertyLocation];
//                self.video.location = location;
//                
//            };
//            ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error) {
//                NSLog(@"%@", error);
//            };
//            ALAssetsLibrary *assestLibrary = [ALAssetsLibrary new];
//            [assestLibrary assetForURL:self.videoURL resultBlock:resultBlock failureBlock:failureBlock];
//        }
//    }
    
//    [self dism:YES];
//}

//[[NSNotificationCenter defaultCenter] addObserver:self
//                                         selector:@selector(doneButtonClick:)
//                                             name:MPMoviePlayerDidExitFullscreenNotification
//                                           object:nil];
//
//[self dismissViewControllerAnimated:YES completion:nil];
//
//-(void)doneButtonClick:(NSNotification*)aNotification{
//    NSNumber *reason = [aNotification.userInfo objectForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey];
//    
//    if ([reason intValue] == MPMovieFinishReasonUserExited) {
//        [self dismissMoviePlayerViewControllerAnimated];
//    }
//}


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
