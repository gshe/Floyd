//
//  WeatherModel.h
//  Floyd
//
//  Created by admin on 16/1/5.
//  Copyright © 2016年 George She. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol WeatherModel
@end

@interface WeatherModel : JSONModel
@property(nonatomic, assign) NSInteger dayWeatherCode;
@property(nonatomic, assign) NSInteger nightWeatherCode;
@property(nonatomic, assign) NSInteger dayTemperature;
@property(nonatomic, assign) NSInteger nightTemperature;
@property(nonatomic, assign) NSInteger dayWindDirectionCode;
@property(nonatomic, assign) NSInteger nightWindDirectionCode;
@property(nonatomic, assign) NSInteger dayWindForceCode;
@property(nonatomic, assign) NSInteger nightWindForceCode;
@property(nonatomic, strong) NSString *sunsetTime;

@property(nonatomic, strong, readonly) NSString *dayWeather;
@property(nonatomic, strong, readonly) NSString *nightWeather;
@property(nonatomic, strong, readonly) NSString *dayWindDirection;
@property(nonatomic, strong, readonly) NSString *nightWindDirection;
@property(nonatomic, strong, readonly) NSString *dayWindForce;
@property(nonatomic, strong, readonly) NSString *nightWindForce;
@property(nonatomic, strong, readonly) NSString *dayWeatherIcon;
@property(nonatomic, strong, readonly) NSString *nightWeatherIcon;
@end
