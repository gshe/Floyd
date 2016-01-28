//
//  WeiboInfo.h
//  Floyd
//
//  Created by admin on 16/1/15.
//  Copyright © 2016年 George She. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "weiboUser.h"
#import "WeiboInfoUser.h"

@protocol WeiboInfo <NSObject>
@end

@interface WeiboInfo : JSONModel
@property(nonatomic, strong) NSString *created_at;
@property(nonatomic, assign) long long weiboId;
@property(nonatomic, assign) long long mid;
@property(nonatomic, strong) NSString *idstr;
@property(nonatomic, strong) NSString *text;
@property(nonatomic, strong) NSString *source;

@property(nonatomic, assign) BOOL favorited;
@property(nonatomic, assign) BOOL truncated;

@property(nonatomic, strong) NSString *in_reply_to_status_id;
@property(nonatomic, strong) NSString *in_reply_to_user_id;
@property(nonatomic, strong) NSString *in_reply_to_screen_name;
@property(nonatomic, strong) NSString *thumbnail_pic;

@property(nonatomic, strong) NSString *bmiddle_pic;
@property(nonatomic, strong) NSString *original_pic;

@property(nonatomic, assign) int reposts_count;
@property(nonatomic, assign) int comments_count;
@property(nonatomic, assign) int attitudes_count;
@property(nonatomic, assign) int mlevel;
@property(nonatomic, strong) NSArray *pic_urls;
@property(nonatomic, strong) WeiboInfoUser *user;
@property(nonatomic, strong) WeiboInfo *retweeted_status;
- (NSString *)getCreatedAtString;
@end
