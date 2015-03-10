//
//  User.h
//  KingOfTheHill
//
//  Created by David Monson on 3/5/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import <Parse/Parse.h>
#import <Foundation/Foundation.h>

static NSString *userReferenceKey = @"user";

static NSString *nameKey = @"name";
static NSString *votesKey = @"votes";
static NSString *userVideoKey = @"video";

@interface User : PFObject

@property (nonatomic, assign) float votes;
@property (nonatomic, strong) NSArray *videos;
@property (nonatomic, strong) NSString *name;

@end
