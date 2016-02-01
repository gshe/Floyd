//
//  QiniuFileUploadManager.h
//  Floyd
//
//  Created by George She on 16/1/29.
//  Copyright © 2016年 George She. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^uploadCompletionHandler)(NSString *key, NSString *hash,
                                        NSError *error);

@interface QiniuFileUploadManager : NSObject
- (void)uploadImageToServce:(UIImage *)image
         withCompletedBlock:(uploadCompletionHandler)completedBlock;
@end
