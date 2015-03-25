//
//  SectionHeaderView.m
//  KingOfTheHill
//
//  Created by Trace Pomplun on 3/20/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "SectionHeaderView.h"

@implementation SectionHeaderView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */


- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.votes = [UILabel new];
        self.votes.backgroundColor = [UIColor blackColor];
        [self addSubview:self.votes];
        
        self.userName = [UILabel new];
        self.userName.backgroundColor = [UIColor yellowColor];
        [self addSubview:self.userName];
        
        self.upVote = [UIButton new];
        self.upVote.backgroundColor = [UIColor redColor];
        [self addSubview:self.upVote];
        
        NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(_votes, _userName);
        
        NSArray *horizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_userName]-[_votes(>=20)]-|" options:0 metrics:nil views:viewDictionary];
        
        NSArray *verticalConstraintUserName = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_userName]|"options:0 metrics:nil views:viewDictionary];
        NSArray *verticalConstraintVotes = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_votes]|"options:0 metrics:nil views:viewDictionary];
        //        NSArray *verticalConstraintUpVote = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_upVote]|"options:0 metrics:nil views:viewDictionary];
        
        [self addConstraints:horizontal];
        [self addConstraints:verticalConstraintUserName];
        [self addConstraints:verticalConstraintVotes];
        //        [self addConstraints:verticalConstraintUpVote];
        
    }
    return self;
}

+ (CGFloat)headerHeight
{
    return 0;
}

- (void)updateWithUserName:(NSString *)name votes:(CGFloat)votes andUpVotes:(UIButton *)upVotes
{
    
}
@end
