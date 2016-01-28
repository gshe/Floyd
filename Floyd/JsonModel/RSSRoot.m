//
//  NewsCategory.m
//  Floyd
//
//  Created by admin on 16/1/8.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "RSSRoot.h"

@implementation RSSRoot
+ (JSONKeyMapper *)keyMapper {
  return [[JSONKeyMapper alloc] initWithDictionary:@{
    @"body.outline" : @"channel",
    @"head.title" : @"title",
	//@"head.meta" : @"meta",
	@"_version" : @"version",
  }];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
  return YES;
}
@end
