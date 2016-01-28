//
//  WeiboUserCell.h
//  Floyd
//
//  Created by admin on 16/1/14.
//  Copyright © 2016年 George She. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FDTableViewCell.h"

@interface WeiboUserCellUserData : NSObject
@property(nonatomic, strong) WeiboUser *user;
@end

@interface WeiboUserCell : FDTableViewCell
@property(nonatomic, strong) WeiboUserCellUserData *userData;

+ (NICellObject *)createObject:(id)_delegate userData:(id)_userData;
@end
