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

- (void)videoToParseWithFile:(PFFile *)file andLocation:(PFGeoPoint *)currentLocationGeoPoint
{
    Video *video = (Video *)[PFObject objectWithClassName:@"Video"];

    video[@"videoFile"] = file;
    video[@"location"] = currentLocationGeoPoint;
    
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
                NSLog(@"%ld videos with thumbnails",(long)[VideoController sharedInstance].arrayOfVideoForFeed.count);
                NSLog(@"Thumbnails Loaded!");
            }
        }];
    });
    
}

#warning will need checker if the PFFile has a file or not (crashes when it tries to assign thumbnailOfVideo)
// takes in the array from Parse, adds an image to each of it and puts it back into the sharedInstance array
- (void)populateThumbnailArray:(NSArray *)array {
    
    
    NSMutableArray *mutableArray = [NSMutableArray new];
    for (NSInteger index = 0; index < array.count; index++) {
        
        Video *video = array[index];
        if (!video[urlOfThumbnail]) {
        [mutableArray addObject:[UIImage imageNamed:@"blank"]];
            NSLog(@"added blank thumbnail for video %ld", (long)index);
        } else {
        PFFile *thumbnailImage = video[urlOfThumbnail];
        NSURL *urlOfThumbnail = [NSURL URLWithString:thumbnailImage.url];
        NSData *dataOfThumbnail = [NSData dataWithContentsOfURL:urlOfThumbnail];
        UIImage *thumbnail = [UIImage imageWithData:dataOfThumbnail];
        [mutableArray addObject:thumbnail];
        }
        
        
    }
    [VideoController sharedInstance].arrayOfThumbnails = mutableArray;
    //NSLog(@"%@", [VideoController sharedInstance].arrayOfThumbnails);
}

//- (NSIndexPath *)indexPathofThumbnail:(UIImage *)imageOfThumbnail
//{
//    for (UIImage *image in self.arrayOfThumbnails) {
//    NSUInteger index = [self.arrayOfThumbnails indexOfObject:image];
//    self.indexPathOfThumbnail = [NSIndexPath indexPathWithIndex:index];
//    }
//    return self.indexPathOfThumbnail;
//}

- (void)voteToUser:(NSString *)vote
{
    Vote *voteObject = (Vote *)[PFObject objectWithClassName:@"User"];
    voteObject[@"Vote"] = vote;
    [voteObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"vote saved");
        }
    }];
}

- (NSInteger)totalVotesOnVideoWithIdentifier:(NSString *)identifier
{
    PFQuery *votesOnVideo = [PFQuery queryWithClassName:voteKey];
    [votesOnVideo whereKey:@"toVideo" equalTo:identifier];
    return [votesOnVideo countObjects];
}



@end