//
//  UserController.h
//  KingOfTheHill
//
//  Created by Gabriel Guerrero on 3/13/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface UserController : NSObject

@property (nonatomic, strong) User *currentUser;

+ (UserController *)sharedInstance;
- (void)getProfileForCurrentUser:(User *)user;
- (void)getProfileForUser:(User *)user;
- (NSUInteger)getAllVotesByUser;
- (void)userToVoteToVideo;

@end

