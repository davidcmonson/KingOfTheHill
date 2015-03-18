//
//  VideoFeedTableViewCell.m
//  KingOfTheHill
//
//  Created by Ryan S. Watt on 3/16/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "VideoFeedTableViewCell.h"

@implementation VideoFeedTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

//+ (CGFloat)cellHeight {
//    return 550;
//}

@end
