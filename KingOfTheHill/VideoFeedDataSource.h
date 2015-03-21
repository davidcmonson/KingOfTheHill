//
//  VideoFeedDataSource.h
//  KingOfTheHill
//
//  Created by Ryan S. Watt on 3/16/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VideoFeedTableViewCell.h"
@class Video;

@interface VideoFeedDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, strong) UILabel *votes;
@property (nonatomic, strong) Video *video;

-(void)registerTableView:(UITableView *)tableView;

@property (nonatomic) CGRect dimensionsOfScreen;

@end
