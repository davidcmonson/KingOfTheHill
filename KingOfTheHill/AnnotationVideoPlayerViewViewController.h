//
//  AnnotationVideoPlayerViewViewController.h
//  KingOfTheHill
//
//  Created by Gabriel Guerrero on 3/12/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface AnnotationVideoPlayerViewViewController : UIImagePickerController

@property (nonatomic, strong) AVPlayer *player;

@end
