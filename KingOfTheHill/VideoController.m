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
                 andLocation:(PFGeoPoint *)currentLocationGeoPoint
                andThumbnail:(PFFile *)thumbnailFile
{
    Video *video = (Video *)[PFObject objectWithClassName:@"Video"];
    
    video[@"videoFile"] = file;
    video[@"location"] = currentLocationGeoPoint;
    video[@"thumbnail"] = thumbnailFile;
    [video saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"Video has been uploaded to Parse");
        }
        else {
            NSLog(@"%@", error);
        }
    }];
}

//- (void)relationshipBetweenVote:(NSArray *)votes Video:(Video *)video
//{
//    video = (Video *)[PFObject objectWithClassName:@"Video"];
//    Vote *voteObject = (Vote *)[PFObject objectWithClassName:@"Vote"];
//    for (Vote *vote in votes) {
//        [votes indexOfObject:vote];
//    }
//    voteObject[@"Video"] = video;
////    voteObject[@"name"] = name;
//    [voteObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (succeeded) {
//            NSLog(@"relation between vote and video saved");
//        }
//    }];
//}

// Method to fetch videos
//
//
//
//
//

+ (void)queryVideosForFeed {
    NSLog(@"Photos Loading!");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        // Parse query calls.
        PFQuery *queryForVideos = [Video query];
        [queryForVideos findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (error) {
                NSLog(@"%@", error);
            }
            else {
                //[VideoController sharedInstance].objectArrayFromParse = objects;
                [VideoController sharedInstance].arrayOfVideoForFeed = objects;
                [[VideoController sharedInstance] populateThumbnailArray:objects];
                NSLog(@"%ld videos with thumbnails",(long)[VideoController sharedInstance].arrayOfVideoForFeed.count);
                NSLog(@"Thumbnails Loaded!");
            }
        }];
    });
    
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
            PFFile *thumbnailImage = video[urlOfThumbnail];
            NSURL *urlOfThumbnail = [NSURL URLWithString:thumbnailImage.url];
            NSData *dataOfThumbnail = [NSData dataWithContentsOfURL:urlOfThumbnail];
            UIImage *thumbnail = [UIImage imageWithData:dataOfThumbnail];
            [mutableArray addObject:thumbnail];
        
//            NSOperationQueue *queue = NSOperationQueuePriorityNormal;
//            [queue addOperationWithBlock:^{
//            PFQuery *queryForVotes = [Vote query];
//            self.numberOfVotesForVideo = [NSString stringWithFormat:@"%ld", (long)[queryForVotes whereKey:@"toVideo" equalTo:videoId].countObjects];
//            NSLog(@"%@",[NSString stringWithFormat:@"%ld", (long)[queryForVotes whereKey:@"toVideo" equalTo:videoId].countObjects]);
//            }];
////            [queryForVotes findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
////                if (error) {
////                    NSLog(@"%@", error);
////                }
////                else {
////                    NSLog(@"success");
        }
    }
//
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
//    }}

- (void)queryForIndividualVote:(Vote *)vote
{
    PFQuery *queryForVote = [Vote query];
    [queryForVote findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        }
        else {
            [self.arrayOfVotes arrayByAddingObjectsFromArray:objects];
            NSLog(@"queried vote");
            NSLog(@"%@", self.arrayOfVotes);
        }
    }];
}

- (void)queryForVotes:(Vote *)vote onVideo:(Video *)video
{
        PFQuery *queryForVotes = [Vote query];
        [queryForVotes whereKey:vote.objectId equalTo:video.objectId];
        [queryForVotes findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (error) {
                NSLog(@"This is the error quering for objects :%@",error);
            } else {
                NSLog(@"success: %@ and %@",video.objectId, vote.objectId);
                [self.arrayOfVotes arrayByAddingObjectsFromArray:objects];
            }
        }];

}


//- (NSInteger)totalVotesOnVideoWithIdentifier:(NSString *)identifier
//{
//    PFQuery *queryForVotes = [PFQuery queryWithClassName:@"Vote"];
//    [queryForVotes findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (error) {
//            NSLog(@"%@", error);
//        }
//        else {
////            NSMutableArray *mutableObjects = [[NSMutableArray alloc] initWithArray:objects];
////            for (Vote *votes in objects) {
////                [mutableObjects addObject:votes];
//            
//                [VideoController sharedInstance].arrayOfVotes = objects;
//                NSLog(@"%ld", (long)[VideoController sharedInstance].arrayOfVotes.count);
////            }
//            
//        }
//    }];
//}
 

@end