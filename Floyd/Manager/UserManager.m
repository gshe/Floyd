//
//  UserManager.m
//  Floyd
//
//  Created by George She on 16/1/28.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "UserManager.h"
#import "SWGICustomerApi.h"

#define kUserId @"userId"
#define kUserName @"userName"
#define kUserBirthday @"userBirthday"
#define kUserAvatar @"userAvatar"
#define kUserAvatarHash @"userAvatarHash"
#define kWeiboToken @"WeiboToken"
#define kExpiresIn @"expiresIn"
#define kWeiboUserId @"weiboUserId"

NSString *const kUserDidOAuthNotification = @"kUserDidOAuthNotification";

@interface UserManager ()
@property(nonatomic, strong) WeiboInfoManager *wbManager;
@property(nonatomic, strong) NSDateFormatter *formater;
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
    _formater = [[NSDateFormatter alloc] init];
    _formater.dateFormat = @"yyyy-mm-dd";
    _userId = [[NSUserDefaults standardUserDefaults] objectForKey:kUserId];
    _userName = [[NSUserDefaults standardUserDefaults] objectForKey:kUserName];
    _userBirthday =
        [[NSUserDefaults standardUserDefaults] objectForKey:kUserBirthday];
    _userAvatar =
        [[NSUserDefaults standardUserDefaults] objectForKey:kUserAvatar];
    _userAvatarHash =
        [[NSUserDefaults standardUserDefaults] objectForKey:kUserAvatarHash];
    _tokenExpiresIn =
        [[NSUserDefaults standardUserDefaults] objectForKey:kExpiresIn];
    _weiboToken =
        [[NSUserDefaults standardUserDefaults] objectForKey:kWeiboToken];
    _weiboId =
        [[NSUserDefaults standardUserDefaults] objectForKey:kWeiboUserId];
  }

  if (_userId && _weiboToken && _weiboId) {
    _isLoggedIn = YES;
    _wbManager = [[WeiboInfoManager alloc] initWithToken:self.weiboToken
                                               andUserId:self.weiboId];
    [self updateWeiboUserInfo];
  } else {
    _isLoggedIn = NO;
    _wbManager = [[WeiboInfoManager alloc] init];
  }
  if (_userId) {
    [[SWGICustomerApi sharedAPI]
        userByIdGetWithCompletionBlock:_userId
                     completionHandler:^(SWGUserInfo *output, NSError *error) {
                       if (!error) {
                         _userName = output.name;
                         _userBirthday =
                             [_formater dateFromString:output.birthday];
                       }
                       [self postNotification];
                     }];
  }
  return self;
}

- (void)login {
  if (self.wbUserInfo) {
    [self postNotification];
  } else {
    if (_userId && self.weiboToken && self.weiboId) {
      [self updateWeiboUserInfo];
    } else {
      [self.wbManager loginWithBlock:^(NSString *token, NSString *expiresIn,
                                       NSString *userId) {
        _weiboToken = token;
        _weiboId = userId;
        _tokenExpiresIn = expiresIn;
        [[NSUserDefaults standardUserDefaults] setObject:_weiboToken
                                                  forKey:kWeiboToken];
        [[NSUserDefaults standardUserDefaults] setObject:_tokenExpiresIn
                                                  forKey:kExpiresIn];
        [[NSUserDefaults standardUserDefaults] setObject:_weiboId
                                                  forKey:kWeiboUserId];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[SWGICustomerApi sharedAPI]
            associateUserWithWeiboIdGetWithCompletionBlock:
                _weiboId completionHandler:^(SWGUserInfo *output,
                                             NSError *error) {
              if (!error) {
                _isLoggedIn = YES;
                _userId = output._id;
                _userName = output.name;
                _userAvatar = output.avatarKey;
                _userAvatarHash = output.avatarHash;
                _userBirthday = [_formater dateFromString:output.birthday];
                [[NSUserDefaults standardUserDefaults] setObject:_userId
                                                          forKey:kUserId];
                [[NSUserDefaults standardUserDefaults] setObject:_userName
                                                          forKey:kUserName];
                [[NSUserDefaults standardUserDefaults] setObject:_userBirthday
                                                          forKey:kUserBirthday];
                [[NSUserDefaults standardUserDefaults] setObject:_userAvatar
                                                          forKey:kUserAvatar];
                [[NSUserDefaults standardUserDefaults]
                    setObject:_userAvatarHash
                       forKey:kUserAvatarHash];
                [[NSUserDefaults standardUserDefaults] synchronize];
              }

              [self updateWeiboUserInfo];
            }];

      }];
    }
  }
}

- (void)logout {
  _isLoggedIn = NO;
  _userId = nil;
  _userName = nil;
  _wbUserInfo = nil;
  _weiboId = nil;
  _weiboToken = nil;
  _tokenExpiresIn = nil;
  [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserId];
  [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserName];
  [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserBirthday];
  [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserAvatar];
  [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserAvatarHash];
  [[NSUserDefaults standardUserDefaults] removeObjectForKey:kExpiresIn];
  [[NSUserDefaults standardUserDefaults] removeObjectForKey:kWeiboToken];
  [[NSUserDefaults standardUserDefaults] removeObjectForKey:kWeiboUserId];
  [[NSUserDefaults standardUserDefaults] synchronize];
  [self.wbManager logoutWithBlock:^{

  }];
}

- (void)handleWBAuthorizeResponse:(WBAuthorizeResponse *)response {
  [self.wbManager handleWBAuthorizeResponse:response];
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

- (void)setUserName:(NSString *)userName {
  _userName = userName;
  [[NSUserDefaults standardUserDefaults] setObject:_userName forKey:kUserName];
  [[NSUserDefaults standardUserDefaults] synchronize];
  [self postNotification];
}

- (void)setUserAvatar:(NSString *)userAvatar {
  _userAvatar = userAvatar;
  [[NSUserDefaults standardUserDefaults] setObject:_userAvatar
                                            forKey:kUserAvatar];
  [[NSUserDefaults standardUserDefaults] synchronize];
  [self postNotification];
}

- (void)setUserAvatarHash:(NSString *)userAvatarHash {
  _userAvatarHash = userAvatarHash;
  [[NSUserDefaults standardUserDefaults] setObject:_userAvatarHash
                                            forKey:kUserAvatarHash];
  [[NSUserDefaults standardUserDefaults] synchronize];
  [self postNotification];
}

- (void)setUserBirthday:(NSDate *)userBirthday {
  _userBirthday = userBirthday;
  [[NSUserDefaults standardUserDefaults] setObject:_userBirthday
                                            forKey:kUserBirthday];
  [[NSUserDefaults standardUserDefaults] synchronize];
  [self postNotification];
}

- (NSString *)userAvatarUrl {
  if (_userAvatar) {
    return QINIU_FILE_URL_MEDIUM(_userAvatar);
  } else {
    return nil;
  }
}
@end
