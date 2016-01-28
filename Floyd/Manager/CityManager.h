//
//  CityManager.h
//  Floyd
//
//  Created by admin on 16/1/5.
//  Copyright © 2016年 George She. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityManager : NSObject
+ (instancetype)sharedInstance;
- (NSString *)areaIdFromPlace:(CLPlacemark *)place;
- (NSDictionary *)myCity;
- (NSDictionary *)hotCity;
- (NSDictionary *)allProvince;
- (NSArray *)allCityFromProvince:(NSString *)province;
- (NSString *)areaIdFromProvince:(NSString *)province andCity:(NSString *)city;

- (void)addMyCity:(NSString *)cityName andAreaId:(NSString *)areaId;
@end
