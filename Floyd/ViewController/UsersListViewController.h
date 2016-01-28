//
//  UsersListViewController.h
//  Floyd
//
//  Created by admin on 16/1/14.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "FDTableViewController.h"

@interface UsersListViewController : FDTableViewController
@property (nonatomic, strong) NSString *whatFind;
@property (nonatomic, strong) WeiboUser *userInfo;
@end
