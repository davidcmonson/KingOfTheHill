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

@protocol Player;

@interface VideoFeedDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, strong) id <Player> delegate;

-(void)registerTableView:(UITableView *)tableView;

@end

@protocol Player <NSObject>

- (void)bringUpPlayer:(NSInteger)index;

@end
