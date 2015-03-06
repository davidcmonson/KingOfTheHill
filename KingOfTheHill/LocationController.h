//
//  LocationController.h
//  KingOfTheHill
//
//  Created by Gabriel Guerrero on 3/5/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationController : NSObject


-(id)initWithName:(NSString *)locationName latitude:(float)latitude longitude:(float)longitude radius:(float)radius;
-(void)updateKing;
-(void)addVideo;
-(void)removeVideo;

@end
