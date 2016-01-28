//
//  ProfileTableViewController.m
//  Floyd
//
//  Created by admin on 16/1/4.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "ProfileTableViewController.h"
#import "SettingsTableViewController.h"
#import "UserManager.h"
#import "NIActions.h"
#import "WeiboUserInfoViewController.h"
#import "QiniuFileUploaderViewController.h"

@interface ProfileTableViewController () <UIAlertViewDelegate>
@property(nonatomic, strong) NITableViewActions *action;
@end

@implementation ProfileTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"我的";
  self.navigationItem.rightBarButtonItem =
      [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"setting"]
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(settingButtonOnPressed)];
  [[NSNotificationCenter defaultCenter]
      addObserver:self
         selector:@selector(loginStatusChanged)
             name:kUserDidOAuthNotification
           object:nil];

  [self refreshUI];
}

- (void)refreshUI {
  self.action = [[NITableViewActions alloc] initWithTarget:self];
  NSMutableArray *tableContents = [NSMutableArray new];
  [tableContents addObject:@"用户信息"];
  if ([UserManager sharedInstance].isLoggedIn) {
    if ([UserManager sharedInstance].wbUserInfo) {
      NICellObject *userInfoObj = [self.action
          attachToObject:[NITitleCellObject
                             objectWithTitle:[UserManager sharedInstance]
                                                 .wbUserInfo.name
                                       image:[UIImage imageNamed:@"LOGO"]]
             tapSelector:@selector(userInfoTapped)];
      [tableContents addObject:userInfoObj];
    }
    NICellObject *logoutObj = [self.action
        attachToObject:[NITitleCellObject
                           objectWithTitle:@"退" @"出登录"
                                     image:[UIImage imageNamed:@"LOGO"]]
           tapSelector:@selector(logoutTapped)];
    [tableContents addObject:logoutObj];
  } else {
    NICellObject *loginObj = [self.action
        attachToObject:[NITitleCellObject
                           objectWithTitle:@"登录"
                                     image:[UIImage imageNamed:@"LOGO"]]
           tapSelector:@selector(loginTapped)];
    [tableContents addObject:loginObj];
  }

  [tableContents addObject:@"其他"];
  NICellObject *qiniu = [self.action
      attachToObject:[NITitleCellObject
                         objectWithTitle:@"七牛云存储"
                                   image:[UIImage imageNamed:@"qiniu"]]
         tapSelector:@selector(qiniuTapped)];
  [tableContents addObject:qiniu];

  self.tableView.delegate = [self.action forwardingTo:self];
  [self setTableData:tableContents];
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)loginStatusChanged {
  [self refreshUI];
}

- (void)settingButtonOnPressed {
  SettingsTableViewController *settingsVC =
      [[SettingsTableViewController alloc] initWithNibName:nil bundle:nil];
  [self.navigationController pushViewController:settingsVC animated:YES];
}

- (void)userInfoTapped {
  WeiboUserInfoViewController *vc =
      [[WeiboUserInfoViewController alloc] initWithNibName:nil bundle:nil];
  vc.userInfo = [UserManager sharedInstance].wbUserInfo;
  [self.navigationController pushViewController:vc animated:YES];
}

- (void)loginTapped {
  [[UserManager sharedInstance] login];
}

- (void)logoutTapped {
  if ([UserManager sharedInstance].isLoggedIn) {
    UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"确认登出？"
                                   message:@"你确认要退出微博登录？"
                                  delegate:self
                         cancelButtonTitle:@"取消"
                         otherButtonTitles:@"确认", nil];
    [alert show];
  }
}

- (void)qiniuTapped {
  QiniuFileUploaderViewController *vc =
      [[QiniuFileUploaderViewController alloc] initWithNibName:nil bundle:nil];
  [self.navigationController pushViewController:vc animated:YES];
}

#pragma UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView
    clickedButtonAtIndex:(NSInteger)buttonIndex {
  if (buttonIndex == 1) {
         [[UserManager sharedInstance] logout];
	}
}
@end
