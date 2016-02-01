//
//  QiniuFileUploadManager.m
//  Floyd
//
//  Created by George She on 16/1/29.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "QiniuFileUploadManager.h"
#import "qiniuSdk.h"
#import "SWGIFileApi.h"

@interface QiniuFileUploadManager ()
@property(nonatomic, strong) QNUploadManager *upManager;
@end

@implementation QiniuFileUploadManager
- (instancetype)init {
  self = [super init];
  if (self) {
    NSError *errorNew = nil;
    QNFileRecorder *file = [QNFileRecorder
        fileRecorderWithFolder:[NSTemporaryDirectory()
                                   stringByAppendingString:@"qiniu"]
                         error:&errorNew];
    NSLog(@"recorder error %@", errorNew);
    _upManager = [[QNUploadManager alloc] initWithRecorder:file];
  }
  return self;
}

- (void)uploadImageToServce:(UIImage *)image
         withCompletedBlock:(uploadCompletionHandler)completedBlock {

  [[SWGIFileApi sharedAPI]
      uploadTokenGetWithCompletionBlock:^(SWGTokenInfo *output,
                                          NSError *error) {
        if (!error) {
          NSString *uploadToken = output.token;
          NSString *uuidKey = [self uuidImage];
          NSData *data = UIImagePNGRepresentation(image);
          [_upManager putData:data
                          key:uuidKey
                        token:uploadToken
                     complete:^(QNResponseInfo *info, NSString *key,
                                NSDictionary *resp) {
                       if ([info isOK]) {
                         if (completedBlock) {
                           completedBlock(key, resp[@"hash"], nil);
                         }
                       } else {
                         if (completedBlock) {
                           completedBlock(nil, nil, nil);
                         }
                       }
                     } option:nil];
        } else {
          if (completedBlock) {
            completedBlock(nil, nil, error);
          }
        }
      }];
}

- (NSString *)uuidImage {
  CFUUIDRef puuid = CFUUIDCreate(nil);
  CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
  NSString *result =
      (NSString *)CFBridgingRelease(CFStringCreateCopy(NULL, uuidString));
  CFRelease(puuid);
  CFRelease(uuidString);
  return [NSString stringWithFormat:@"%@.png", result];
}

@end
