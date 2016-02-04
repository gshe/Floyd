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
#import "UserDetailViewController.h"
#import "MyAlbumsViewController.h"
#import "MMDrawerController.h"
#import "V2ExNodeListViewController.h"
#import "V2ExTopicListViewController.h"
#import "MyV2ExProfileViewController.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "FDWebViewController.h"

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
    NSString *userTitle = nil;
    if ([UserManager sharedInstance].userName) {
      userTitle = [UserManager sharedInstance].userName;
    } else {
      userTitle = @"用户名未设置";
    }
    NICellObject *userInfoObj = [self.action
        attachToObject:[NITitleCellObject
                           objectWithTitle:userTitle
                                     image:[UIImage imageNamed:@"me"]]
           tapSelector:@selector(userInfoTapped)];
    [tableContents addObject:userInfoObj];

    if ([UserManager sharedInstance].wbUserInfo) {
      NICellObject *userInfoObj = [self.action
          attachToObject:
              [NITitleCellObject
                  objectWithTitle:
                      [NSString stringWithFormat:@"关联微博：%@",
                                                 [UserManager sharedInstance]
                                                     .wbUserInfo.name]
                            image:[UIImage imageNamed:@"LOGO"]]
             tapSelector:@selector(weiboUserInfoTapped)];
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

  if ([UserManager sharedInstance].isLoggedIn) {
    NICellObject *myAlbum = [self.action
        attachToObject:[NITitleCellObject
                           objectWithTitle:@"我的相册"
                                     image:[UIImage imageNamed:@"me"]]
           tapSelector:@selector(myAlbumTapped)];
    [tableContents addObject:myAlbum];
  }

  NICellObject *v2Ex = [self.action
      attachToObject:[NITitleCellObject
                         objectWithTitle:@"V2Ex"
                                   image:[UIImage imageNamed:@"me"]]
         tapSelector:@selector(v2ExTapped)];
  [tableContents addObject:v2Ex];
  NICellObject *blog = [self.action
      attachToObject:[NITitleCellObject
                         objectWithTitle:@"个人博客"
                                   image:[UIImage imageNamed:@"me"]]
         tapSelector:@selector(blogTapped)];
  [tableContents addObject:blog];

  NICellObject *cnblog = [self.action
      attachToObject:[NITitleCellObject
                         objectWithTitle:@"博客园"
                                   image:[UIImage imageNamed:@"me"]]
         tapSelector:@selector(cnblogTapped)];
  [tableContents addObject:cnblog];

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
  UserDetailViewController *vc =
      [[UserDetailViewController alloc] initWithNibName:nil bundle:nil];
  [self.navigationController pushViewController:vc animated:YES];
}

- (void)weiboUserInfoTapped {
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

- (void)myAlbumTapped {
  MyAlbumsViewController *vc =
      [[MyAlbumsViewController alloc] initWithNibName:nil bundle:nil];
  [self.navigationController pushViewController:vc animated:YES];
}

- (void)v2ExTapped {
  V2ExNodeListViewController *rightVC =
      [[V2ExNodeListViewController alloc] initWithNibName:nil bundle:nil];
  V2ExTopicListViewController *mainVC =
      [[V2ExTopicListViewController alloc] initWithNibName:nil bundle:nil];
  MyV2ExProfileViewController *leftVC =
      [[MyV2ExProfileViewController alloc] initWithNibName:nil bundle:nil];
  UINavigationController *mainNavi =
      [[UINavigationController alloc] initWithRootViewController:mainVC];
  UINavigationController *rightNavi =
      [[UINavigationController alloc] initWithRootViewController:rightVC];
  rightVC.delegate = mainVC;
  leftVC.delegate = mainVC;
  MMDrawerController *v2ExController =
      [[MMDrawerController alloc] initWithCenterViewController:mainNavi
                                      leftDrawerViewController:leftVC
                                     rightDrawerViewController:rightNavi];
  [v2ExController setShowsShadow:NO];
  [v2ExController setRestorationIdentifier:@"MMDrawer3"];
  [v2ExController setMaximumLeftDrawerWidth:150];
  [v2ExController setMaximumRightDrawerWidth:150];
  [v2ExController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
  [v2ExController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
  [v2ExController
      setDrawerVisualStateBlock:^(MMDrawerController *drawerController,
                                  MMDrawerSide drawerSide,
                                  CGFloat percentVisible) {
        MMDrawerControllerDrawerVisualStateBlock block;
        block = [[MMExampleDrawerVisualStateManager sharedManager]
            drawerVisualStateBlockForDrawerSide:drawerSide];
        if (block) {
          block(drawerController, drawerSide, percentVisible);
        }
      }];

  [self.navigationController presentViewController:v2ExController
                                          animated:YES
                                        completion:nil];
}

- (void)blogTapped {
  FDWebViewController *blogVC =
      [[FDWebViewController alloc] initWithNibName:nil bundle:nil];
  blogVC.urlString = @"http://www.gshe.xyz";
  [self.navigationController pushViewController:blogVC animated:YES];
}

- (void)cnblogTapped {
  FDWebViewController *blogVC =
      [[FDWebViewController alloc] initWithNibName:nil bundle:nil];
  blogVC.urlString = @"http://www.cnblogs.com/gshe/";
  [self.navigationController pushViewController:blogVC animated:YES];
}

#pragma UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView
    clickedButtonAtIndex:(NSInteger)buttonIndex {
  if (buttonIndex == 1) {
         [[UserManager sharedInstance] logout];
	}
}
@end
