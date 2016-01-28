//
//  WeiboInfoUser.h
//  Floyd
//
//  Created by admin on 16/1/15.
//  Copyright © 2016年 George She. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol WeiboInfoUser
@end

@interface WeiboInfoUser : JSONModel
@property(nonatomic, assign) long long userId;
@property(nonatomic, strong) NSString *screen_name;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *province;
@property(nonatomic, strong) NSString *city;
@property(nonatomic, strong) NSString *location;
@property(nonatomic, strong) NSString *userDescription;
@property(nonatomic, strong) NSString *url;
@property(nonatomic, strong) NSString *profile_image_url;
@property(nonatomic, strong) NSString *domain;
@property(nonatomic, strong) NSString *gender;
@property(nonatomic, assign) int followers_count;
@property(nonatomic, assign) int friends_count;
@property(nonatomic, assign) int statuses_count;
@property(nonatomic, assign) int favourites_count;
@property(nonatomic, strong) NSString *created_at;
@property(nonatomic, assign) BOOL following;
@property(nonatomic, assign) BOOL allow_all_act_msg;
@property(nonatomic, assign) BOOL remark;
@property(nonatomic, assign) BOOL geo_enabled;
@property(nonatomic, assign) BOOL verified;
@property(nonatomic, assign) BOOL allow_all_comment;
@property(nonatomic, strong) NSString *avatar_large;
@property(nonatomic, strong) NSString *verified_reason;
@property(nonatomic, assign) BOOL follow_me;
@property(nonatomic, assign) int online_status;
@property(nonatomic, assign) int bi_followers_count;
@end
