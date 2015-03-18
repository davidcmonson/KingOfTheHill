//
//  VideoFeedDataSource.m
//  KingOfTheHill
//
//  Created by Ryan S. Watt on 3/16/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "VideoFeedDataSource.h"
#import "VideoController.h"
#import "Video.h"


@implementation VideoFeedDataSource

- (void)registerTableView:(UITableView *)tableView {
    
    [tableView registerClass:[VideoFeedTableViewCell class] forCellReuseIdentifier:NSStringFromClass([VideoFeedTableViewCell class])];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [VideoController sharedInstance].arrayOfVideoForFeed.count;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoFeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([VideoFeedTableViewCell class])];
    Video *video = [VideoController sharedInstance].arrayOfVideoForFeed[indexPath.row];
    PFFile *thumbnailImage = video[urlOfThumbnail];
    NSURL *urlOfThumbnail = [NSURL URLWithString:thumbnailImage.url];
    NSData *dataOfThumbnail = [NSData dataWithContentsOfURL:urlOfThumbnail];
    cell.imageView.image = [UIImage imageWithData:dataOfThumbnail];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    return cell;
}

@end
