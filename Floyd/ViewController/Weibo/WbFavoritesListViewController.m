//
//  WeiboListViewController.m
//  Floyd
//
//  Created by admin on 16/1/15.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "WbFavoritesListViewController.h"
#import "WeiboInfoManager.h"
#import "WeiboItemCell.h"
#import "WeiboDetailExViewController.h"
#import "ForwardWeiboViewController.h"
#import "MJRefresh.h"

@interface WbFavoritesListViewController () <WeiboItemCellDelegate>
@property(nonatomic, strong) WeiboFavoritesList *favoritesList;
@property(nonatomic, strong) NITableViewActions *action;
@property(nonatomic, strong) NSMutableArray *allFavoritesList;
@property(nonatomic, assign) NSInteger curPage;
@property(nonatomic, strong) WeiboInfoManager *manager;
@end

@implementation WbFavoritesListViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.manager = [[WeiboInfoManager alloc]
      initWithToken:[UserManager sharedInstance].weiboToken
          andUserId:self.wbUser.userID];
  self.title = self.statusTitle;
  self.allFavoritesList = [NSMutableArray new];
  self.curPage = 1;

  [self udpateWeiboList];
  self.tableView.mj_header =
      [MJRefreshNormalHeader headerWithRefreshingTarget:self
                                       refreshingAction:@selector(loadNewData)];
  self.tableView.mj_footer = [MJRefreshAutoNormalFooter
      footerWithRefreshingTarget:self
                refreshingAction:@selector(loadMoreData)];
  [self.tableView.mj_header beginRefreshing];
}

- (void)loadNewData {
  self.curPage = 1;
  [self.manager favoritesWithUrl:self.requestUrl
      count:50
      page:self.curPage
      success:^(WeiboFavoritesList *ret) {
        self.favoritesList = ret;
        if (ret.favorites) {
          [self.allFavoritesList removeAllObjects];
          [self.allFavoritesList addObjectsFromArray:ret.favorites];
        }
        [self.tableView.mj_header endRefreshing];
        [self udpateWeiboList];
      }
      failed:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self showError:error];
      }];
}

- (void)loadMoreData {
  self.curPage++;
  [self.manager favoritesWithUrl:self.requestUrl
      count:50
      page:self.curPage
      success:^(WeiboFavoritesList *ret) {
        self.favoritesList = ret;
        if (ret.favorites) {
          [self.allFavoritesList addObjectsFromArray:ret.favorites];
        }
        [self udpateWeiboList];
        if (!self.favoritesList || self.favoritesList.favorites.count == 0) {
          [self.tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
          [self.tableView.mj_footer endRefreshing];
        }
      }
      failed:^(NSError *error) {
        [self showError:error];
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
      }];
}

- (void)udpateWeiboList {
  NSMutableArray *contents = [@[] mutableCopy];
  self.action = [[NITableViewActions alloc] initWithTarget:self];
  if (self.allFavoritesList) {
    for (FavoriteInfo *item in self.allFavoritesList) {
      WeiboItemCellUserData *userData = [[WeiboItemCellUserData alloc] init];
      userData.weiboInfo = item.status;
      userData.delegate = self;
      [contents
          addObject:[self.action attachToObject:
                                     [[NICellObject alloc]
                                         initWithCellClass:[WeiboItemCell class]
                                                  userInfo:userData]
                                    tapSelector:@selector(weiboCellClicked:)]];
    }
  }
  self.tableView.delegate = [self.action forwardingTo:self];
  [self setTableData:contents];
}

#pragma WeiboItemCellDelegate
- (void)weiboCell:(WeiboItemCell *)cell forwordAction:(WeiboInfo *)weiboInfo {
  ForwardWeiboViewController *vc =
      [[ForwardWeiboViewController alloc] initWithNibName:nil bundle:nil];
  vc.weiboInfo = cell.userData.weiboInfo;
  [self.navigationController pushViewController:vc animated:YES];
}

- (void)weiboCell:(WeiboItemCell *)cell commentAction:(WeiboInfo *)weiboInfo {
}

- (void)weiboCell:(WeiboItemCell *)cell likeItAction:(WeiboInfo *)weiboInfo {
}

- (void)weiboCellClicked:(NICellObject *)sender {
  WeiboDetailExViewController *vc =
      [[WeiboDetailExViewController alloc] initWithNibName:nil bundle:nil];
  WeiboItemCellUserData *userData = (WeiboItemCellUserData *)sender.userInfo;
  vc.weiboInfo = userData.weiboInfo;
  [self.navigationController pushViewController:vc animated:YES];
}
@end
