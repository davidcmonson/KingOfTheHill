//
//  Votes.h
//  KingOfTheHill
//
//  Created by Trace Pomplun on 3/9/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Video.h"

@interface Vote : NSObject

@property (nonatomic, strong) User *user;
@property (nonatomic, strong) Video *video;
@property (nonatomic, assign) BOOL *like;
@property (nonatomic, strong) NSString *uniqueId;

@end
