//
//  UserManager.h
//  Floyd
//
//  Created by George She on 16/1/28.
//  Copyright © 2016年 George She. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const kUserDidOAuthNotification;

@interface UserManager : NSObject
+ (instancetype)sharedInstance;

@property(nonatomic, strong, readonly) NSString *userId;
@property(nonatomic, strong) NSString *userName;
@property(nonatomic, strong) NSDate *userBirthday;
@property(nonatomic, strong) NSString *userAvatar;
@property(nonatomic, strong) NSString *userAvatarHash;
@property(nonatomic, strong, readonly) NSString *weiboId;
@property(nonatomic, strong, readonly) NSString *tokenExpiresIn;
@property(nonatomic, strong, readonly) NSString *weiboToken;
@property(nonatomic, strong, readonly) WeiboUser *wbUserInfo;
@property(nonatomic, assign, readonly) BOOL isLoggedIn;
@property(nonatomic, strong, readonly) NSString *userAvatarUrl;

- (void)login;
- (void)logout;
- (void)handleWBAuthorizeResponse:(WBAuthorizeResponse *)response;
@end
