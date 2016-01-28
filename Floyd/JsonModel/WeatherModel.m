//
//  WeatherModel.m
//  Floyd
//
//  Created by admin on 16/1/5.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "WeatherModel.h"
// fa //白天天气现象编号 // 01 // fb //晚上天气现象编号 // 01 // fc //
// //白天天气温度(摄氏度) // 11 // fd //晚上天气温度(摄氏度) // 0 // fe
// //白天风向编号 // 4 // // ff //晚上风向编号 // 4 // fg // //白天风力编号 //
// // 1 // fh //晚上风力编号 // 0 // fi //日出日落时间(中间用|分割) // //
// 06:44|18:21

@implementation WeatherModel
+ (JSONKeyMapper *)keyMapper {
  return [[JSONKeyMapper alloc] initWithDictionary:@{
    @"fa" : @"dayWeatherCode",
    @"fb" : @"nightWeatherCode",
    @"fc" : @"dayTemperature",
    @"fd" : @"nightTemperature",
    @"fe" : @"dayWindDirectionCode",
    @"ff" : @"nightWindDirectionCode",
    @"fg" : @"dayWindForceCode",
    @"fh" : @"nightWindForceCode",
    @"fi" : @"sunsetTime",
  }];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
  return YES;
}

- (NSString *)dayWeather {
  return [[self class] getWeatherDescription:self.dayWeatherCode];
}

- (NSString *)dayWeatherIcon {
  return [NSString stringWithFormat:@"day_%02zd", self.dayWeatherCode];
}

- (NSString *)nightWeather {
  return [[self class] getWeatherDescription:self.nightWeatherCode];
}

- (NSString *)nightWeatherIcon {
  return [NSString stringWithFormat:@"night_%02zd", self.dayWeatherCode];
}

- (NSString *)dayWindDirection {
  return [[self class] getWindDirection:self.dayWindDirectionCode];
}

- (NSString *)nightWindDirection {
  return [[self class] getWindDirection:self.nightWindDirectionCode];
}

- (NSString *)dayWindForce {
  return [[self class] getWindForce:self.dayWindForceCode];
}

- (NSString *)nightWindForce {
  return [[self class] getWindForce:self.nightWindForceCode];
}

+ (NSString *)getWeatherDescription:(NSInteger)code {
  static NSDictionary *dic;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    dic = [NSDictionary
        dictionaryWithObjectsAndKeys:
            @"晴", @(0), @"多云", @(1), @"阴", @(2), @"阵雨", @(3),
            @"雷阵雨", @(4), @"雷阵雨伴有冰雹", @(5), @"雨夹雪",
            @(6), @"小雨", @(7), @"中雨", @(8), @"大雨", @(9), @"暴雨",
            @(10), @"大暴雨", @(11), @"特大暴雨", @(12), @"阵雪",
            @(13), @"小雪", @(14), @"中雪", @(15), @"大雪", @(16),
            @"暴雪", @(17), @"雾", @(18), @"冻雨", @(19), @"沙尘暴",
            @(20), @"小到中雨", @(21), @"中到大雨", @(22),
            @"大到暴雨", @(23), @"暴雨到大暴雨", @(24),
            @"大暴雨到特大暴雨", @(25), @"小到中雪", @(26),
            @"中到大雪", @(27), @"大到暴雪", @(28), @"浮尘", @(29),
            @"扬沙", @(30), @"强沙尘暴", @(31), @"霾", @(53), @"无",
            @(99), nil];
  });
  return [dic objectForKey:@(code)];
}

+ (NSString *)getWindDirection:(NSInteger)code {
  static NSDictionary *dic;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    dic = [NSDictionary
        dictionaryWithObjectsAndKeys:@"无持续风向", @(0), @"东北风",
                                     @(1), @"东风", @(2), @"东南风", @(3),
                                     @"南风", @(4), @"西南风", @(5),
                                     @"西风", @(6), @"西北风", @(7),
                                     @"北风", @(8), @"旋转风", @(9), nil];
  });
  return [dic objectForKey:@(code)];
}

+ (NSString *)getWindForce:(NSInteger)code {
  static NSDictionary *dic;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    dic = [NSDictionary
        dictionaryWithObjectsAndKeys:@"微风", @(0), @"3-4 级", @(1),
                                     @"4-5 级", @(2), @"5-6 级", @(3),
                                     @"6-7 级", @(4), @"7-8 级", @(5),
                                     @"8-9 级", @(6), @"10-11 级", @(7),
                                     @"10-11 级", @(8), @"11-12 级", @(9), nil];
  });
  return [dic objectForKey:@(code)];
}

@end
