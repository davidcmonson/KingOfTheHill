//
//  AnnotationVideoPlayerViewViewController.h
//  KingOfTheHill
//
//  Created by Gabriel Guerrero on 3/12/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Video.h"

@interface AnnotationVideoPlayerViewViewController : UIViewController

@property (nonatomic) NSInteger videoAtIndex;
@property (nonatomic, strong) Video *currentVideo;

- (void)updateWithVideo:(Video *)video;

@end
