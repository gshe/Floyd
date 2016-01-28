//
//  CityModel.h
//  Floyd
//
//  Created by admin on 16/1/5.
//  Copyright © 2016年 George She. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CityModel : JSONModel
@property(nonatomic, strong) NSString *areaId;
@property(nonatomic, strong) NSString *nameEN;
@property(nonatomic, strong) NSString *nameCN;
@property(nonatomic, strong) NSString *cityNameEN;
@property(nonatomic, strong) NSString *cityNameCN;
@property(nonatomic, strong) NSString *provinceNameEN;
@property(nonatomic, strong) NSString *provinceNameCN;
@property(nonatomic, strong) NSString *nationalNameEN;
@property(nonatomic, strong) NSString *nationalNameCN;
@property(nonatomic, strong) NSString *cityLevel;
@property(nonatomic, strong) NSString *cityAreaCode;
@property(nonatomic, strong) NSString *cityPostCode;
@property(nonatomic, strong) NSString *lan;
@property(nonatomic, strong) NSString *lon;
@property(nonatomic, strong) NSString *altitude;
@property(nonatomic, strong) NSString *radarStation;
@end
