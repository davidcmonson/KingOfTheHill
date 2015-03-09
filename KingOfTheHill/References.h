//
//  References.h
//  KingOfTheHill
//
//  Created by Trace Pomplun on 3/9/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface References : NSObject

@property (nonatomic, strong) User *submitter;
@property (nonatomic, strong) NSArray *arrayOfVideoVotes;

@end
