//
//  Weather.m
//  Floyd
//
//  Created by admin on 16/1/5.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "Weather.h"

@implementation Weather

+ (JSONKeyMapper *)keyMapper {
  return [[JSONKeyMapper alloc] initWithDictionary:@{
    @"c" : @"city",
    @"f.f1" : @"weather",
    @"f.f0" : @"forcastTime",
  }];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
  return YES;
}

@end
