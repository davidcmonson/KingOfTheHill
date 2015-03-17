//
//  AnnotationVideoPlayerViewViewController.m
//  KingOfTheHill
//
//  Created by Gabriel Guerrero on 3/12/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "AnnotationVideoPlayerViewViewController.h"
#import "LocationViewController.h"
#import "VideoController.h"
#import "LoadingStatus.h"

@interface AnnotationVideoPlayerViewViewController ()

@property (nonatomic, strong) NSURL *videoURL;
@property (nonatomic, strong) AVPlayer *player;


@end

@implementation AnnotationVideoPlayerViewViewController


- (void)viewDidAppear:(BOOL)animated {
    // add a temporary loading view
    LoadingStatus *loadingStatus = [LoadingStatus defaultLoadingStatusWithWidth:CGRectGetWidth(self.view.frame)
                                                                         Height:CGRectGetHeight(self.view.frame)];
    [self.view addSubview:loadingStatus];
    
    UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismissView)];
    [gestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [self.view addGestureRecognizer:gestureRecognizer];
    
    // loads the video and player asynchronously
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
#warning the index should be passed into this ViewController to show the appropriate video
        PFFile *videoFile = [VideoController sharedInstance].arrayOfVideos[0][urlOfVideo];
        self.videoURL = [NSURL URLWithString:videoFile.url];
        AVAsset *video = [AVAsset assetWithURL:self.videoURL];
        AVPlayerItem *item = [[AVPlayerItem alloc] initWithAsset:video];
        self.player = [AVPlayer playerWithPlayerItem:item];
        AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        UIView *playerView = [[UIView alloc]initWithFrame:self.view.bounds];
        layer.frame = self.view.frame;
        [playerView.layer addSublayer:layer];
        [self.view addSubview: playerView];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [loadingStatus removeFromSuperviewWithFade];
            [self.player play];
            
        });
    });
    
}


-(void)dismissView {
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self.player pause];
        [self.view removeFromSuperview];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:.6]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
