//
//  Video.m
//  KingOfTheHill
//
//  Created by Trace Pomplun on 3/10/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "Video.h"

@implementation Video

+ (void)load
{
    [self registerSubclass];
}

+ (NSString *)parseClassName
{
    return @"Video";
}

@dynamic ownerOfVideo;
@dynamic objectId;
@dynamic location;
@dynamic thumbnail;
@dynamic videoFile;
@dynamic videoAtIndex;
@dynamic Votes;

@end