//
//  SinaNewsApi.h
//  Floyd
//
//  Created by admin on 16/1/8.
//  Copyright © 2016年 George She. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSSRoot.h"
#import "RSSChannelDetail.h"

@interface SinaRSSApi : NSObject
- (void)queryChannelsWithsuccess:(void (^)(RSSRoot *ret))successBlock
                              failed:(void (^)(NSError *error))failedBlock;

- (void)loadItemsWithUrl:(NSString *)url
                success:(void (^)(RSSChannelDetail *ret))successBlock
                 failed:(void (^)(NSError *error))failedBlock;
@end
