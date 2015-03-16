//
//  CameraPickerControllerDelegate.m
//  KingOfTheHill
//
//  Created by Trace Pomplun on 3/16/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>
@import AssetsLibrary;
@import AVFoundation;
#import "CameraPickerControllerDelegate.h"
#import "MediaPlayerViewController.h"
#import "LocationViewController.h"

@interface CameraPickerControllerDelegate ()

@end

@implementation CameraPickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    self.videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
    
    ALAssetsLibrary *videoLibrary = [ALAssetsLibrary new];
    [videoLibrary writeVideoAtPathToSavedPhotosAlbum:self.videoURL completionBlock:^(NSURL *assetURL, NSError *error) {
        if (assetURL) {
            [videoLibrary assetForURL:self.videoURL resultBlock:^(ALAsset *asset) {
                
                ALAssetRepresentation *rep = [asset defaultRepresentation];
                NSDictionary *metadata = rep.metadata;
                NSLog(@"%@", metadata);
                
                CGImageRef iref = [rep fullScreenImage] ;
                
                if (iref) {
                    NSLog(@"Everything is awesome");
                }
            } failureBlock:^(NSError *error) {
                // error handling
            }];
        }
    }];
    
    
    
    
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
//    
//    MPMoviePlayerController *playerController = [[MPMoviePlayerController alloc]initWithContentURL:[info objectForKey:UIImagePickerControllerReferenceURL]];
//    playerController.controlStyle = MPMovieControlStyleDefault;
////    [playerController.view setFrame:self.view.bounds];
////    [self.view addSubview:playerController.view];
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

    [picker dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}




@end
