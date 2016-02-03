//
//  NewsListViewController.m
//  Floyd
//
//  Created by admin on 16/1/8.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "NewsListViewController.h"
#import "SinaRSSApi.h"
#import "NewsItemCell.h"
#import "FDWebViewController.h"
#import "MJRefresh.h"

@interface NewsListViewController ()
@property(nonatomic, strong) RSSChannelDetail *rssItems;
@property(nonatomic, strong) SinaRSSApi *rssApi;

@property(nonatomic, strong) NITableViewActions *action;
@end

@implementation NewsListViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.rssApi = [[SinaRSSApi alloc] init];
  [self udpateNews];
  self.tableView.mj_header =
      [MJRefreshNormalHeader headerWithRefreshingTarget:self
                                       refreshingAction:@selector(loadNewData)];
  [self.tableView.mj_header beginRefreshing];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
}

- (void)loadNewData {
  [self.rssApi loadItemsWithUrl:self.subChannel.xmlUrl
      success:^(RSSChannelDetail *ret) {
        self.rssItems = ret;
        [self udpateNews];
        [self.tableView.mj_header endRefreshing];
      }
      failed:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self showError:error];
      }];
}

- (void)udpateNews {
  NSMutableArray *contents = [@[] mutableCopy];
  self.action = [[NITableViewActions alloc] initWithTarget:self];
  if (self.rssItems) {
    for (RSSItemModel *item in self.rssItems.item) {
      NewsItemCellUserData *userData = [[NewsItemCellUserData alloc] init];
      userData.newsItem = item;
      [contents
          addObject:[self.action attachToObject:
                                     [[NICellObject alloc]
                                         initWithCellClass:[NewsItemCell class]
                                                  userInfo:userData]
                                    tapSelector:@selector(itemClicked:)]];
    }
  }

  self.tableView.delegate = [self.action forwardingTo:self];
  [self setTableData:contents];
}

- (void)itemClicked:(NICellObject *)sender {
  NewsItemCellUserData *userData = sender.userInfo;
  RSSItemModel *item = userData.newsItem;
  FDWebViewController *webVC =
      [[FDWebViewController alloc] initWithNibName:nil bundle:nil];
  webVC.urlString = item.link;
  webVC.title = item.title;
  [self.navigationController pushViewController:webVC animated:YES];
}
@end
