//
//  FavoriteInfo.h
//  Floyd
//
//  Created by admin on 16/1/19.
//  Copyright © 2016年 George She. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol FavoriteInfo
@end

@interface FavoriteInfo : JSONModel
@property(nonatomic, strong) NSString *favorited_time;
@property(nonatomic, strong) WeiboInfo *status;
@property(nonatomic, strong) NSArray *tags;
- (NSString *)getFavoritedTimeString;

@end
