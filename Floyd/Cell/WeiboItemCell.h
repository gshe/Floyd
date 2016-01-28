//
//  WeiboItemCell.h
//  Floyd
//
//  Created by admin on 16/1/15.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "FDTableViewCell.h"
#import "WeiboInfo.h"

@protocol WeiboItemCellDelegate;

@interface WeiboItemCellUserData : NSObject
@property(nonatomic, strong) WeiboInfo *weiboInfo;
@property (nonatomic, assign) BOOL hiddenAction;
@property(nonatomic, weak) id<WeiboItemCellDelegate> delegate;
@end

@interface WeiboItemCell : FDTableViewCell
@property(nonatomic, strong) WeiboItemCellUserData *userData;

+ (NICellObject *)createObject:(id)_delegate userData:(id)_userData;

+ (CGFloat)getPictureViewHeight:(CGFloat)contentWidth
                      weiboInfo:(WeiboInfo *)weiboInfo;
+ (void)fillPictureView:(CGFloat)contentWidth
                    pic:(UIView *)picContentView
              weiboInfo:(WeiboInfo *)wbInfo;
@end

@protocol WeiboItemCellDelegate <NSObject>
- (void)weiboCell:(WeiboItemCell *)cell forwordAction:(WeiboInfo *)weiboInfo;
- (void)weiboCell:(WeiboItemCell *)cell commentAction:(WeiboInfo *)weiboInfo;
- (void)weiboCell:(WeiboItemCell *)cell likeItAction:(WeiboInfo *)weiboInfo;
@end