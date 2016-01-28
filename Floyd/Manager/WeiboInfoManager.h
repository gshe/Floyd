//
//  WeiBoInfoManager.h
//  Floyd
//
//  Created by admin on 16/1/7.
//  Copyright © 2016年 George She. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboUser.h"
#import "WeiboUserList.h"
#import "WeiboList.h"
#import "WeiboCommentInfoList.h"
#import "WeiboRepostList.h"
#import "WeiboFavoritesList.h"
#import "weiboSDK.h"

typedef void (^wbLoginCompleted)(NSString *, NSString *, NSString *);
typedef void (^wbLogoutCompleted)();

@interface WeiboInfoManager : NSObject
- (instancetype)initWithToken:(NSString *)token andUserId:(NSString *)userId;

- (void)loginWithBlock:(wbLoginCompleted)completedBlock;
- (void)logoutWithBlock:(wbLogoutCompleted)completedBlock;

- (void)handleWBAuthorizeResponse:(WBAuthorizeResponse *)response;

- (void)userInfoWithUserId:(NSString *)userId
                   success:(void (^)(WeiboUser *ret))successBlock
                    failed:(void (^)(NSError *error))failedBlock;

- (void)friendsWithUserId:(NSString *)userId
                  success:(void (^)(WeiboUserList *ret))successBlock
                   failed:(void (^)(NSError *error))failedBlock;

- (void)followersWithUserId:(NSString *)userId
                    success:(void (^)(WeiboUserList *ret))successBlock
                     failed:(void (^)(NSError *error))failedBlock;

- (void)statusWithUrl:(NSString *)url
                  uid:(NSString *)userId
                count:(NSInteger)pageCount
                 page:(NSInteger)page
              success:(void (^)(WeiboList *ret))successBlock
               failed:(void (^)(NSError *error))failedBlock;

- (void)favoritesWithUrl:(NSString *)url
                   count:(NSInteger)pageCount
                    page:(NSInteger)page
                 success:(void (^)(WeiboFavoritesList *ret))successBlock
                  failed:(void (^)(NSError *error))failedBlock;

- (void)repostStatus:(NSString *)statusId
          repostText:(NSString *)text
             success:(void (^)(BOOL ret))successBlock
              failed:(void (^)(NSError *error))failedBlock;

- (void)commentWithStatusId:(NSString *)statusId
                      count:(NSInteger)pageCount
                       page:(NSInteger)page
                    success:(void (^)(WeiboCommentInfoList *ret))successBlock
                     failed:(void (^)(NSError *error))failedBlock;

- (void)repostWithStatusId:(NSString *)statusId
                     count:(NSInteger)pageCount
                      page:(NSInteger)page
                   success:(void (^)(WeiboRepostList *ret))successBlock
                    failed:(void (^)(NSError *error))failedBlock;
@end
