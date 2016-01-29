//
//  WeiBoInfoManager.m
//  Floyd
//
//  Created by admin on 16/1/7.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "WeiboInfoManager.h"
#import "WeiboSDK.h"
#import "WBHttpRequest+WeiboShare.h"

#define kRedirectURI @"https://api.weibo.com/oauth2/default.html"
#define kBaseUrl @"https://api.weibo.com/2/"

@interface WeiboInfoManager ()
@property(nonatomic, strong) NSString *token;
@property(nonatomic, strong) NSString *userId;

@property(nonatomic, copy) wbLoginCompleted loginBlock;
@property(nonatomic, copy) wbLogoutCompleted logoutBlock;
@end

@implementation WeiboInfoManager
- (instancetype)initWithToken:(NSString *)token andUserId:(NSString *)userId {
  self = [super init];
  if (self) {
    _token = token;
    _userId = userId;
  }
  return self;
}

- (void)loginWithBlock:(wbLoginCompleted)completedBlock {
  self.loginBlock = completedBlock;
  WBAuthorizeRequest *request = [WBAuthorizeRequest request];
  request.redirectURI = kRedirectURI;
  request.scope = @"all";
  request.userInfo = nil;
  [WeiboSDK sendRequest:request];
}

- (void)logoutWithBlock:(wbLogoutCompleted)completedBlock {
  self.logoutBlock = completedBlock;
}

- (void)handleWBAuthorizeResponse:(WBAuthorizeResponse *)response {
  if (0 == response.statusCode) {
    NSString *userId = [(WBAuthorizeResponse *)response userID];
    NSString *token = [(WBAuthorizeResponse *)response accessToken];
    NSString *expiresIn = response.userInfo[@"expires_in"];
    [self logedInWithToken:token andExpiredsIn:expiresIn andUserId:userId];
  } else {
    [self logedInWithToken:nil andExpiredsIn:nil andUserId:nil];
  }
}

- (void)logedInWithToken:(NSString *)token
           andExpiredsIn:(NSString *)expiresIn
               andUserId:(NSString *)userId {
  _token = token;
  _userId = userId;

  if (self.loginBlock) {
    self.loginBlock(token, expiresIn, userId);
  }
}

- (void)userInfoWithUserId:(NSString *)userId
                   success:(void (^)(WeiboUser *ret))successBlock
                    failed:(void (^)(NSError *error))failedBlock {
  [WBHttpRequest requestForUserProfile:userId ? userId : self.userId
                       withAccessToken:self.token
                    andOtherProperties:nil
                                 queue:nil
                 withCompletionHandler:^(WBHttpRequest *httpRequest, id result,
                                         NSError *error) {
                   if (!error) {
                     successBlock(result);
                   } else {
                     failedBlock(error);
                   }
                 }];
}

- (void)friendsWithUserId:(NSString *)userId
                  success:(void (^)(WeiboUserList *ret))successBlock
                   failed:(void (^)(NSError *error))failedBlock {
  [WBHttpRequest requestForFriendsListOfUser:userId ? userId : self.userId
                             withAccessToken:self.token
                          andOtherProperties:nil
                                       queue:nil
                       withCompletionHandler:^(WBHttpRequest *httpRequest,
                                               id result, NSError *error) {
                         if (!error) {
                           WeiboUserList *userList =
                               [WeiboUserList userListFromDictionary:result];
                           successBlock(userList);
                         } else {
                           failedBlock(error);
                         }
                       }];
}

- (void)followersWithUserId:(NSString *)userId
                    success:(void (^)(WeiboUserList *ret))successBlock
                     failed:(void (^)(NSError *error))failedBlock {
  [WBHttpRequest requestForFollowersListOfUser:userId ? userId : self.userId
                               withAccessToken:self.token
                            andOtherProperties:nil
                                         queue:nil
                         withCompletionHandler:^(WBHttpRequest *httpRequest,
                                                 id result, NSError *error) {
                           if (!error) {
                             WeiboUserList *userList =
                                 [WeiboUserList userListFromDictionary:result];
                             successBlock(userList);
                           } else {
                             failedBlock(error);
                           }
                         }];
}

- (void)statusWithUrl:(NSString *)url
                  uid:(NSString *)userId
                count:(NSInteger)pageCount
                 page:(NSInteger)page
              success:(void (^)(WeiboList *ret))successBlock
               failed:(void (^)(NSError *error))failedBlock {
  NSString *fullUrl = kBaseUrl;
  fullUrl = [fullUrl stringByAppendingString:url];
  NSDictionary *dic = [NSDictionary
      dictionaryWithObjectsAndKeys:
          self.token, @"access_token", userId ? userId : self.userId, @"uid",
          [NSString stringWithFormat:@"%zd", page], @"page",
          [NSString stringWithFormat:@"%zd", pageCount], @"count", nil];
  [WBHttpRequest
             requestWithURL:fullUrl
                 httpMethod:@"GET"
                     params:dic
                      queue:nil
      withCompletionHandler:^(WBHttpRequest *httpRequest, id result,
                              NSError *error) {
        if (!error) {
          NSError *jsonError;
          WeiboList *wbList =
              [[WeiboList alloc] initWithDictionary:result error:&jsonError];
          if (jsonError) {
            failedBlock(error);
          } else {
            successBlock(wbList);
          }

        } else {
          failedBlock(error);
        }
      }];
}

- (void)favoritesWithUrl:(NSString *)url
                   count:(NSInteger)pageCount
                    page:(NSInteger)page
                 success:(void (^)(WeiboFavoritesList *ret))successBlock
                  failed:(void (^)(NSError *error))failedBlock {
  NSString *fullUrl = kBaseUrl;
  fullUrl = [fullUrl stringByAppendingString:url];
  NSDictionary *dic = [NSDictionary
      dictionaryWithObjectsAndKeys:
          self.token, @"access_token", [NSString stringWithFormat:@"%zd", page],
          @"page", [NSString stringWithFormat:@"%zd", pageCount], @"count",
          nil];
  [WBHttpRequest requestWithURL:fullUrl
                     httpMethod:@"GET"
                         params:dic
                          queue:nil
          withCompletionHandler:^(WBHttpRequest *httpRequest, id result,
                                  NSError *error) {
            if (!error) {
              NSError *jsonError;
              WeiboFavoritesList *favoritesList =
                  [[WeiboFavoritesList alloc] initWithDictionary:result
                                                           error:&jsonError];
              if (jsonError) {
                failedBlock(error);
              } else {
                successBlock(favoritesList);
              }

            } else {
              failedBlock(error);
            }
          }];
}

- (void)repostStatus:(NSString *)statusId
          repostText:(NSString *)text
             success:(void (^)(BOOL))successBlock
              failed:(void (^)(NSError *))failedBlock {
  [WBHttpRequest requestForRepostAStatus:statusId
                              repostText:text
                         withAccessToken:self.token
                      andOtherProperties:nil
                                   queue:nil
                   withCompletionHandler:^(WBHttpRequest *httpRequest,
                                           id result, NSError *error) {
                     if (!error) {
                       successBlock(YES);
                     } else {
                       failedBlock(error);
                     }
                   }];
}

- (void)commentWithStatusId:(NSString *)statusId
                      count:(NSInteger)pageCount
                       page:(NSInteger)page
                    success:(void (^)(WeiboCommentInfoList *ret))successBlock
                     failed:(void (^)(NSError *error))failedBlock {
  NSString *fullUrl = kBaseUrl;
  fullUrl = [fullUrl stringByAppendingString:@"comments/show.json"];
  NSDictionary *dic = [NSDictionary
      dictionaryWithObjectsAndKeys:
          self.token, @"access_token", statusId, @"id",
          [NSString stringWithFormat:@"%zd", page], @"page",
          [NSString stringWithFormat:@"%zd", pageCount], @"count", nil];
  [WBHttpRequest requestWithURL:fullUrl
                     httpMethod:@"GET"
                         params:dic
                          queue:nil
          withCompletionHandler:^(WBHttpRequest *httpRequest, id result,
                                  NSError *error) {
            if (!error) {
              NSError *jsonError;
              WeiboCommentInfoList *commentList =
                  [[WeiboCommentInfoList alloc] initWithDictionary:result
                                                             error:&jsonError];
              if (jsonError) {
                failedBlock(error);
              } else {
                successBlock(commentList);
              }

            } else {
              failedBlock(error);
            }
          }];
}

- (void)repostWithStatusId:(NSString *)statusId
                     count:(NSInteger)pageCount
                      page:(NSInteger)page
                   success:(void (^)(WeiboRepostList *ret))successBlock
                    failed:(void (^)(NSError *error))failedBlock {
  NSString *fullUrl = kBaseUrl;
  fullUrl = [fullUrl stringByAppendingString:@"statuses/repost_timeline.json"];
  NSDictionary *dic = [NSDictionary
      dictionaryWithObjectsAndKeys:
          self.token, @"access_token", statusId, @"id",
          [NSString stringWithFormat:@"%zd", page], @"page",
          [NSString stringWithFormat:@"%zd", pageCount], @"count", nil];
  [WBHttpRequest requestWithURL:fullUrl
                     httpMethod:@"GET"
                         params:dic
                          queue:nil
          withCompletionHandler:^(WBHttpRequest *httpRequest, id result,
                                  NSError *error) {
            if (!error) {
              NSError *jsonError;
              WeiboRepostList *repostList =
                  [[WeiboRepostList alloc] initWithDictionary:result
                                                        error:&jsonError];
              if (jsonError) {
                failedBlock(error);
              } else {
                successBlock(repostList);
              }

            } else {
              failedBlock(error);
            }
          }];
}

@end
