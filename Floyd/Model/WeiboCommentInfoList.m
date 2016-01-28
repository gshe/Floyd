//
//  WeiboCommentInfoList.m
//  Floyd
//
//  Created by admin on 16/1/15.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "WeiboCommentInfoList.h"

@implementation WeiboCommentInfoList
+ (JSONKeyMapper *)keyMapper {
  return [[JSONKeyMapper alloc] initWithDictionary:@{
    @"comments" : @"comments",
    @"next_cursor" : @"nextCursor",
    @"previous_cursor" : @"previousCursor",
    @"total_number" : @"totalNumber",
  }];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
  return YES;
}
@end
