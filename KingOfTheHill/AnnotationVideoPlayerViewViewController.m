//
//  AnnotationVideoPlayerViewViewController.m
//  KingOfTheHill
//
//  Created by Gabriel Guerrero on 3/12/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "AnnotationVideoPlayerViewViewController.h"


@interface AnnotationVideoPlayerViewViewController () <UIImagePickerControllerDelegate>

@property (nonatomic, strong) NSURL *videoURL;

@end

@implementation AnnotationVideoPlayerViewViewController




-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    self.videoURL = info[UIImagePickerControllerMediaURL];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    MPMoviePlayerController *player = [[MPMoviePlayerController alloc] initWithContentURL:self.videoURL];
    [player.view setFrame:self.view.bounds];
    [self.view addSubview:player.view];
    
    [player play];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //////////////// TEST VIDEO ///////////////
    //
    //- (void)viewDidAppear:(BOOL)animated {
    //
    //    PFFile *videoFile = self.arrayOfVideos[1][videoFileKey];
    //    NSURL *videoURL = [NSURL URLWithString:videoFile.url];
    //    AVAsset *video = [AVAsset assetWithURL:videoURL];
    //    AVPlayerItem *item = [[AVPlayerItem alloc] initWithAsset:video];
    //    AVPlayer *player = [AVPlayer playerWithPlayerItem:item];
    //    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:player];
    //    UIView *playerView = [[UIView alloc]initWithFrame:self.view.bounds];
    //    layer.frame = self.view.frame;
    //    [playerView.layer addSublayer:layer];
    //    [self.view addSubview: playerView];
    //    [player play];
    //}
    //// This will be put in AnnotationVideoPlayerViewController
    ////////////////////////////////////////////

    
    
    self.allowsEditing = YES;
    self.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *) kUTTypeMovie, nil];
    
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
