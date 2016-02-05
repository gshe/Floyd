//
//  WeiboListViewController.m
//  Floyd
//
//  Created by admin on 16/1/14.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "WeiboUserListViewController.h"

@implementation WeiboUserListViewController
- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = [NSString stringWithFormat:@"%@ 的微博信息", self.userInfo.name];
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
  
}
@end
