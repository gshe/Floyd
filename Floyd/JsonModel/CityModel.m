//
//  CityModel.m
//  Floyd
//
//  Created by admin on 16/1/5.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "CityModel.h"
// c1 //区域 ID // // 101010100 // c2 //城市英文名 // // beijing // // c3
// //城市中文名 //北京 // c4 //城市所在市英文名 // beijing // c5
// //城市所在市中文名 //北京 // c6 //城市所在省英文名 // beijing // c7
// //城市所在省中文名 //北京 // 5 // // c8 //城市所在国家英文名 //
// china // c9 //城市所在国家中文名 //中国 // c10 //城市级别 // 1 // c11
// //城市区号 // 010 // // c12 //邮编 // 100000 // // c13 //经度 // 116.391 //
// c14 //纬度 // 39.904 // c15 //海拔 // 33 // c16 //雷达站号 // AZ9010

@implementation CityModel
+ (JSONKeyMapper *)keyMapper {
  return [[JSONKeyMapper alloc] initWithDictionary:@{
    @"c1" : @"areaId",
    @"c2" : @"nameEN",
    @"c3" : @"nameCN",
    @"c4" : @"cityNameEN",
    @"c5" : @"cityNameCN",
    @"c6" : @"provinceNameEN",
    @"c7" : @"provinceNameCN",
    @"c8" : @"nationalNameEN",
    @"c9" : @"nationalNameCN",
    @"c10" : @"cityLevel",
    @"c11" : @"cityAreaCode",
    @"c12" : @"cityPostCode",
    @"c13" : @"lan",
    @"c14" : @"lon",
    @"c15" : @"altitude",
    @"c16" : @"radarStation",
  }];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
	return YES;
}
@end
