//
//  Location.h
//  KingOfTheHill
//
//  Created by Gabriel Guerrero on 3/5/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Location : NSObject

@property (nonatomic) float latitudeCoordinate;
@property (nonatomic) float longitudeCoordinate;
@property (nonatomic) float areaRadius;
@property (nonatomic,strong) NSString *locationName;
@property (nonatomic,strong) User *kingOfTheHill; // Figure out "lingo" for locations: "Hill"? "Spot"? "Boot"?

@end
