//
//  WeiboActionCell.h
//  Floyd
//
//  Created by George She on 16/1/20.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "FDTableViewCell.h"
#import "WeiboInfo.h"
typedef NS_ENUM(NSInteger, FDActionMode) {
  FDActionMode_Comment,
  FDActionMode_Repost,
  FDActionMode_LikeIt
};

@protocol WeiboActionCellDelegate <NSObject>

-(void) actionModeChanged:(FDActionMode) actMode;

@end

@interface WeiboActionCellUserData : NSObject
@property(nonatomic, strong) WeiboInfo *weiboInfo;
@property(nonatomic, assign) FDActionMode curAction;
@property(nonatomic, weak) id<WeiboActionCellDelegate> delegate;
@end

@interface WeiboActionCell : FDTableViewCell
@property(nonatomic, strong) WeiboActionCellUserData *userData;

+ (NICellObject *)createObject:(id)_delegate userData:(id)_userData;
@end
