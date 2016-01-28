//
//  IndexModel.h
//  Floyd
//
//  Created by admin on 16/1/7.
//  Copyright © 2016年 George She. All rights reserved.
//

#import <JSONModel/JSONModel.h>
//"i1":"ct",
//"i2":"穿衣指数", “i3”:”” , "i4":"冷",
@protocol IndexModel
@end

@interface IndexModel : JSONModel
@property (nonatomic, strong) NSString *indexShortName;
@property (nonatomic, strong) NSString *indexNameCN;
@property (nonatomic, strong) NSString *indexNameAlias;
@property (nonatomic, strong) NSString *indexLevel;
@property (nonatomic, strong) NSString *indexDesc;
@end
