//
//  NewsChannelSelectViewController.m
//  Floyd
//
//  Created by George She on 16/1/21.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "NewsChannelSelectViewController.h"
#import "RSSChannel.h"

@implementation NewsChannelSelectViewController
- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor ex_separatorLineColor];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self loadData];
}

- (void)loadData {
  NSMutableArray *tableContents = [NSMutableArray new];
  [tableContents addObject:@"频道列表"];

  for (RSSChannel *channel in self.channelList) {
    [tableContents addObject:[NITitleCellObject objectWithTitle:channel.title]];
  }
  [self setTableData:tableContents];
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  RSSChannel *channel = self.channelList[indexPath.row];
  if ([self.delegate respondsToSelector:@selector(channelSelected:)]) {
    [self.delegate channelSelected:channel];
  }
}
@end
