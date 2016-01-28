//
//  NewsCategoryModel.h
//  Floyd
//
//  Created by admin on 16/1/8.
//  Copyright © 2016年 George She. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol RSSSubChannel
@end

@interface RSSSubChannel : JSONModel
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *xmlUrl;
@property(nonatomic, strong) NSString *text;
@property(nonatomic, strong) NSString *htmlUrl;
@property(nonatomic, strong) NSString *type;
@end
