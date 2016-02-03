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

- (void)loadData {
  
}
@end
