//
//  UILabel+DynamicLabel.m
//  KingOfTheHill
//
//  Created by Ryan S. Watt on 3/20/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "UILabel+DynamicLabel.h"

@implementation UILabel (DynamicLabel)

-(float)resizeToStretch{
    float height = [self expectedHeight];
    CGRect newFrame = [self frame];
    newFrame.size.height = height;
    [self setFrame:newFrame];
    return newFrame.origin.y + newFrame.size.height;
}

-(float)expectedHeight{
    [self setNumberOfLines:0];
    [self setLineBreakMode:UILineBreakModeWordWrap];
    
    CGSize maximumLabelSize = CGSizeMake(self.frame.size.width,9999);
    
    CGSize expectedLabelSize = [[self text] sizeWithFont:[self font]
                                       constrainedToSize:maximumLabelSize
                                           lineBreakMode:[self lineBreakMode]];
    return expectedLabelSize.height;
}

@end
