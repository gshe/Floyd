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
@property(nonatomic, strong, readonly) NSString *userName;
@property(nonatomic, strong, readonly) NSDate *userBirthday;
@property(nonatomic, strong, readonly) NSString *userAvatarUrl;
@property(nonatomic, strong, readonly) NSString *weiboId;
@property(nonatomic, strong, readonly) NSString *tokenExpiresIn;
@property(nonatomic, strong, readonly) NSString *weiboToken;
@property(nonatomic, strong, readonly) WeiboUser *wbUserInfo;
@property(nonatomic, assign, readonly) BOOL isLoggedIn;

- (void)login;
- (void)logout;
@end
