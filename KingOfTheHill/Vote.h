//
//  Votes.h
//  KingOfTheHill
//
//  Created by Trace Pomplun on 3/9/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import <Parse/Parse.h>
#import <Foundation/Foundation.h>
#import "User.h"

static NSString *voteReferenceKey = @"vote";

static NSString *voteIDKey = @"uniqueID";
static NSString *voteOnUserKey = @"user";
static NSString *voteOnVideoKey = @"video";
static NSString *likeVoteKey = @"like";

@interface Vote : PFObject

@property (nonatomic, strong) User *user;
@property (nonatomic, assign) BOOL *likeVote;
@property (nonatomic, strong) NSString *uniqueId;

@end
