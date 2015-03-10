//
//  Video.h
//  KingOfTheHill
//
//  Created by Trace Pomplun on 3/10/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import <Parse/Parse.h>
#import "User.h"

@interface Video : PFObject

@property (nonatomic, strong) User *ownerOfVideo;

@end
