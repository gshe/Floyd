//
//  WeiboInfoUser.m
//  Floyd
//
//  Created by admin on 16/1/15.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "WeiboInfoUser.h"

@implementation WeiboInfoUser
+ (JSONKeyMapper *)keyMapper {
  return [[JSONKeyMapper alloc] initWithDictionary:@{
    @"id" : @"userId",
    @"description" : @"userDescription"
  }];
}
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
  return YES;
}
@end
