//
//  Votes.m
//  KingOfTheHill
//
//  Created by Trace Pomplun on 3/9/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "Vote.h"

@implementation Vote

+ (void)load
{
    [self registerSubclass];
}

+ (NSString *)parseClassName
{
    return @"Vote";
}

@dynamic objectId;

@end