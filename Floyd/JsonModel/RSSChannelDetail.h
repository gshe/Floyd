//
//  NewsChannel.h
//  Floyd
//
//  Created by admin on 16/1/8.
//  Copyright © 2016年 George She. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "RSSItemModel.h"

@interface RSSChannelDetail : JSONModel
@property(nonatomic, strong) NSArray<RSSItemModel> *item;
@property(nonatomic, strong) NSString *copyright;
@property(nonatomic, strong) NSString *channelDesc;
@end
