//
//  UserController.m
//  KingOfTheHill
//
//  Created by Gabriel Guerrero on 3/5/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "VideoController.h"
#import <ParseUI/ParseUI.h>
#import "LoadingStatus.h"

@implementation VideoController

- (id) init {
    self = [super init];
    if (self) {
        self.arrayOfArrayAllVotes = [NSMutableArray new];
    }
    return self;
}

+ (VideoController *)sharedInstance {
    
    static VideoController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[VideoController alloc] init];
    });
    return sharedInstance;
}

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
            UIAlertView *uploadSuccess = [[UIAlertView alloc] initWithTitle:@"Upload Successful" message:@"Your video was successfully uploaded to Alpha" delegate:self cancelButtonTitle:@"Awesome!" otherButtonTitles: nil];
            [uploadSuccess show];
        }
        else {
            UIAlertView *uploadSuccess = [[UIAlertView alloc] initWithTitle:@"Uh-oh..." message:@"Your video was unable to be uploaded to Alpha" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
            [uploadSuccess show];
            NSLog(@"%@", error);
        }
    }];
}

+ (void)queryVideosForFeed {
    NSLog(@"Photos Loading!");
    // Parse query calls.
    PFQuery *queryForVideos = [Video query];
    queryForVideos.limit = 10;
    [queryForVideos orderByDescending:@"createdAt"];
    [queryForVideos findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        }
        else {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                //[VideoController sharedInstance].objectArrayFromParse = objects;
                [VideoController sharedInstance].arrayOfVideoForFeed = objects;
                [[VideoController sharedInstance] populateThumbnailArray:objects];
                NSLog(@"%ld videos with thumbnails",(long)[VideoController sharedInstance].arrayOfVideoForFeed.count);
                NSLog(@"Thumbnails Loaded!");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"updateCellVotes" object:nil];
            });
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
            NSLog(@"added blank thumbnail for video %ld", (long)index);
            
        } else {
            
            [[VideoController sharedInstance] queryForVotesOnVideo:video];
            
            PFFile *thumbnailImage = video[urlOfThumbnail];
            NSURL *urlOfThumbnail = [NSURL URLWithString:thumbnailImage.url];
            NSData *dataOfThumbnail = [NSData dataWithContentsOfURL:urlOfThumbnail];
            UIImage *thumbnail = [UIImage imageWithData:dataOfThumbnail];
            [mutableArray addObject:thumbnail];
            NSLog(@"Thumbnail %ld", (long)index);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"updateCellVotes" object:nil];
            
        }
    }
    [VideoController sharedInstance].arrayOfThumbnails = mutableArray;
}


- (void)queryForVotesOnVideo:(Video *)object
{
    NSMutableArray *arrayOfUsers = [NSMutableArray new];
    PFQuery *voteQuery = [Vote query];
    [voteQuery whereKey:@"toVideo" equalTo:object];
    //   NSArray *objects = [voteQuery findObjects];
    [voteQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) return;
        
        for (Vote *vote in objects) {
            // This does not require a network access.
            PFUser *user = [vote objectForKey:@"fromUser"];
            [arrayOfUsers addObject:user];
            //            NSLog(@"Vote");
        }
        [[VideoController sharedInstance].arrayOfArrayAllVotes addObject:arrayOfUsers];
        
    }];
    //    return arrayOfUsers;
}

//- (void)populateArrayOfUsers:(NSArray *)voteArray {
//    NSMutableArray *arrayOfUsers = [NSMutableArray new];
//    //self.arrayOfArrayAllVotes = [NSMutableArray new];
//    if (arrayOfUsers == nil) {
//        arrayOfUsers = [NSMutableArray new];
//    }
//    for (Vote *vote in voteArray) {
//        PFUser *user = vote[@"fromUser"];
//        [arrayOfUsers addObject:user];
//    }
//    [VideoController sharedInstance].arrayOfUsersForCurrentVideo = arrayOfUsers;
//
//    [[VideoController sharedInstance].arrayOfArrayAllVotes addObject:arrayOfUsers];
//
//
//    NSLog(@"%lu", arrayOfUsers.count);
//    //[[NSNotificationCenter defaultCenter] postNotificationName:@"updateCellVotes" object:nil];
//}



@end