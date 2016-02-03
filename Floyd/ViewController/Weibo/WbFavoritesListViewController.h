//
//  WeiboListViewController.h
//  Floyd
//
//  Created by admin on 16/1/15.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "FDTableViewController.h"

@interface WbFavoritesListViewController : FDTableViewController
@property (nonatomic, strong) NSString *statusTitle;
@property (nonatomic, strong) NSString *requestUrl;
@property (nonatomic, strong) WeiboUser *wbUser;
@end
