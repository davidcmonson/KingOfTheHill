//
//  UserController.h
//  KingOfTheHill
//
//  Created by Gabriel Guerrero on 3/5/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Video.h"
#import "Vote.h"

@interface VideoController : NSObject

- (void)addVideo:(NSDictionary *)dictionary;
- (void)createCKRecord;
- (void)createCKAssest;
- (void)saveToCloudKit;
- (void)createCKReferenceToUser:(User *)user;

// - builder methods convert from ckrecords to objects and objects to ckrecords;
// - CKReferences child to parent, video -> user.... vote -> video

- (void)addVote:(Vote *)vote toVideo:(Video *)video;
- (void)createVoteCKRecord;
- (void)createCKReferencetoVideo:(Video *)video;
- (void)getVideosFromLocation:(CALocation *)location withRadius:(Location *)radius;

@end
