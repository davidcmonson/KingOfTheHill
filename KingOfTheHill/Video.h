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

@property (nonatomic,strong) NSString *location;
@property (nonatomic) NSInteger durationOfVideoInSeconds;
@property (nonatomic,strong) NSDate *date;
@property (nonatomic) float ratingOfVideo;
@property (nonatomic,strong) NSString *descriptionOfVideo;
@property (nonatomic,strong) User *ownerOfVideo;




@end
