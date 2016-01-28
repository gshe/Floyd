//
//  WeatherLocationManager.m
//  Floyd
//
//  Created by admin on 16/1/5.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "WeatherLocationManager.h"

@interface WeatherLocationManager () <CLLocationManagerDelegate>

@property(nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation WeatherLocationManager

+ (instancetype)sharedInstace {
  static WeatherLocationManager *manager;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    manager = [[WeatherLocationManager alloc] init];
  });
  return manager;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 10;
    if ([self.locationManager
            respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
      [self.locationManager requestWhenInUseAuthorization];
    }
  }

  if ([self.delegate respondsToSelector:@selector(didStartSearchLocation)]) {
    [self.delegate didStartSearchLocation];
  }
  return self;
}

- (void)startLocate {
  [self.locationManager startUpdatingLocation];
}

#pragma mark CLLocationManagerDelegate
/**
 * 获取经纬度
 */
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
  [self.locationManager stopUpdatingLocation];
  CLLocation *currLocation = [locations lastObject];
  NSLog(@"la---%f, lo---%f", currLocation.coordinate.latitude,
        currLocation.coordinate.longitude);
  CLGeocoder *geocoder = [[CLGeocoder alloc] init];
  [geocoder
      reverseGeocodeLocation:currLocation
           completionHandler:^(NSArray<CLPlacemark *> *_Nullable placemarks,
                               NSError *_Nullable error) {
             if (error) {
               if ([self.delegate
                       respondsToSelector:@selector(locationWithError:)]) {
                 [self.delegate locationWithError:error];
               }
             } else {
               for (CLPlacemark *placeMark in placemarks) {
                 NSLog(@"地址name:%@ ", placeMark.name);
                 NSLog(@"地址thoroughfare:%@", placeMark.thoroughfare);
                 NSLog(@"地址subThoroughfare:%@", placeMark.subThoroughfare);
                 NSLog(@"地址locality:%@", placeMark.locality);
                 NSLog(@"地址subLocality:%@", placeMark.subLocality);
                 NSLog(@"地址administrativeArea:%@",
                       placeMark.administrativeArea);
                 NSLog(@"地址subAdministrativeArea:%@",
                       placeMark.subAdministrativeArea);
                 NSLog(@"地址postalCode:%@", placeMark.postalCode);
                 NSLog(@"地址ISOcountryCode:%@", placeMark.ISOcountryCode);
                 NSLog(@"地址country:%@", placeMark.country);
                 NSLog(@"地址inlandWater:%@", placeMark.inlandWater);
                 NSLog(@"地址ocean:%@", placeMark.ocean);
                 NSLog(@"地址areasOfInterest:%@", placeMark.areasOfInterest);
                 if ([self.delegate
                         respondsToSelector:@selector(didFindLocation:)]) {
                   [self.delegate didFindLocation:placeMark];
                 }
                 break;
               }
             }
           }];
}

/** *定位失败，回调此方法 */
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
  if ([error code] == kCLErrorDenied) {
    NSLog(@"访问被拒绝");
  }
  if ([error code] == kCLErrorLocationUnknown) {
    NSLog(@"无法获取位置信息");
  }

  if ([self.delegate respondsToSelector:@selector(locationWithError:)]) {
                [self.delegate locationWithError:error];
	}
}



@end
