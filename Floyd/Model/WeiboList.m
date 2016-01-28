//
//  WeiboList.m
//  Floyd
//
//  Created by admin on 16/1/15.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "WeiboList.h"

@implementation WeiboList

+ (JSONKeyMapper *)keyMapper {
  return [[JSONKeyMapper alloc] initWithDictionary:@{
    @"statuses" : @"statuses",
    @"next_cursor" : @"nextCursor",
    @"previous_cursor" : @"previousCursor",
    @"total_number" : @"totalNumber",
  }];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
  return YES;
}

@end
