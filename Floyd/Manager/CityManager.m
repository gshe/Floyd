//
//  CityManager.m
//  Floyd
//
//  Created by admin on 16/1/5.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "CityManager.h"
@interface CityManager ()

@property(nonatomic) NSDictionary *cityList;

@end

@implementation CityManager

+ (instancetype)sharedInstance {
  static CityManager *manager;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    manager = [[CityManager alloc] init];
  });
  return manager;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    self.cityList = [self readCityListFromFile];
  }
  return self;
}

- (NSDictionary *)readCityListFromFile {
  NSString *plistPath =
      [[NSBundle mainBundle] pathForResource:@"cityList" ofType:@"plist"];
  return [[NSDictionary alloc] initWithContentsOfFile:plistPath];
}

- (NSString *)areaIdFromPlace:(CLPlacemark *)place {
  NSString *administrativeArea = place.administrativeArea;
  NSString *locality = place.locality;

  return [self areaIdFromProvince:administrativeArea andCity:locality];
}

- (NSDictionary *)myCity {
  NSDictionary *dicOld =
      [[NSUserDefaults standardUserDefaults] objectForKey:@"myCity"];

  NSMutableDictionary *dic = [NSMutableDictionary new];
  [dic setObject:@"" forKey:@"当前定位"];
  [dic addEntriesFromDictionary:dicOld];
  return dic;
}

- (NSDictionary *)hotCity {
  NSDictionary *dic = self.cityList[@"Hot"];
  return dic;
}

- (NSDictionary *)allProvince {
  NSDictionary *dic = self.cityList[@"中国基础"];
  return dic;
}

- (NSArray *)allCityFromProvince:(NSString *)province {
  NSDictionary *dicProvince = self.cityList[@"中国基础"];
  return [dicProvince[province] allKeys];
}

- (NSString *)areaIdFromProvince:(NSString *)province andCity:(NSString *)city {
  NSDictionary *dicProvince = self.cityList[@"中国基础"];
  NSDictionary *dicCity = dicProvince[province];
  return dicCity[city];
}

- (void)addMyCity:(NSString *)cityName andAreaId:(NSString *)areaId {

  NSDictionary *dicOld =
      [[NSUserDefaults standardUserDefaults] objectForKey:@"myCity"];
  NSMutableDictionary *dicNew =
      [NSMutableDictionary dictionaryWithDictionary:dicOld];
  [dicNew setObject:areaId forKey:cityName];
  [[NSUserDefaults standardUserDefaults] setObject:dicNew forKey:@"myCity"];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)RemoveMyCity:(NSString *)cityName {

  NSDictionary *dicOld =
      [[NSUserDefaults standardUserDefaults] objectForKey:@"myCity"];
  NSMutableDictionary *dicNew =
      [NSMutableDictionary dictionaryWithDictionary:dicOld];
  [dicNew removeObjectForKey:cityName];
  [[NSUserDefaults standardUserDefaults] setObject:dicNew forKey:@"myCity"];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
