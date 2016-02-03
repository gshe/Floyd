//
//  CitySelectCell.h
//  Floyd
//
//  Created by admin on 16/1/7.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "FDTableViewCell.h"
@interface CitySelectCellUserData : NSObject
@property(nonatomic, strong) NSString *cityName;
@property(nonatomic, strong) NSString *areaId;
@property(nonatomic, strong) NSDictionary *subCity;
@end

@interface CitySelectCell : FDTableViewCell
@property(nonatomic, strong) CitySelectCellUserData *userData;

+ (NICellObject *)createObject:(id)_delegate userData:(id)_userData;
@end
