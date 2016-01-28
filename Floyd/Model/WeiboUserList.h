//
//  WeiboUserList.h
//  Floyd
//
//  Created by admin on 16/1/14.
//  Copyright © 2016年 George She. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeiboUserList : NSObject
+ (instancetype)userListFromDictionary:(NSDictionary *)dic;

@property(nonatomic, strong) NSArray *users;
@property(nonatomic, assign) long nextCursor;
@property(nonatomic, assign) long previousCursor;
@property(nonatomic, assign) long totalNumber;
@end
