//
//  NewsChannelSelectViewController.h
//  Floyd
//
//  Created by George She on 16/1/21.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "FDTableViewController.h"
#import "RSSChannel.h"

@protocol NewsChannelSelectViewControllerDelegate <NSObject>
- (void)channelSelected:(RSSChannel *)selectedChannel;
@end

@interface NewsChannelSelectViewController : FDTableViewController
@property(nonatomic, strong) NSArray *channelList;
@property(nonatomic, weak) id<NewsChannelSelectViewControllerDelegate> delegate;
@end
