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

//- (void)relationshipBetweenVideoAndUser
//{
//    // create user object
//    PFObject *user = [PFObject objectWithClassName:@"User"];
//
//    // user video
//    PFObject *video = [PFObject objectWithClassName:@"Video"];
//
//    // set who the video is creatd by
//    [video setObject:user forKeyedSubscript:@"ownerOfVideo"];
//}
//
//- (void)relationshipBetweenVoteAndVideo
//{
//    PFObject *video = [PFObject objectWithClassName:@"video"];
//
//    PFObject *vote = [PFObject objectWithClassName:@"vote"];
//
//    [vote setObject:video forKeyedSubscript:@"voteSetOnVideo"];
//}

- (void)videoToParseWithFile:(PFFile *)file
                 andLocation:(PFGeoPoint *)currentLocationGeoPoint
                andThumbnail:(PFFile *)thumbnailFile andName:(NSString *)name
{
    Video *video = (Video *)[PFObject objectWithClassName:@"Video"];
    
    video[@"videoFile"] = file;
    video[@"location"] = currentLocationGeoPoint;
    video[@"thumbnail"] = thumbnailFile;
    video[@"name"] = name;
    [video saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"Video has been uploaded to Parse");
        }
        else {
            NSLog(@"%@", error);
        }
    }];
}

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
        // Parse query calls.
        PFQuery *queryForVideos = [PFQuery queryWithClassName:@"Video"];
        [queryForVideos findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (error) {
                NSLog(@"%@", error);
            }
            else {
                //[VideoController sharedInstance].objectArrayFromParse = objects;
                [VideoController sharedInstance].arrayOfVideoForFeed = objects;
                [[VideoController sharedInstance] populateThumbnailArray:objects];
                NSLog(@"%ld videos with thumbnails",[VideoController sharedInstance].arrayOfVideoForFeed.count);
                NSLog(@"Thumbnails Loaded!");
            }
        }];
}


// takes in the array from Parse, adds an image to each of it and puts it back into the sharedInstance array
- (void)populateThumbnailArray:(NSArray *)array {
    
    NSMutableArray *mutableArray = [NSMutableArray new];
    for (NSInteger index = 0; index < array.count; index++) {
        
        Video *video = array[index];
        if (!video[urlOfThumbnail]) {
            // add "missing thumbnail" picture if video doesn't have thumbnail
            [mutableArray addObject:[UIImage imageNamed:@"blank"]];
            NSLog(@"added blank thumbnail for video %ld", index);
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

//// takes in the array from Parse, adds an image to each of it and puts it back into the sharedInstance array
//-(NSArray *)arrayOfThumbnails
//{
//    NSArray *array = [VideoController sharedInstance].objectArrayFromParse;
//    NSMutableArray *mutableArray = [NSMutableArray new];
//    for (NSInteger index = 0; index < array.count; index++) {
//        
//        Video *video = array[index];
//        if (!video[urlOfThumbnail]) {
//            // add "missing thumbnail" picture if video doesn't have thumbnail
//            [mutableArray addObject:[UIImage imageNamed:@"blank"]];
//            NSLog(@"added blank thumbnail for video %ld", index);
//        } else {
//            PFFile *thumbnailImage = video[urlOfThumbnail];
//            NSURL *urlOfThumbnail = [NSURL URLWithString:thumbnailImage.url];
//            NSData *dataOfThumbnail = [NSData dataWithContentsOfURL:urlOfThumbnail];
//            UIImage *thumbnail = [UIImage imageWithData:dataOfThumbnail];
//            [mutableArray addObject:thumbnail];
//        }
//
//    }
//    return mutableArray;
//}


- (NSInteger)totalVotesOnVideoWithIdentifier:(NSString *)identifier
{
    PFQuery *votesOnVideo = [PFQuery queryWithClassName:voteKey];
    [votesOnVideo whereKey:@"toVideo" equalTo:identifier];
    return [votesOnVideo countObjects];
}



@end