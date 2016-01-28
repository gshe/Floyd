//
//  MyWeiboViewController.m
//  Floyd
//
//  Created by admin on 16/1/15.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "MyWeiboViewController.h"
#import "WeiboListViewController.h"
#import "WbFavoritesListViewController.h"

@interface MyWeiboViewController () <ViewPagerDelegate, ViewPagerDataSource>
@property(nonatomic, strong) NSArray *categories;
@property(nonatomic, strong) NSArray *categoriesUrls;
@end

@implementation MyWeiboViewController
- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"我的微博";
  self.categories =
      [NSArray arrayWithObjects:@"热门微博", @"我的关注",
                                @"我发布的", @"我的收藏", nil];
  self.categoriesUrls = [NSArray
      arrayWithObjects:@"statuses/public_timeline.json",
                       @"statuses/home_timeline.json",
                       @"statuses/user_timeline.json", @"favorites.json", nil];
  self.dataSource = self;
  self.delegate = self;
  [self selectTabAtIndex:0];
}

#pragma ViewPagerDataSource
- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager {
  if (self.categories) {
    return self.categories.count;
  }

  return 0;
}

- (UIView *)viewPager:(ViewPagerController *)viewPager
    viewForTabAtIndex:(NSUInteger)index {
  UILabel *label = [UILabel new];
  label.text = self.categories[index];
  [label sizeToFit];

  return label;
}

- (CGFloat)viewPager:(ViewPagerController *)viewPager
      valueForOption:(ViewPagerOption)option
         withDefault:(CGFloat)value {
  switch (option) {
  case ViewPagerOptionTabWidth:
    value = 86;
    break;

  default:
    break;
  }
  return value;
}

- (UIViewController *)viewPager:(ViewPagerController *)viewPager
    contentViewControllerForTabAtIndex:(NSUInteger)index {
  UIViewController *vc = nil;
  if (index == 3) {
    WbFavoritesListViewController *statusVC =
        [[WbFavoritesListViewController alloc] initWithNibName:nil bundle:nil];
    statusVC.statusTitle = self.categories[index];
    statusVC.requestUrl = self.categoriesUrls[index];
    vc = statusVC;
  } else {
    WeiboListViewController *statusVC =
        [[WeiboListViewController alloc] initWithNibName:nil bundle:nil];
    statusVC.statusTitle = self.categories[index];
    statusVC.requestUrl = self.categoriesUrls[index];
    vc = statusVC;
  }
  return vc;
}

- (UIColor *)viewPager:(ViewPagerController *)viewPager
     colorForComponent:(ViewPagerComponent)component
           withDefault:(UIColor *)color {
  switch (component) {
  case ViewPagerIndicator:
    color = [UIColor redColor];
    break;

  default:
    break;
  }
  return color;
}

@end
