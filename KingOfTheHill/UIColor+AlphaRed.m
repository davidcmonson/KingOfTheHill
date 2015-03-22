//
//  ColorRandomizer.m
//  Day4StretchProblem-RandomColor
//
//  Created by Gabriel Guerrero on 2/19/15.
//  Copyright (c) 2015 Gabe Guerrero. All rights reserved.
//

#import "UIColor+AlphaRed.h"
#define RGB(R, G, B)  ([UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:1.0f])

@implementation UIColor (AlphaRed)

+ (UIColor *)alphaRed {
    return  RGB(217, 54, 39);
}


@end
