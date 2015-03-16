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
#import "Vote.h"

static NSString *userKey = @"User";

static NSString *objectIdKey = @"objectId";
static NSString *usernameKey = @"username";
static NSString *passwordKey = @"password";
static NSString *emailKey = @"email";

@interface User : PFObject

@property (nonatomic, strong) NSString *objectID;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, assign) NSUInteger userVote;


@end
