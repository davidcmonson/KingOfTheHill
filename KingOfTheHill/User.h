//
//  User.h
//  KingOfTheHill
//
//  Created by David Monson on 3/5/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, strong) NSString *firstLastName;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userEmail;
@property (nonatomic, strong) NSString *userBio;
@property (nonatomic) float userRating;  //?CGFloat?
@property (nonatomic, strong) NSURL *userUrl;
@property (nonatomic, strong) NSArray *userVideos;


@end
