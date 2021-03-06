//
//  SectionHeaderView.h
//  KingOfTheHill
//
//  Created by Trace Pomplun on 3/20/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "Vote.h"
#import "User.h"
#import <UIKit/UIKit.h>

@interface SectionHeaderView : UIView

@property (nonatomic, strong) UILabel *votes;
@property (nonatomic, strong) UILabel *userName;
@property (nonatomic, strong) UIButton *upVote;

+ (CGFloat)headerHeight;
- (void)updateWithUserName:(NSString *)name votes:(CGFloat)votes andUpVotes:(UIButton *)upVotes;

@end
