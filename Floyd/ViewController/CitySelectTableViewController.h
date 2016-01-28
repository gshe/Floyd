//
//  CitySelectTableViewController.h
//  Floyd
//
//  Created by admin on 16/1/5.
//  Copyright © 2016年 George She. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CitySelectedDelegate <NSObject>
- (void)citySelectedWithCityName:(NSString *)cityName
                       andAreaId:(NSString *)areaId;
@end

@interface CitySelectTableViewController : FDTableViewController
@property(nonatomic, weak) id<CitySelectedDelegate> delegate;
@end
