//
//  AlbumInfoCell.h
//  Floyd
//
//  Created by George She on 16/1/29.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "FDTableViewCell.h"
#import "SWGPhotoInfo.h"

@interface PhotoInfoCellUserData : NSObject
@property(nonatomic, strong) SWGPhotoInfo *photo;
@end

@interface PhotoInfoCell : FDTableViewCell
@property(nonatomic, strong) PhotoInfoCellUserData *userData;

+ (NICellObject *)createObject:(id)_delegate userData:(id)_userData;
@end
