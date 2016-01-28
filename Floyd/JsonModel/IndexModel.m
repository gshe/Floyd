//
//  IndexModel.m
//  Floyd
//
//  Created by admin on 16/1/7.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "IndexModel.h"

@implementation IndexModel
+ (JSONKeyMapper *)keyMapper {
  return [[JSONKeyMapper alloc] initWithDictionary:@{
    @"i1" : @"indexShortName",
    @"i2" : @"indexNameCN",
    @"i3" : @"indexNameAlias",
    @"i4" : @"indexLevel",
    @"i5" : @"indexDesc",
  }];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
  return YES;
}
@end