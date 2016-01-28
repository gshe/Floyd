//
//  IndexInfoCell.h
//  Floyd
//
//  Created by admin on 16/1/7.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "FDTableViewCell.h"
#import "IndexModel.h"

@interface IndexInfoCellUserData : NSObject
@property(nonatomic, strong) IndexModel *index;
@end

@interface IndexInfoCell : FDTableViewCell
@property(nonatomic, strong) IndexInfoCellUserData *userData;

+ (NICellObject *)createObject:(id)_delegate userData:(id)_userData;
@end
