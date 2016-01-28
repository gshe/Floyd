//
//  QiniuFileUploaderViewController.m
//  Floyd
//
//  Created by George She on 16/1/21.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "QiniuFileUploaderViewController.h"
#import "qiniuSdk.h"
#import "SWGFileApi.h"

@interface QiniuFileUploaderViewController ()
@property(nonatomic, strong) QNUploadManager *upManager;
@property(nonatomic, strong) NSString *uploadToken;
@property(nonatomic, strong) UIButton *uploadButton;

@end

@implementation QiniuFileUploaderViewController
- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];
  self.edgesForExtendedLayout = UIRectEdgeNone;

  self.uploadButton = [[UIButton alloc] init];
  [self.uploadButton setTitle:@"Upload" forState:UIControlStateNormal];
  [self.uploadButton setTitleColor:[UIColor ex_blueTextColor]
                          forState:UIControlStateNormal];
  [self.uploadButton addTarget:self
                        action:@selector(startUpload:)
              forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:self.uploadButton];

  [self.uploadButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.top.equalTo(self.view).offset(15);
  }];

  NSError *errorNew = nil;
  QNFileRecorder *file = [QNFileRecorder
      fileRecorderWithFolder:[NSTemporaryDirectory()
                                 stringByAppendingString:@"qiniu"]
                       error:&errorNew];
  NSLog(@"recorder error %@", errorNew);
  _upManager = [[QNUploadManager alloc] initWithRecorder:file];
}

- (void)startUpload:(id)sender {
  [[SWGFileApi sharedAPI]
      uploadTokenGetWithCompletionBlock:^(SWGTokenInfo *output,
                                          NSError *error) {
        self.uploadToken = output.token;
        QNUploadOption *opt = [[QNUploadOption alloc] initWithMime:nil
            progressHandler:^(NSString *key, float percent) {

              NSLog(@"progress %f", percent);
            }
            params:nil
            checkCrc:NO
            cancellationSignal:^BOOL() {
              return NO;
            }];
        NSData *data =
            [@"Hello, World!" dataUsingEncoding:NSUTF8StringEncoding];
        [_upManager putData:data
                        key:@"你好2"
                      token:self.uploadToken
                   complete:^(QNResponseInfo *info, NSString *key,
                              NSDictionary *resp) {

                   } option:opt];
      }];
}
@end
