//
//  UsersListViewController.m
//  Floyd
//
//  Created by admin on 16/1/14.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "UsersListViewController.h"
#import "WeiboInfoManager.h"
#import "WeiboUserCell.h"
#import "WeiboUserInfoViewController.h"

@interface UsersListViewController ()
@property(nonatomic, strong) WeiboUserList *userList;
@property(nonatomic, strong) WeiboInfoManager *manager;
@end

@implementation UsersListViewController
- (void)viewDidLoad {
  [super viewDidLoad];
  self.manager = [[WeiboInfoManager alloc]
      initWithToken:[UserManager sharedInstance].weiboToken
          andUserId:self.userInfo.userID];
  self.title = self.whatFind;
  [self loadData];
}
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.rdv_tabBarController.tabBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	self.rdv_tabBarController.tabBarHidden = self.tabBarInitStatus;
}
- (void)loadData {

  if ([self.whatFind isEqualToString:@"followers"]) {
    [self.manager followersWithUserId:self.userInfo.userID
        success:^(WeiboUserList *ret) {
          self.userList = ret;
          [self updateData];
        }
        failed:^(NSError *error){

        }];
  } else if ([self.whatFind isEqualToString:@"friends"]) {
    [self.manager friendsWithUserId:self.userInfo.userID
        success:^(WeiboUserList *ret) {
          self.userList = ret;
          [self updateData];
        }
        failed:^(NSError *error){

        }];
  }
}

- (void)updateData {
  NSMutableArray *tableContents = [NSMutableArray new];
  [tableContents
      addObject:[NSString stringWithFormat:@"%@ 列表", self.whatFind]];
  if (self.userList) {
    for (WeiboUser *user in self.userList.users) {
      WeiboUserCellUserData *userData = [[WeiboUserCellUserData alloc] init];
      userData.user = user;
      [tableContents addObject:[[NICellObject alloc]
                                   initWithCellClass:[WeiboUserCell class]
                                            userInfo:userData]];
    }
  }

  [self setTableData:tableContents];
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  if ([cell isKindOfClass:[WeiboUserCell class]]) {
    WeiboUserCell *wbUserCell = (WeiboUserCell *)cell;
    WeiboUserCellUserData *userData = wbUserCell.userData;
    [self gotoUserProfile:userData.user];
  }
}

- (void)gotoUserProfile:(WeiboUser *)user {
  WeiboUserInfoViewController *vc =
      [[WeiboUserInfoViewController alloc] initWithNibName:nil bundle:nil];
  vc.userInfo = user;
  [self.navigationController pushViewController:vc animated:YES];
}
@end
