//
//  AnnotationVideoPlayerViewViewController.m
//  KingOfTheHill
//
//  Created by Gabriel Guerrero on 3/12/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "AnnotationVideoPlayerViewViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>

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
