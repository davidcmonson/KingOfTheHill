//
//  UserController.m
//  KingOfTheHill
//
//  Created by Gabriel Guerrero on 3/5/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "VideoController.h"
#import <ParseUI/ParseUI.h>

@implementation VideoController

+ (VideoController *)sharedInstance {
    
    static VideoController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[VideoController alloc] init];
    });
    return sharedInstance;
}

- (void)videoToParseWithFile:(PFFile *)file
{
    Video *video = (Video *)[PFObject objectWithClassName:videoKey];
    //video[@"name"] = video.nameOfVideo;
    video[@"videoFile"] = file;
#warning come back here
    //    video[coordinateOfVideoKey] = video.coordinate;
    // [video pin];
    [video saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"videoKey saved");
        }
        else {
            NSLog(@"%@", error);
        }
    }];
}

// Method to fetch videos
//
//
//
//
//

- (void)userToVoteToVideo:(Video *)video
{
    PFObject *likedVideo = [PFObject objectWithClassName:videoKey];
    PFObject *vote = [PFObject objectWithClassName:voteKey];
#warning attach vote to Video
    [vote setObject:[PFUser currentUser] forKey:@"fromUser"];
    [vote setValue:likedVideo forKey:@"toVideo"];
    [vote saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"two way relation from user to vote to video saved");
        }
        else {
            NSLog(@"%@", error);
        }
    }];
}

+ (void)queryVideosForFeed {
                 NSLog(@"Photos Loading!");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Parse query calls.
        PFQuery *queryForVideos = [PFQuery queryWithClassName:@"Video"];
        [queryForVideos findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (error) {
                NSLog(@"%@", error);
            }
            else {
                //NSArray *arrayOfVideos = [[NSArray alloc] initWithArray:objects];
                [VideoController sharedInstance].arrayOfVideoForFeed = objects;
                [[VideoController sharedInstance] populateThumbnailArray:objects];
                NSLog(@"%ld",[VideoController sharedInstance].arrayOfVideoForFeed.count);
            }
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
             NSLog(@"Photos Loaded!");
        });
    });
    
}

// takes in the array from Parse, adds an image to each of it and puts it back into the sharedInstance array
- (void)populateThumbnailArray:(NSArray *)array {
    NSMutableArray *mutableArray = [NSMutableArray new];
    //#warning will need checker if the PFFile has a file or not (crashes when it tries to assign thumbnailOfVideo)
    for (NSInteger index = 0; index < array.count; index++) {
        Video *video = array[index];
        PFFile *thumbnailImage = video[urlOfThumbnail];
        NSURL *urlOfThumbnail = [NSURL URLWithString:thumbnailImage.url];
        NSData *dataOfThumbnail = [NSData dataWithContentsOfURL:urlOfThumbnail];
        UIImage *thumbnail = [UIImage imageWithData:dataOfThumbnail];
        [mutableArray addObject:thumbnail];
        
    }
    [VideoController sharedInstance].arrayOfThumbnails = mutableArray;
    NSLog(@"%@", [VideoController sharedInstance].arrayOfThumbnails);
}


- (NSInteger)totalVotesOnVideoWithIdentifier:(NSString *)identifier
{
    PFQuery *votesOnVideo = [PFQuery queryWithClassName:voteKey];
    [votesOnVideo whereKey:@"toVideo" equalTo:identifier];
    return [votesOnVideo countObjects];
}



@end