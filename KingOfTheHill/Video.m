//
//  Video.m
//  KingOfTheHill
//
//  Created by Trace Pomplun on 3/10/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "Video.h"

@implementation Video

@dynamic name;
@dynamic videoFile;
@dynamic user;
@dynamic location;

+ (NSString *)parseClassName
{
    return @"Video";
}

@end