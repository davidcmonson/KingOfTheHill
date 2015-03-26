//
//  ThumbAnimation.m
//  KingOfTheHill
//
//  Created by Gabriel Guerrero on 3/26/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "ThumbAnimation.h"

@interface ThumbAnimation ()


@property (nonatomic) UIImageView *thumbImageView;

@end

@implementation ThumbAnimation

-(id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.backgroundColor = [UIColor clearColor];
        _thumbImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,100, 100)];
        _thumbImageView.image = [UIImage imageNamed:@"thumb100"];
        [self addSubview:_thumbImageView];
        
    }
    return self;
}

- (void)removeFromSuperviewWithFade {
    
    [UIView animateWithDuration:0.6f animations:^(void) {
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
