//
//  CommetsListViewController.m
//  Floyd
//
//  Created by admin on 16/1/18.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "CommetsListViewController.h"
#import "MJRefresh.h"
#import "WeiboCommentCell.h"

@interface CommetsListViewController ()
@property(nonatomic, strong) WeiboCommentInfoList *commentsList;
@property(nonatomic, strong) NSMutableArray *allComments;
@property(nonatomic, assign) NSInteger curPage;
@property(nonatomic, strong) WeiboInfoManager *manager;
@end

@implementation CommetsListViewController
- (void)viewDidLoad {
  [super viewDidLoad];
  self.manager = [[WeiboInfoManager alloc]
      initWithToken:[UserManager sharedInstance].weiboToken
          andUserId:[NSString
                        stringWithFormat:@"%lld", self.weiboInfo.user.userId]];
  self.allComments = [NSMutableArray new];
  self.curPage = 1;
  self.tableView.mj_header = [MJRefreshNormalHeader
      headerWithRefreshingTarget:self
                refreshingAction:@selector(loadNewComments)];
  self.tableView.mj_footer = [MJRefreshAutoNormalFooter
      footerWithRefreshingTarget:self
                refreshingAction:@selector(loadMoreComments)];
  [self.tableView.mj_header beginRefreshing];
}

- (void)udpateCommentsList {
  NSMutableArray *contents = [@[] mutableCopy];
  if (self.allComments) {
    for (WeiboCommentInfo *item in self.allComments) {
      WeiboCommentCellUserData *userData =
          [[WeiboCommentCellUserData alloc] init];
      userData.weiboComment = item;
      [contents addObject:[[NICellObject alloc]
                              initWithCellClass:[WeiboCommentCell class]
                                       userInfo:userData]];
    }
  }

  [self setTableData:contents];
}

- (void)loadNewComments {
  self.curPage = 1;
  [self.manager
      commentWithStatusId:[NSString
                              stringWithFormat:@"%lld", self.weiboInfo.weiboId]
      count:50
      page:self.curPage
      success:^(WeiboCommentInfoList *ret) {
        self.commentsList = ret;
        if (ret.comments) {
          [self.allComments removeAllObjects];
          [self.allComments addObjectsFromArray:ret.comments];
        }

        [self udpateCommentsList];
        [self.tableView.mj_header endRefreshing];
      }
      failed:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
      }];
}

- (void)loadMoreComments {
  self.curPage++;
  [self.manager
      commentWithStatusId:[NSString
                              stringWithFormat:@"%lld", self.weiboInfo.weiboId]
      count:50
      page:self.curPage
      success:^(WeiboCommentInfoList *ret) {
        if (ret.comments) {
          self.commentsList = ret;
          [self.allComments addObjectsFromArray:ret.comments];
        }
        [self udpateCommentsList];
        if (!self.commentsList || self.commentsList.comments.count == 0) {
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
