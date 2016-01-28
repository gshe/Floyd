//
//  WeiboUserList.m
//  Floyd
//
//  Created by admin on 16/1/14.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "WeiboUserList.h"

@implementation WeiboUserList
+(instancetype) userListFromDictionary:(NSDictionary *) dic{
	WeiboUserList *userList = [[WeiboUserList alloc]init];
	userList.users = dic[@"users"];
	userList.nextCursor = [dic[@"next_cursor"] longValue];
	userList.previousCursor = [dic[@"previous_cursor"] longValue];
	userList.totalNumber= [dic[@"total_number"] longValue];
	return userList;
}
@end
