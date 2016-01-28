//
//  NewsTableViewController.h
//  Floyd
//
//  Created by admin on 16/1/4.
//  Copyright © 2016年 George She. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewPagerController.h"
#import "NewsChannelSelectViewController.h"

@interface NewsViewController
    : ViewPagerController <NewsChannelSelectViewControllerDelegate>
@property(nonatomic, strong) NewsChannelSelectViewController *channelSelectVC;
@end
