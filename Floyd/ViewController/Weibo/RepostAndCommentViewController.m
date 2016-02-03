//
//  RepostAndCommentViewController.m
//  Floyd
//
//  Created by admin on 16/1/18.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "RepostAndCommentViewController.h"
#import "CommetsListViewController.h"
#import "RepostListViewController.h"

@interface RepostAndCommentViewController () <ViewPagerDataSource,
                                              ViewPagerDelegate>
@property(nonatomic, strong) NSArray *tabNameArr;
@end

@implementation RepostAndCommentViewController
- (void)viewDidLoad {
  [super viewDidLoad];
  self.tabNameArr =
      [NSArray arrayWithObjects:
                   [NSString stringWithFormat:@"转发 %zd",
                                              self.weiboInfo.reposts_count],
                   [NSString stringWithFormat:@"评论 %zd",
                                              self.weiboInfo.comments_count],
                   [NSString stringWithFormat:@"赞 %zd",
                                              self.weiboInfo.attitudes_count],
                   nil];
  self.dataSource = self;
  self.delegate = self;
  [self selectTabAtIndex:1];
  [self reloadData];
}

#pragma ViewPagerDataSource
- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager {
  return 3;
}

- (UIViewController *)viewPager:(ViewPagerController *)viewPager
    contentViewControllerForTabAtIndex:(NSUInteger)index {
  UIViewController *vc = nil;
  switch (index) {
  case 0: {
    RepostListViewController *repostVC =
        [[RepostListViewController alloc] initWithNibName:nil bundle:nil];
    repostVC.weiboInfo = self.weiboInfo;
    vc = repostVC;
  } break;
  case 1: {
    CommetsListViewController *commentsVC =
        [[CommetsListViewController alloc] initWithNibName:nil bundle:nil];
    commentsVC.weiboInfo = self.weiboInfo;
    vc = commentsVC;
  } break;
  case 2:
	  {
		 vc = [[UIViewController alloc] init];
	  }
    break;
  default:
    break;
  }
  return vc;
}

- (UIView *)viewPager:(ViewPagerController *)viewPager
    viewForTabAtIndex:(NSUInteger)index {
  UILabel *label = [UILabel new];
  label.text = self.tabNameArr[index];
  [label sizeToFit];
  return label;
}
@end
