//
//  WeiboInfo.m
//  Floyd
//
//  Created by admin on 16/1/15.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "WeiboInfo.h"
#import "WeiboDateTimeConverter.h"

@implementation WeiboInfo
+ (JSONKeyMapper *)keyMapper {
  return [[JSONKeyMapper alloc] initWithDictionary:@{
    @"id" : @"weiboId",
  }];
}
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
  return YES;
}

- (NSString *)getCreatedAtString {
  return [WeiboDateTimeConverter weiboDateTimeToString:self.created_at];
}
@end
