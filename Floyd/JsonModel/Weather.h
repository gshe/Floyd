//
//  Weather.h
//  Floyd
//
//  Created by admin on 16/1/5.
//  Copyright © 2016年 George She. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "CityModel.h"
#import "WeatherModel.h"

@interface Weather : JSONModel
@property(nonatomic, strong) CityModel *city;
@property(nonatomic, strong) NSArray<WeatherModel> *weather;
@property(nonatomic, strong) NSString *forcastTime;
@end
