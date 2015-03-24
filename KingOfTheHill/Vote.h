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

static NSString *voteKey = @"Vote";

@interface Vote : PFObject <PFSubclassing>

@property (nonatomic, strong) NSString *objectId;


@end

