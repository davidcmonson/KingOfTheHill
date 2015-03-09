//
//  Video.h
//  KingOfTheHill
//
//  Created by Gabriel Guerrero on 3/5/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Video : NSObject

@property (nonatomic, strong) CKRecord *asset;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *videoUniqueId;

@end
