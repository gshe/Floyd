//
//  TextEditViewController.m
//  Floyd
//
//  Created by George She on 16/1/28.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "TextEditViewController.h"
@interface TextEditViewController ()
@property(nonatomic, strong) UITextField *textView;
@end

@implementation TextEditViewController
- (void)viewDidLoad {
  [super viewDidLoad];
  _textView = [UITextField new];
  _textView.text = self.oldText;
  _textView.placeholder = self.placeHolder;
  [self.view addSubview:_textView];

  [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(self.view).offset(15);
    make.top.equalTo(self.view).offset(15);
    make.height.mas_equalTo(200);
  }];
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
      initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                           target:self
                           action:@selector(rightBarButtonPressed:)];
}

- (void)rightBarButtonPressed:(id)sennder {
  if ([self.delegate respondsToSelector:@selector(TextEditVC:textChanged:)]) {
    [self.delegate TextEditVC:self textChanged:_textView.text];
  }

  [self.navigationController popViewControllerAnimated:YES];
}
@end
