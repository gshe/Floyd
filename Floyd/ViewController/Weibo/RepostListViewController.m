//
//  CommetsListViewController.m
//  Floyd
//
//  Created by admin on 16/1/18.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "RepostListViewController.h"
#import "MJRefresh.h"
#import "WeiboRepostCell.h"

@interface RepostListViewController ()
@property(nonatomic, strong) WeiboRepostList *repostList;
@property(nonatomic, strong) NSMutableArray *allReposts;
@property(nonatomic, assign) NSInteger curPage;
@property(nonatomic, strong) WeiboInfoManager *manager;
@end

@implementation RepostListViewController
- (void)viewDidLoad {
  [super viewDidLoad];
	self.manager = [[WeiboInfoManager alloc]
					initWithToken:[UserManager sharedInstance].weiboToken
					andUserId:[NSString
							   stringWithFormat:@"%lld", self.weiboInfo.user.userId]];
  self.curPage = 1;
  self.allReposts = [NSMutableArray new];
  self.tableView.mj_header = [MJRefreshNormalHeader
      headerWithRefreshingTarget:self
                refreshingAction:@selector(loadNewRepost)];
  self.tableView.mj_footer = [MJRefreshAutoNormalFooter
      footerWithRefreshingTarget:self
                refreshingAction:@selector(loadMoreRepost)];
  [self.tableView.mj_header beginRefreshing];
}

- (void)udpateRepostList {
  NSMutableArray *contents = [@[] mutableCopy];
  if (self.allReposts) {
    for (WeiboInfo *item in self.allReposts) {
      WeiboRepostCellUserData *userData =
          [[WeiboRepostCellUserData alloc] init];
      userData.weiboRepost = item;
      [contents addObject:[[NICellObject alloc]
                              initWithCellClass:[WeiboRepostCell class]
                                       userInfo:userData]];
    }
  }

  [self setTableData:contents];
}

- (void)loadNewRepost {
  self.curPage = 1;
  [self.manager
      repostWithStatusId:[NSString
                             stringWithFormat:@"%lld", self.weiboInfo.weiboId]
      count:50
      page:self.curPage
      success:^(WeiboRepostList *ret) {
        self.repostList = ret;
        if (ret.reposts) {
          [self.allReposts removeAllObjects];
          [self.allReposts addObjectsFromArray:ret.reposts];
        }
        [self udpateRepostList];
        [self.tableView.mj_header endRefreshing];
      }
      failed:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
      }];
}

- (void)loadMoreRepost {
  self.curPage++;
  [self.manager
      repostWithStatusId:[NSString
                             stringWithFormat:@"%lld", self.weiboInfo.weiboId]
      count:50
      page:self.curPage
      success:^(WeiboRepostList *ret) {
        self.repostList = ret;
        if (ret.reposts) {
          self.repostList = ret;
          [self.allReposts addObjectsFromArray:ret.reposts];
        }
        [self udpateRepostList];
        if (!self.repostList || self.repostList.reposts.count == 0) {
          [self.tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
          [self.tableView.mj_footer endRefreshing];
        }
      }
      failed:^(NSError *error) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
      }];
}
@end
