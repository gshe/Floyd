//
//  SmartWeatherAPI.h
//  Floyd
//
//  Created by admin on 16/1/5.
//  Copyright © 2016年 George She. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Weather.h"
#import "Index.h"

@interface SmartWeatherAPI : NSObject
- (void)queryWeather:(NSString *)areaId success:(void (^)(Weather* ret))successBlock failed:(void (^)(NSError* error)) failedBlock;

-(void) QueryIndex:(NSString *)areaId success:(void (^)(Index* ret))successBlock failed:(void (^)(NSError* error)) failedBlock;
@end
