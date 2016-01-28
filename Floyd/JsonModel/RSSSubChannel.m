//
//  NewsCategoryModel.m
//  Floyd
//
//  Created by admin on 16/1/8.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "RSSSubChannel.h"

@implementation RSSSubChannel
+ (JSONKeyMapper *)keyMapper {
	return [[JSONKeyMapper alloc] initWithDictionary:@{
													   @"_title" : @"title",
													   @"_text" : @"text",
													   @"_xmlUrl" : @"xmlUrl",
													   @"_type" : @"type",
													   @"_htmlUrl" : @"htmlUrl",
													   }];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
	return YES;
}
@end
