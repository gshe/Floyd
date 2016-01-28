//
//  ForwardWeiboViewController.m
//  Floyd
//
//  Created by admin on 16/1/15.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "ForwardWeiboViewController.h"
#import "WeiboInfoManager.h"

@interface ForwardWeiboViewController () <UITextViewDelegate>
@property(nonatomic, strong) UITextView *contentText;
@property(nonatomic, strong) UILabel *textCountTip;
@property(nonatomic, strong) WeiboInfoManager *manager;
@end

@implementation ForwardWeiboViewController
- (void)viewDidLoad {
  [super viewDidLoad];
  self.manager = [[WeiboInfoManager alloc]
      initWithToken:[UserManager sharedInstance].weiboToken
          andUserId:[NSString
                        stringWithFormat:@"%lld", self.weiboInfo.user.userId]];
  self.title = @"转发微博";
  self.edgesForExtendedLayout = UIRectEdgeNone;
  [self loadUI];
}

- (void)loadUI {
  self.view.backgroundColor = [UIColor whiteColor];

  self.contentText = [UITextView new];
  self.contentText.layer.borderColor = [UIColor ex_blueTextColor].CGColor;
  self.contentText.layer.borderWidth = 1.0f;
  self.contentText.backgroundColor = [UIColor ex_separatorLineColor];
  self.contentText.delegate = self;

  self.textCountTip = [UILabel new];
  self.textCountTip.textColor = [UIColor greenColor];
  self.textCountTip.font = Font_12;
  self.textCountTip.textAlignment = NSTextAlignmentRight;

  [self.view addSubview:self.textCountTip];
  [self.view addSubview:self.contentText];

  [self.contentText mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.view).offset(15);
    make.right.equalTo(self.view).offset(-15);
    make.top.equalTo(self.view).offset(15);
    make.height.mas_equalTo(150);
  }];

  [self.textCountTip mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.contentText.mas_bottom).offset(5);
    make.right.equalTo(self.view.mas_right).offset(-15);
  }];

  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
      initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward
                           target:self
                           action:@selector(onForwardStatus:)];
}

- (void)onForwardStatus:(id)sender {
  NSString *content = self.contentText.text;
  [self.manager
      repostStatus:[NSString stringWithFormat:@"%lld", self.weiboInfo.weiboId]
      repostText:content
      success:^(BOOL ret) {
        [self.navigationController popViewControllerAnimated:YES];
      }
      failed:^(NSError *error) {
        [self showError:error];
      }];
}

#pragma UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
  self.textCountTip.text = [NSString
      stringWithFormat:@"你已经输入了 %zd 字符", textView.text.length];
}
@end
