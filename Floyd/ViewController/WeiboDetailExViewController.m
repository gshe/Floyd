//
//  WeiboDetailExViewController.m
//  Floyd
//
//  Created by George She on 16/1/20.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "WeiboDetailExViewController.h"
#import "MJRefresh.h"
#import "WeiboActionCell.h"
#import "WeiboCommentCell.h"
#import "WeiboRepostCell.h"
#import "WeiboItemCell.h"

@interface WeiboDetailExViewController () <WeiboActionCellDelegate>
@property(nonatomic, strong) WeiboCommentInfoList *commentsList;
@property(nonatomic, strong) WeiboRepostList *repostList;
@property(nonatomic, strong) NSMutableArray *allComments;
@property(nonatomic, assign) NSInteger curCommentsPage;
@property(nonatomic, strong) NSMutableArray *allReposts;
@property(nonatomic, assign) NSInteger curRepostsPage;
@property(nonatomic, assign) FDActionMode actionMode;
@property(nonatomic, strong) WeiboInfoManager *manager;
@end

@implementation WeiboDetailExViewController
- (void)viewDidLoad {
  [super viewDidLoad];
  self.manager = [[WeiboInfoManager alloc]
      initWithToken:[UserManager sharedInstance].weiboToken
          andUserId:[NSString
                        stringWithFormat:@"%lld", self.weiboInfo.user.userId]];
  self.actionMode = FDActionMode_Comment;
  self.allComments = [NSMutableArray new];
  self.curCommentsPage = 1;
  self.allReposts = [NSMutableArray new];
  self.curRepostsPage = 1;

  self.tableView.mj_header =
      [MJRefreshNormalHeader headerWithRefreshingTarget:self
                                       refreshingAction:@selector(loadNewData)];
  self.tableView.mj_footer = [MJRefreshAutoNormalFooter
      footerWithRefreshingTarget:self
                refreshingAction:@selector(loadMoreData)];
  [self.tableView.mj_header beginRefreshing];
}

- (void)loadNewData {
  switch (self.actionMode) {
  case FDActionMode_Comment:
    [self loadNewComments];
    break;
  case FDActionMode_Repost:
    [self loadNewRepost];
    break;
  case FDActionMode_LikeIt:
    [self loadNewLikeIt];
    break;
  default:
    break;
  }
}

- (void)loadMoreData {
  switch (self.actionMode) {
  case FDActionMode_Comment:
    [self loadMoreComments];
    break;
  case FDActionMode_Repost:
    [self loadMoreRepost];
    break;
  case FDActionMode_LikeIt:
    [self loadMoreLikeIt];
    break;
  default:
    break;
  }
}

- (void)loadNewLikeIt {
  [self udpateLikeItList];
  [self.tableView.mj_header endRefreshing];
}

- (void)loadMoreLikeIt {
  [self udpateLikeItList];
  [self.tableView.mj_footer endRefreshingWithNoMoreData];
}

- (void)udpateLikeItList {
  NSMutableArray *contents = [@[] mutableCopy];
  [contents addObject:[self createWeiboCell]];
  [contents addObject:[self createActionCell]];

  [self setTableData:contents];
}

- (void)udpateCommentsList {
  NSMutableArray *contents = [@[] mutableCopy];
  [contents addObject:[self createWeiboCell]];
  [contents addObject:[self createActionCell]];
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
  self.curCommentsPage = 1;
  [self.manager
      commentWithStatusId:[NSString
                              stringWithFormat:@"%lld", self.weiboInfo.weiboId]
      count:50
      page:self.curCommentsPage
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

- (void)udpateRepostList {
  NSMutableArray *contents = [@[] mutableCopy];
  [contents addObject:[self createWeiboCell]];
  [contents addObject:[self createActionCell]];
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

- (void)loadMoreComments {
  self.curCommentsPage++;
  [self.manager
      commentWithStatusId:[NSString
                              stringWithFormat:@"%lld", self.weiboInfo.weiboId]
      count:50
      page:self.curCommentsPage
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

- (void)loadNewRepost {
  self.curRepostsPage = 1;
  [self.manager
      repostWithStatusId:[NSString
                             stringWithFormat:@"%lld", self.weiboInfo.weiboId]
      count:50
      page:self.curRepostsPage
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
  self.curRepostsPage++;
  [self.manager
      repostWithStatusId:[NSString
                             stringWithFormat:@"%lld", self.weiboInfo.weiboId]
      count:50
      page:self.curRepostsPage
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

- (NICellObject *)createWeiboCell {
  WeiboItemCellUserData *userData = [[WeiboItemCellUserData alloc] init];
  userData.weiboInfo = self.weiboInfo;
  userData.hiddenAction = YES;

  return [[NICellObject alloc] initWithCellClass:[WeiboItemCell class]
                                        userInfo:userData];
}

- (NICellObject *)createActionCell {
  WeiboActionCellUserData *userData = [[WeiboActionCellUserData alloc] init];
  userData.weiboInfo = self.weiboInfo;
  userData.curAction = self.actionMode;
  userData.delegate = self;
  return [[NICellObject alloc] initWithCellClass:[WeiboActionCell class]
                                        userInfo:userData];
}

#pragma WeiboActionCellDelegate

- (void)actionModeChanged:(FDActionMode)actMode {
  self.actionMode = actMode;
  [self.tableView.mj_header beginRefreshing];
}
@end
