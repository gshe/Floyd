//
//  WeiboRepostList.h
//  Floyd
//
//  Created by admin on 16/1/18.
//  Copyright © 2016年 George She. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface WeiboRepostList : JSONModel
@property(nonatomic, strong) NSArray<WeiboInfo> *reposts;
@property(nonatomic, assign) long nextCursor;
@property(nonatomic, assign) long previousCursor;
@property(nonatomic, assign) long totalNumber;
@end
