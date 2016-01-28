//
//  NewsItemModel.m
//  Floyd
//
//  Created by admin on 16/1/8.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "RSSItemModel.h"

@implementation RSSItemModel
+ (JSONKeyMapper *)keyMapper {
  return [[JSONKeyMapper alloc] initWithDictionary:@{
    @"author" : @"author",
    @"description" : @"newsDesc",
    @"guid" : @"guid",
    @"link" : @"link",
    @"title" : @"title",
    @"pubDate" : @"pubDate",
  }];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
  return YES;
}
@end
