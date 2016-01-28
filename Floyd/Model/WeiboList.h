//
//  WeiboList.h
//  Floyd
//
//  Created by admin on 16/1/15.
//  Copyright © 2016年 George She. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboInfo.h"

@interface WeiboList : JSONModel

@property(nonatomic, strong) NSArray<WeiboInfo> *statuses;
@property(nonatomic, assign) long nextCursor;
@property(nonatomic, assign) long previousCursor;
@property(nonatomic, assign) long totalNumber;
@end
