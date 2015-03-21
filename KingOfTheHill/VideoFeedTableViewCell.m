//
//  VideoFeedTableViewCell.m
//  KingOfTheHill
//
//  Created by Ryan S. Watt on 3/16/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "VideoFeedTableViewCell.h"

@implementation VideoFeedTableViewCell
// use _underscore character ONLY for init/getter/setter methods
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor blackColor];
        [self.contentView setBackgroundColor:[UIColor blackColor]];
        _photoImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _photoImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_photoImageView];
        _cellHeight = _photoImageView.frame.size.height;
        _votes = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
        _votes.textColor = [UIColor whiteColor];
        [self.photoImageView addSubview:_votes];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.photoImageView.frame = self.bounds;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:YES];
    
    // Configure the view for the selected state
}

//+ (CGFloat)cellHeight {
//    return 550;
//}

@end
