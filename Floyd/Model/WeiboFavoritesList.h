//
//  WeiboFavoritesList.h
//  Floyd
//
//  Created by admin on 16/1/19.
//  Copyright © 2016年 George She. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "FavoriteInfo.h"

@interface WeiboFavoritesList : JSONModel
@property(nonatomic, strong) NSArray<FavoriteInfo> *favorites;
@end
