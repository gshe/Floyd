//
//  FavoriteInfo.m
//  Floyd
//
//  Created by admin on 16/1/19.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "FavoriteInfo.h"
#import "WeiboDateTimeConverter.h"

@implementation FavoriteInfo
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
  return YES;
}

- (NSString *)getFavoritedTimeString {
  return [WeiboDateTimeConverter weiboDateTimeToString:self.favorited_time];
}
@end
