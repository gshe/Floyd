//
//  WeiboCommentCell.h
//  Floyd
//
//  Created by admin on 16/1/15.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "FDTableViewCell.h"
#import "WeiboInfo.h"

@interface WeiboRepostCellUserData : NSObject
@property(nonatomic, strong) WeiboInfo *weiboRepost;
@end

@interface WeiboRepostCell : FDTableViewCell
@property(nonatomic, strong) WeiboRepostCellUserData *userData;

+ (NICellObject *)createObject:(id)_delegate userData:(id)_userData;
@end
