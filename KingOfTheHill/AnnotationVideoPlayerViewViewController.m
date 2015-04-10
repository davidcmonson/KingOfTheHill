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
#import "ThumbAnimation.h"

@interface AnnotationVideoPlayerViewViewController ()

@property (nonatomic, strong) NSURL *videoURL;
@property (nonatomic, strong) AVPlayer *player;

@property (nonatomic, strong) Video *video;
@property (nonatomic, strong) Vote *vote;

@end

@implementation AnnotationVideoPlayerViewViewController


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    // add a temporary loading view
    LoadingStatus *loadingStatus = [LoadingStatus defaultLoadingStatusWithWidth:CGRectGetWidth(self.view.frame)
                                                                         Height:CGRectGetHeight(self.view.frame)];
    [self.view addSubview:loadingStatus];
    
    UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismissView)];
    [gestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [self.view addGestureRecognizer:gestureRecognizer];
    
    UITapGestureRecognizer *likeVideo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(likeVote:)];
    likeVideo.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:likeVideo];
    
    // loads the video and player asynchronously
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        PFFile *videoFile = self.video[urlOfVideo];
        self.videoURL = [NSURL URLWithString:videoFile.url];
        AVAsset *video = [AVAsset assetWithURL:self.videoURL];
        
        AVPlayerItem *item = [[AVPlayerItem alloc] initWithAsset:video];
        self.player = [AVPlayer playerWithPlayerItem:item];
        
        AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        layer.frame = self.view.frame;
        
        UIView *playerView = [[UIView alloc]initWithFrame:self.view.bounds];
        [playerView.layer addSublayer:layer];
        
        [self.view addSubview: playerView];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [loadingStatus removeFromSuperviewWithFade];
            [self.player play];
            
        });
    });
    
}

- (void)updateWithVideo:(Video *)video
{
    self.video = video;
}


- (void)likeVote:(id)likeGesture
{
    Vote *newVote = [Vote object];
    newVote[@"fromUser"] = [PFUser currentUser];
    newVote[@"toVideo"] = self.video;
    
    ThumbAnimation *thumb = [[ThumbAnimation alloc]initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 75,
                                                                            self.view.frame.size.height / 2 - 43,
                                                                            100, 100)];
    [self.view addSubview:thumb];
    [thumb removeFromSuperviewWithFade];
    
    [newVote saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"vote saved to Video");
        }
        else {
            NSLog(@"%@", error);
        }
    }];
    
    self.vote = newVote;
}

- (void)queryForVote
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateCellVotes" object:nil];
}

-(void)dismissView {
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self.player pause];
        [self.view removeFromSuperview];
        [self queryForVote];
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



@end
