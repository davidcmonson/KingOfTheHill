//
//  User.h
//  KingOfTheHill
//
//  Created by David Monson on 3/5/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import <Parse/Parse.h>
#import <Foundation/Foundation.h>
#import "Video.h"

static NSString *userKey = @"User";

static NSString *userVideoKey = @"userVideo";
static NSString *userVoteKey = @"userVote";

@interface User : PFObject

@property (nonatomic, strong) Video *video;
@property (nonatomic, assign) NSString *votes;


@end
