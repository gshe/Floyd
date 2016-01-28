//
//  NewsChannel.m
//  Floyd
//
//  Created by admin on 16/1/8.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "RSSChannel.h"

@implementation RSSChannel
+ (JSONKeyMapper *)keyMapper {
  return [[JSONKeyMapper alloc] initWithDictionary:@{
    @"_title" : @"title",
    @"_text" : @"text",
    @"outline" : @"subChannel",
  }];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
  return YES;
}

- (NSString *)title {
  return [_title componentsSeparatedByString:@"-"][0];
}
@end
