//
//  WeiboCommentInfoList.h
//  Floyd
//
//  Created by admin on 16/1/15.
//  Copyright © 2016年 George She. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "WeiboCommentInfo.h"

@interface WeiboCommentInfoList : JSONModel
@property(nonatomic, strong) NSArray<WeiboCommentInfo> *comments;
@property(nonatomic, assign) long nextCursor;
@property(nonatomic, assign) long previousCursor;
@property(nonatomic, assign) long totalNumber;
@end
