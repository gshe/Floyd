//
//  FDWebViewController.m
//  Floyd
//
//  Created by admin on 16/1/8.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "FDWebViewController.h"
@interface FDWebViewController () <UIWebViewDelegate>
@property(nonatomic, strong) UIWebView *webView;
@property(nonatomic, strong) UIView *toolbar;
@property(nonatomic, strong) UIButton *goBackButton;
@property(nonatomic, strong) UIButton *goForwardButton;
@property(nonatomic, strong) UIButton *refreshButton;
@end

@implementation FDWebViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.webView = [[UIWebView alloc] init];
  self.webView.delegate = self;

  [self.view addSubview:self.webView];
  self.view.backgroundColor = [UIColor whiteColor];
  self.toolbar = [UIView new];
  self.toolbar.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:self.toolbar];
  [self.toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.view);
    make.right.equalTo(self.view);
    make.bottom.equalTo(self.view);
    make.height.mas_equalTo(44);
  }];

  [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.view);
    make.right.equalTo(self.view);
    make.top.equalTo(self.view);
    make.bottom.equalTo(self.toolbar.mas_top);
  }];

  self.goBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
  self.goForwardButton = [UIButton buttonWithType:UIButtonTypeCustom];
  self.refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
  [self.goBackButton setImage:[UIImage imageNamed:@"Browser_Icon_Backward"]
                     forState:UIControlStateNormal];
  [self.goBackButton addTarget:self
                        action:@selector(goBackPressed:)
              forControlEvents:UIControlEventTouchUpInside];
  [self.goForwardButton setImage:[UIImage imageNamed:@"Browser_Icon_Forward"]
                        forState:UIControlStateNormal];
  [self.goForwardButton addTarget:self
                           action:@selector(goForwardPressed:)
                 forControlEvents:UIControlEventTouchUpInside];
  [self.refreshButton setImage:[UIImage imageNamed:@"Browser_Icon_Refresh"]
                      forState:UIControlStateNormal];
  [self.refreshButton addTarget:self
                         action:@selector(refreshPressed:)
               forControlEvents:UIControlEventTouchUpInside];
  [self.toolbar addSubview:self.goBackButton];
  [self.toolbar addSubview:self.goForwardButton];
  [self.toolbar addSubview:self.refreshButton];

  [self.goBackButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.equalTo(self.toolbar);
    make.left.equalTo(self.toolbar).offset(15);
    make.width.mas_equalTo(44);
    make.height.mas_equalTo(44);
  }];

  [self.goForwardButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.equalTo(self.toolbar);
    make.left.equalTo(self.goBackButton.mas_right).offset(15);
    make.width.mas_equalTo(44);
    make.height.mas_equalTo(44);
  }];

  [self.refreshButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.equalTo(self.toolbar);
    make.left.equalTo(self.goForwardButton.mas_right).offset(15);
    make.width.mas_equalTo(44);
    make.height.mas_equalTo(44);
  }];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  NSURLRequest *request =
      [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
  [self.webView loadRequest:request];
}

- (void)goBackPressed:(id)sender {
  if ([self.webView canGoBack]) {
    [self.webView goBack];
  }
}

- (void)goForwardPressed:(id)sender {
  if ([self.webView canGoForward]) {
    [self.webView goForward];
  }
}

- (void)refreshPressed:(id)sender {
  [self.webView reload];
}

#pragma UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
  [MBProgressHUD showHUDAddedTo:self.webView animated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
  [MBProgressHUD hideAllHUDsForView:self.webView animated:YES];

  self.goBackButton.enabled = [self.webView canGoBack];
  self.goForwardButton.enabled = [self.webView canGoForward];
}

@end
