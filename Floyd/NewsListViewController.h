//
//  NewsListViewController.h
//  Floyd
//
//  Created by admin on 16/1/8.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "FDTableViewController.h"
#import "RSSSubChannel.h"

@interface NewsListViewController : FDTableViewController
@property(nonatomic, strong) RSSSubChannel *subChannel;
@end
