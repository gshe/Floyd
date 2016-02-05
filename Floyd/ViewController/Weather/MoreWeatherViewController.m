//
//  MoreWeatherViewController.m
//  Floyd
//
//  Created by admin on 16/1/7.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "MoreWeatherViewController.h"
#import "WeatherInfoCell.h"

@interface MoreWeatherViewController ()

@end

@implementation MoreWeatherViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"未来天气预报";
  self.rdv_tabBarController.tabBarHidden = YES;
  NSMutableArray *contents = [@[] mutableCopy];
  if (self.curWeather) {
    NSInteger index = 1;
    for (WeatherModel *model in self.curWeather.weather) {
      [contents addObject:[NSString stringWithFormat:@"第%zd天", index]];
      WeatherInfoCellUserData *userDataDay =
          [[WeatherInfoCellUserData alloc] init];
      userDataDay.isDayWeather = YES;
      userDataDay.weather = model;

      [contents addObject:[[NICellObject alloc]
                              initWithCellClass:[WeatherInfoCell class]
                                       userInfo:userDataDay]];
      WeatherInfoCellUserData *userDataNight =
          [[WeatherInfoCellUserData alloc] init];
      userDataNight.isDayWeather = NO;
      userDataNight.weather = model;

      [contents addObject:[[NICellObject alloc]
                              initWithCellClass:[WeatherInfoCell class]
                                       userInfo:userDataNight]];
      index++;
    }
  }

  [self setTableData:contents];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  self.rdv_tabBarController.tabBarHidden = self.tabBarInitStatus;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
