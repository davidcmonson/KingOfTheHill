//
//  VideoFeedTableViewCell.m
//  KingOfTheHill
//
//  Created by Ryan S. Watt on 3/16/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "VideoController.h"
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
        
        _arrayOfUsers = [[NSArray alloc] init];
        
        _voteCount = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width - 30, self.bounds.size.height - 34 , 300, 24)];
        _voteCount.textColor = [UIColor whiteColor];
        
        UIImageView *thumb = [[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.size.width - 60,
                                                                          self.bounds.size.height - 34,
                                                                          24, 24)];
        thumb.image = [UIImage imageNamed:@"thumb24"];
        thumb.tintColor = [UIColor whiteColor];
        [_photoImageView addSubview:thumb];
        [_photoImageView addSubview:_voteCount];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.photoImageView.frame = self.bounds;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:YES];
    
}


@end
