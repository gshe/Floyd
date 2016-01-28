//
//  NewsChannel.h
//  Floyd
//
//  Created by admin on 16/1/8.
//  Copyright © 2016年 George She. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "RSSSubChannel.h"
@protocol RSSChannel
@end

@interface RSSChannel : JSONModel
@property(nonatomic, strong) NSArray<RSSSubChannel> *subChannel;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *text;
@end
