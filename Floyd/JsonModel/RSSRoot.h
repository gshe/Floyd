//
//  NewsCategory.h
//  Floyd
//
//  Created by admin on 16/1/8.
//  Copyright © 2016年 George She. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "RSSChannel.h"

@interface RSSRoot : JSONModel
@property(nonatomic, strong) NSArray<RSSChannel> *channel;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *meta;
@property(nonatomic, strong) NSString *version;
@end
