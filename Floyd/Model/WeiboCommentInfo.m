//
//  WeiboCommentInfo.m
//  Floyd
//
//  Created by admin on 16/1/15.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "WeiboCommentInfo.h"
#import "WeiboDateTimeConverter.h"

@implementation WeiboCommentInfo
+ (JSONKeyMapper *)keyMapper {
  return [[JSONKeyMapper alloc] initWithDictionary:@{
    @"id" : @"commentId",
  }];
}
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
  return YES;
}

- (NSString *)getCreatedAtString {
  return [WeiboDateTimeConverter weiboDateTimeToString:self.created_at];
}
@end
