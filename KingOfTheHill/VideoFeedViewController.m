//
//  VideoFeedViewController.m
//  KingOfTheHill
//
//  Created by Ryan S. Watt on 3/12/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "VideoFeedViewController.h"
#import "VideoFeedTableViewCell.h"
#import "VideoFeedDataSource.h"
#import "Video.h"
#import "VideoController.h"
#import "AnnotationVideoPlayerViewViewController.h"
#import "LoadingStatus.h"


@interface VideoFeedViewController () <UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) VideoFeedDataSource *dataSource;

@property (nonatomic, strong) UIButton *headerButton;

@end

@implementation VideoFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [VideoFeedDataSource new];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(-15, 0, self.view.frame.size.width, self.view.frame.size.height + 10) style:UITableViewStylePlain];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.delegate = self;
    
    
    [self.dataSource registerTableView:self.tableView];
    self.tableView.dataSource = _dataSource;
    
//    UITapGestureRecognizer *snowboardTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToSnowboardFeed:)];
//    [snowboardTapGesture setNumberOfTouchesRequired:1];
//    [snowboarderView addGestureRecognizer:snowboardTapGesture];
    [self.view addSubview:self.tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Video *video = [VideoController sharedInstance].arrayOfVideos[indexPath.row];
    PFFile *thumbnailImage = video[urlOfThumbnail];
    NSURL *urlOfThumbnail = [NSURL URLWithString:thumbnailImage.url];
    NSData *dataOfThumbnail = [NSData dataWithContentsOfURL:urlOfThumbnail];
    UIImage *image = [UIImage imageWithData:dataOfThumbnail];
    UIImageView *thumbnailView = [[UIImageView alloc] initWithImage:image];
    return thumbnailView.frame.size.height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self bringUpPlayer:indexPath.row];
    [self vote];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
                       
- (void)bringUpPlayer:(NSInteger)index {
    
    AnnotationVideoPlayerViewViewController *videoVC = [AnnotationVideoPlayerViewViewController new];
    videoVC.videoAtIndex = index;
    videoVC.edgesForExtendedLayout = UIRectEdgeNone;
    videoVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    videoVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;;
    [self presentViewController:videoVC animated:YES completion:nil];
    
//    if (!UIAccessibilityIsReduceTransparencyEnabled) {
//        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
//        UIVisualEffectView *viewWithBlurredBackground = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
//        viewWithBlurredBackground.frame = self.view.bounds;
//        [self.view addSubview:viewWithBlurredBackground];
    
        //only apply the blur if the user hasn't disabled transparency effects
        
        //if you have more UIViews on screen, use insertSubview:belowSubview: to place it underneath the lowest view
        
        //add auto layout constraints so that the blur fills the screen upon rotating device
        //viewWithBlurredBackground.setTranslatesAutoresizingMaskIntoConstraints(false);
        //        self.view.addConstraint(NSLayoutConstraint(item: blurEffectView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0));
        //        self.view.addConstraint(NSLayoutConstraint(item: blurEffectView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0));
        //        self.view.addConstraint(NSLayoutConstraint(item: blurEffectView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0));
        //        self.view.addConstraint(NSLayoutConstraint(item: blurEffectView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0));
//    } else {
//        self.view.backgroundColor = [UIColor blackColor];
//    }
}




@end
