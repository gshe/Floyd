//
//  UserManager.m
//  Floyd
//
//  Created by George She on 16/1/28.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "UserManager.h"
#import "SWGCustomerApi.h"

#define kUserId @"userId"
#define kUserName @"userName"
#define kUserBirthday @"userBirthday"
#define kUserAvatarUrl @"userAvatarUrl"
#define kToken @"token"
#define kExpiresIn @"expiresIn"
#define kWeiboUserId @"weibuserId"

NSString *const kUserDidOAuthNotification = @"kUserDidOAuthNotification";

@interface UserManager ()
@property(nonatomic, strong) WeiboInfoManager *wbManager;
@end

@implementation UserManager
+ (instancetype)sharedInstance {
  static UserManager *manager;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    manager = [[UserManager alloc] init];
  });
  return manager;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _wbManager = [[WeiboInfoManager alloc] init];
    _userId = [[NSUserDefaults standardUserDefaults] objectForKey:kUserId];
    _userName = [[NSUserDefaults standardUserDefaults] objectForKey:kUserName];
    _userBirthday =
        [[NSUserDefaults standardUserDefaults] objectForKey:kUserBirthday];
    _userAvatarUrl =
        [[NSUserDefaults standardUserDefaults] objectForKey:kUserAvatarUrl];
    _tokenExpiresIn =
        [[NSUserDefaults standardUserDefaults] objectForKey:kExpiresIn];
    _weiboToken = [[NSUserDefaults standardUserDefaults] objectForKey:kToken];
  }

  if (_userId) {
    _isLoggedIn = YES;
    if (self.weiboToken) {
      [self updateWeiboUserInfo];
    }
  } else {
    _isLoggedIn = NO;
  }

  return self;
}

- (void)login {
  if (self.wbUserInfo) {
    [self postNotification];
  } else {
    if (self.weiboToken) {
      [self updateWeiboUserInfo];
    } else {
      [self.wbManager loginWithBlock:^(NSString *token, NSString *expiresIn,
                                       NSString *userId) {
        _weiboToken = token;
        _weiboId = userId;
        _tokenExpiresIn = expiresIn;
        [[SWGCustomerApi sharedAPI]
            associateUserWithWeiboIdGetWithCompletionBlock:_weiboId
                                         completionHandler:^(SWGUserInfo *
                                                                 output,
                                                             NSError *error) {
                                           [self updateWeiboUserInfo];
                                         }];

      }];
    }
  }
}

- (void)logout {
  _userId = nil;
  _userName = nil;
  _wbUserInfo = nil;
  _weiboId = nil;
  _weiboToken = nil;
  _tokenExpiresIn = nil;
  [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserId];
  [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserName];
  [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserBirthday];
  [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserAvatarUrl];
  [[NSUserDefaults standardUserDefaults] removeObjectForKey:kExpiresIn];
  [[NSUserDefaults standardUserDefaults] removeObjectForKey:kToken];
  [[NSUserDefaults standardUserDefaults] synchronize];
  [self.wbManager logoutWithBlock:^{

  }];
}

- (void)updateWeiboUserInfo {
  [self.wbManager userInfoWithUserId:self.weiboId
      success:^(WeiboUser *ret) {
        _wbUserInfo = ret;
        [self postNotification];
      }
      failed:^(NSError *error) {
        _wbUserInfo = nil;
        [self postNotification];
      }];
}

- (void)postNotification {
  [[NSNotificationCenter defaultCenter]
      postNotificationName:kUserDidOAuthNotification
                    object:nil];
}
@end
