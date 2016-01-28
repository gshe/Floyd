//
//  WeiboCommentInfo.h
//  Floyd
//
//  Created by admin on 16/1/15.
//  Copyright © 2016年 George She. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol WeiboCommentInfo
@end

@interface WeiboCommentInfo : JSONModel
@property(nonatomic, strong) NSString *created_at;
@property(nonatomic, assign) long long commentId;
@property(nonatomic, strong) NSString *text;
@property(nonatomic, strong) NSString *source;
@property(nonatomic, strong) WeiboInfoUser *user;

- (NSString *)getCreatedAtString;
@end
