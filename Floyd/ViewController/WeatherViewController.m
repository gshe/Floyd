//
//  WeatherViewController.m
//  Floyd
//
//  Created by admin on 16/1/4.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "WeatherViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "CitySelectTableViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "WeatherLocationManager.h"
#import "CityManager.h"
#import "SmartWeatherAPI.h"
#import "Weather.h"
#import "Index.h"
#import "WeatherInfoCell.h"
#import "IndexInfoCell.h"
#import "MoreWeatherViewController.h"
#import "MJRefresh.h"

@interface WeatherViewController () <WeatherLocationDelegate>
@property(nonatomic, strong) SmartWeatherAPI *weatherApi;
@property(nonatomic, strong) Weather *curWeather;
@property(nonatomic, strong) Index *curIndex;
@property(nonatomic, strong) NSString *areaId;
@end

@implementation WeatherViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"天气";
  self.tableView.mj_header = [MJRefreshNormalHeader
      headerWithRefreshingTarget:self
                refreshingAction:@selector(fetchWeatherInfo)];
  [self.tableView.mj_header beginRefreshing];

  self.view.backgroundColor = [UIColor whiteColor];
  MMDrawerBarButtonItem *leftDrawerButton = [[MMDrawerBarButtonItem alloc]
      initWithTarget:self
              action:@selector(leftDrawerButtonPress:)];
  [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];

  self.navigationItem.rightBarButtonItem =
      [[UIBarButtonItem alloc] initWithTitle:@"更多信息"
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(rightButtonPress:)];
  [WeatherLocationManager sharedInstace].delegate = self;
  self.weatherApi = [[SmartWeatherAPI alloc] init];
  [[WeatherLocationManager sharedInstace] startLocate];
  [self updateWeather];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)updateWeather {
  NSMutableArray *contents = [@[] mutableCopy];
  if (self.curWeather) {
    self.title = [NSString stringWithFormat:@"%@-%@",
                                            self.curWeather.city.provinceNameCN,
                                            self.curWeather.city.nameCN];

    [contents
        addObject:[NSString stringWithFormat:@"天气 (发布时间 %@)",
                                             self.curWeather.forcastTime]];
    if (self.curWeather) {
      WeatherInfoCellUserData *userDataDay =
          [[WeatherInfoCellUserData alloc] init];
      userDataDay.isDayWeather = YES;
      userDataDay.weather = self.curWeather.weather[0];

      [contents addObject:[[NICellObject alloc]
                              initWithCellClass:[WeatherInfoCell class]
                                       userInfo:userDataDay]];
      WeatherInfoCellUserData *userDataNight =
          [[WeatherInfoCellUserData alloc] init];
      userDataNight.isDayWeather = NO;
      userDataNight.weather = self.curWeather.weather[0];

      [contents addObject:[[NICellObject alloc]
                              initWithCellClass:[WeatherInfoCell class]
                                       userInfo:userDataNight]];
    }

    if (self.curIndex) {
      [contents addObject:@"指数"];
      for (IndexModel *model in self.curIndex.index) {
        IndexInfoCellUserData *userData = [[IndexInfoCellUserData alloc] init];
        userData.index = model;
        [contents addObject:[[NICellObject alloc]
                                initWithCellClass:[IndexInfoCell class]
                                         userInfo:userData]];
      }
    }
  }
  [self setTableData:contents];
}

- (void)leftDrawerButtonPress:(id)sender {
  [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft
                                    animated:YES
                                  completion:nil];
}

- (void)rightButtonPress:(id)sender {
  MoreWeatherViewController *vc =
      [[MoreWeatherViewController alloc] initWithNibName:nil bundle:nil];
  vc.curWeather = self.curWeather;
  [self.navigationController pushViewController:vc animated:YES];
}

#pragma WeatherLocationDelegate
- (void)didStartSearchLocation {
}

- (void)didFindLocation:(CLPlacemark *)place {
  self.areaId = [[CityManager sharedInstance] areaIdFromPlace:place];

  [self fetchWeatherInfo];
}

- (void)locationWithError:(NSError *)error {
  [self.tableView.mj_header endRefreshing];
}

- (void)fetchWeatherInfo {
  if (!self.areaId) {
    [self.tableView.mj_header endRefreshing];
    return;
  }

  [self.weatherApi queryWeather:self.areaId
      success:^(Weather *ret) {
        self.curWeather = ret;
        [self updateWeather];

        [self.weatherApi QueryIndex:self.areaId
            success:^(Index *ret) {
              self.curIndex = ret;
              [self updateWeather];
            }
            failed:^(NSError *error){

            }];
        [self.tableView.mj_header endRefreshing];

      }
      failed:^(NSError *error){

      }];
}

#pragma CitySelectedDelegate
- (void)citySelectedWithCityName:(NSString *)cityName
                       andAreaId:(NSString *)areaId {
  [self.tableView.mj_header beginRefreshing];
  self.areaId = areaId;
  if (areaId && [areaId compare:@""] != NSOrderedSame) {
    self.title = cityName;
    [self fetchWeatherInfo];
  } else {
    [[WeatherLocationManager sharedInstace] startLocate];
  }

  [self.mm_drawerController closeDrawerAnimated:YES
                                     completion:^(BOOL finished){

                                     }];
}
@end
