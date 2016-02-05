//
//  WeiboUserInfoViewController.m
//  Floyd
//
//  Created by admin on 16/1/12.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "WeiboUserInfoViewController.h"
#import "UIImageView+WebCache.h"
#import "NIActions.h"
#import "NITableViewActions.h"
#import "UsersListViewController.h"
#import "WeiboUserListViewController.h"
#import "WeiboListViewController.h"

@interface WeiboUserInfoViewController ()
@property(nonatomic, strong) NITableViewActions *action;
@end

@implementation WeiboUserInfoViewController
- (void)viewDidLoad {
  [super viewDidLoad];
  [self loadUI];
}
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.rdv_tabBarController.tabBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	self.rdv_tabBarController.tabBarHidden = self.tabBarInitStatus;
}
- (void)loadUI {
  if (!self.userInfo) {
    return;
  }
  [self createHeaderView];
  self.action = [[NITableViewActions alloc] initWithTarget:self];
  NSMutableArray *tableContents = [NSMutableArray new];
  [tableContents addObject:@"用户信息"];

  NSString *title = [NSString stringWithFormat:@"%@-%@", @"followersCount",
                                               self.userInfo.followersCount];
  [tableContents
      addObject:[self.action
                    attachToObject:[NITitleCellObject objectWithTitle:title]
                       tapSelector:@selector(followersCountTapped)]];
  title = [NSString
      stringWithFormat:@"%@-%@", @"friendsCount", self.userInfo.friendsCount];
  [tableContents
      addObject:[self.action
                    attachToObject:[NITitleCellObject objectWithTitle:title]
                       tapSelector:@selector(friendsCountTapped)]];

  [tableContents addObject:@"微博信息"];
  title = [NSString
      stringWithFormat:@"%@-%@", @"statusesCount", self.userInfo.statusesCount];
  [tableContents
      addObject:[self.action
                    attachToObject:[NITitleCellObject objectWithTitle:title]
                       tapSelector:@selector(statusesCountTapped)]];
  title = [NSString stringWithFormat:@"%@-%@", @"favouritesCount",
                                     self.userInfo.favouritesCount];
  [tableContents
      addObject:[self.action
                    attachToObject:[NITitleCellObject objectWithTitle:title]
                       tapSelector:@selector(favouritesCountTapped)]];
  self.tableView.delegate = [self.action forwardingTo:self];
  [self setTableData:tableContents];
}

- (void)createHeaderView {
  UIView *headerView = [[UIView alloc]
      initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 150)];
  headerView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
  UIImageView *avatarImage = [[UIImageView alloc] init];
  avatarImage.contentMode = UIViewContentModeScaleAspectFill;
  avatarImage.clipsToBounds = YES;
  avatarImage.layer.cornerRadius = 44 / 2;
  avatarImage.layer.masksToBounds = YES;
  avatarImage.layer.borderColor = [UIColor whiteColor].CGColor;
  avatarImage.layer.borderWidth = 2.0;
  avatarImage.layer.allowsEdgeAntialiasing = YES;
  [avatarImage
      sd_setImageWithURL:[NSURL URLWithString:self.userInfo.profileImageUrl]
        placeholderImage:[UIImage imageNamed:@"avatar_user_man"]];
  [headerView addSubview:avatarImage];

  UILabel *userID = [UILabel new];
  userID.text = [NSString stringWithFormat:@"ID:%@", self.userInfo.userID];
  UILabel *userNickName = [UILabel new];
  userNickName.text =
      [NSString stringWithFormat:@"Name:%@", self.userInfo.name];
  [headerView addSubview:userID];
  [headerView addSubview:userNickName];
  [avatarImage mas_makeConstraints:^(MASConstraintMaker *make) {
    make.width.height.mas_equalTo(44);
    make.centerX.equalTo(headerView);
    make.top.equalTo(headerView).offset(15);
  }];

  [userID mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.equalTo(headerView);
    make.top.equalTo(avatarImage.mas_bottom).offset(5);
  }];

  [userNickName mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.equalTo(headerView);
    make.top.equalTo(userID.mas_bottom).offset(5);
  }];
  self.tableView.tableHeaderView = headerView;
}

- (void)followersCountTapped {
  [self gotoUsersListVC:@"followers"];
}

- (void)friendsCountTapped {
  [self gotoUsersListVC:@"friends"];
}

- (void)favouritesCountTapped {
  [self gotoWeiboListVC:@"favourites"];
}

- (void)statusesCountTapped {
  [self gotoWeiboListVC:@"statuses"];
}

- (void)gotoUsersListVC:(NSString *)name {
  UsersListViewController *vc =
      [[UsersListViewController alloc] initWithNibName:nil bundle:nil];
  vc.whatFind = name;
  vc.userInfo = self.userInfo;
  [self.navigationController pushViewController:vc animated:YES];
}

- (void)gotoWeiboListVC:(NSString *)name {
  WeiboListViewController *vc =
      [[WeiboListViewController alloc] initWithNibName:nil bundle:nil];
  vc.statusTitle = [NSString stringWithFormat:@"%@ 的微博", self.userInfo.name];
  vc.requestUrl = @"statuses/user_timeline.json";
  vc.wbUser = self.userInfo;
  [self.navigationController pushViewController:vc animated:YES];
}
@end
