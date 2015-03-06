//
//  UserController.h
//  KingOfTheHill
//
//  Created by Gabriel Guerrero on 3/5/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserController : NSObject

@property (nonatomic,strong) NSArray *arrayOfUsers;

#pragma mark User CRUD methods
-(id)initWithFirstAndLastName:(NSString *)firstAndLastName username:(NSString *)username email:(NSString *)email;
-(void)addUser;
-(void)updateUserRating;
-(void)save;

#pragma mark Video CRUD methods
-(void)initWithDate:(NSDate *)date locationLat:(float) latitude locationLong:(float) longitude;
-(void)addVideo;
-(void)deleteVideo;
-(void)getUserInfo;

@end
