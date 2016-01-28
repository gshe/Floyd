//
//  WeiboFavoritesList.m
//  Floyd
//
//  Created by admin on 16/1/19.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "WeiboFavoritesList.h"

@implementation WeiboFavoritesList
+ (JSONKeyMapper *)keyMapper {
	return [[JSONKeyMapper alloc] initWithDictionary:@{
													   @"favorites" : @"favorites",
													   }];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
	return YES;
}
@end
