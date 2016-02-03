//
//  WeatherInfoCell.h
//  Floyd
//
//  Created by admin on 16/1/7.
//  Copyright © 2016年 George She. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDTableViewCell.h"

#import "WeatherModel.h"

@interface WeatherInfoCellUserData : NSObject
@property(nonatomic, assign) BOOL isDayWeather;
@property(nonatomic, strong) WeatherModel *weather;
@end

@interface WeatherInfoCell : FDTableViewCell
@property(nonatomic, strong) WeatherInfoCellUserData *userData;

+ (NICellObject *)createObject:(id)_delegate userData:(id)_userData;
@end
