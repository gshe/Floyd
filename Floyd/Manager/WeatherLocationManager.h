//
//  WeatherLocationManager.h
//  Floyd
//
//  Created by admin on 16/1/5.
//  Copyright © 2016年 George She. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WeatherLocationDelegate <NSObject>
- (void)didStartSearchLocation;
- (void)didFindLocation:(CLPlacemark *)place;
- (void)locationWithError:(NSError *)error;
@end

@interface WeatherLocationManager : NSObject
+ (instancetype)sharedInstace;

@property(nonatomic, weak) id<WeatherLocationDelegate> delegate;
-(void) startLocate;
@end
