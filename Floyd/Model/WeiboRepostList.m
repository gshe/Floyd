//
//  WeiboRepostList.m
//  Floyd
//
//  Created by admin on 16/1/18.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "WeiboRepostList.h"

@implementation WeiboRepostList
+ (JSONKeyMapper *)keyMapper {
  return [[JSONKeyMapper alloc] initWithDictionary:@{
    @"reposts" : @"reposts",
    @"next_cursor" : @"nextCursor",
    @"previous_cursor" : @"previousCursor",
    @"total_number" : @"totalNumber",
  }];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
  return YES;
}
@end
