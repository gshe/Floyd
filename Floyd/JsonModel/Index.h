//
//  Index.h
//  Floyd
//
//  Created by admin on 16/1/7.
//  Copyright © 2016年 George She. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "IndexModel.h"

@interface Index : JSONModel
@property(nonatomic, strong) NSArray<IndexModel> *index;
@end
