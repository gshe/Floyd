//
//  CitySelectTableViewController.m
//  Floyd
//
//  Created by admin on 16/1/5.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "CitySelectTableViewController.h"
#import "CityManager.h"
#import "CitySelectCell.h"
#import "AreaPickView.h"

@interface CitySelectTableViewController () <AreaPickViewDelegate>
@end

@implementation CitySelectTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"城市列表";
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  NSMutableArray *tableContents = [NSMutableArray new];
  [tableContents addObject:@"我的"];
  NSDictionary *myCity = [[CityManager sharedInstance] myCity];
  [myCity enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull obj,
                                              BOOL *_Nonnull stop) {
    CitySelectCellUserData *userData = [[CitySelectCellUserData alloc] init];
    userData.cityName = key;
    userData.areaId = obj;
    NICellObject *cellObj =
        [[NICellObject alloc] initWithCellClass:[CitySelectCell class]
                                       userInfo:userData];
    [tableContents addObject:cellObj];
  }];

  [tableContents addObject:@"热门"];
  NSDictionary *hotCity = [[CityManager sharedInstance] hotCity];
  [hotCity enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull obj,
                                               BOOL *_Nonnull stop) {
    CitySelectCellUserData *userData = [[CitySelectCellUserData alloc] init];
    userData.cityName = key;
    userData.areaId = obj;
    NICellObject *cellObj =
        [[NICellObject alloc] initWithCellClass:[CitySelectCell class]
                                       userInfo:userData];
    [tableContents addObject:cellObj];
  }];

  [tableContents addObject:@"选择"];
  NSDictionary *provinces = [[CityManager sharedInstance] allProvince];
  [provinces enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key,
                                                 id _Nonnull obj,
                                                 BOOL *_Nonnull stop) {
    CitySelectCellUserData *userData = [[CitySelectCellUserData alloc] init];
    userData.cityName = key;
    userData.areaId = nil;
    userData.subCity = obj;
    NICellObject *cellObj =
        [[NICellObject alloc] initWithCellClass:[CitySelectCell class]
                                       userInfo:userData];
    [tableContents addObject:cellObj];
  }];
  [self setTableData:tableContents];
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];

  UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  CitySelectCellUserData *cityCellUserData;
  if ([cell isKindOfClass:[CitySelectCell class]]) {
    CitySelectCell *cityCell = (CitySelectCell *)cell;
    cityCellUserData = (CitySelectCellUserData *)cityCell.userData;
    if (cityCellUserData.subCity) {
      NSDictionary *provinces = [[CityManager sharedInstance] allProvince];
      AreaPickView *picker = [[AreaPickView alloc] initWithFrame:CGRectZero];
      picker.delegate = self;
      picker.citesInProvinceDic = provinces[cityCellUserData.cityName];
      [picker show];
    } else {
      if ([self.delegate
              respondsToSelector:@selector(citySelectedWithCityName:
                                                          andAreaId:)]) {
        [self.delegate citySelectedWithCityName:cityCellUserData.cityName
                                      andAreaId:cityCellUserData.areaId];
        [[CityManager sharedInstance] addMyCity:cityCellUserData.cityName
                                      andAreaId:cityCellUserData.areaId];
      }
    }
  }
}

#pragma AreaPickViewDelegate
- (void)didSelectAreaWithCityName:(NSString *)cityName
                        andAreaId:(NSString *)areaId {
  if ([self.delegate
          respondsToSelector:@selector(citySelectedWithCityName:andAreaId:)]) {
    [self.delegate citySelectedWithCityName:cityName andAreaId:areaId];
    [[CityManager sharedInstance] addMyCity:cityName andAreaId:areaId];
  }
}
@end
