//
//  AlbumInfoCell.h
//  Floyd
//
//  Created by George She on 16/1/29.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "FDTableViewCell.h"
#import "SWGAlbumInfo.h"

@interface AlbumInfoCellUserData : NSObject
@property(nonatomic, strong) SWGAlbumInfo *album;
@end

@interface AlbumInfoCell : FDTableViewCell
@property(nonatomic, strong) AlbumInfoCellUserData *userData;

+ (NICellObject *)createObject:(id)_delegate userData:(id)_userData;
@end
