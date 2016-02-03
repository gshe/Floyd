//
//  WeiboCommentCell.h
//  Floyd
//
//  Created by admin on 16/1/15.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "FDTableViewCell.h"
#import "WeiboCommentInfo.h"

@interface WeiboCommentCellUserData : NSObject
@property(nonatomic, strong) WeiboCommentInfo *weiboComment;
@end


@interface WeiboCommentCell : FDTableViewCell
@property(nonatomic, strong) WeiboCommentCellUserData *userData;

+ (NICellObject *)createObject:(id)_delegate userData:(id)_userData;
@end
