//
//  CommentWeiboViewController.m
//  Floyd
//
//  Created by admin on 16/1/15.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "WeiboDetailViewController.h"
#import "WeiboItemCell.h"
#import "MJRefresh.h"
#import "RepostAndCommentViewController.h"
#import "UIImageView+WebCache.h"

@interface WeiboDetailViewController ()
@property(nonatomic, strong) RepostAndCommentViewController *repostAndCommentVC;
@property(nonatomic, strong) UILabel *userName;
@property(nonatomic, strong) UILabel *dateAndFrom;
@property(nonatomic, strong) UIImageView *avatarImage;
@property(nonatomic, strong) UILabel *desc;
@property(nonatomic, strong) UIView *picturesView;
@property(nonatomic, strong) UIView *retweetedStatusContentView;
@property(nonatomic, strong) UILabel *retweetedStatusDesc;
@property(nonatomic, strong) UIView *retweetedStatusPicView;
@end

@implementation WeiboDetailViewController
- (void)viewDidLoad {
  [super viewDidLoad];
  self.edgesForExtendedLayout = UIRectEdgeNone;

  self.title = @"微博详情";
  self.view.backgroundColor = [UIColor whiteColor];

  [self loadUI];
  [self loadRepostAndCommentUI];
  [self makeConstraint];
  [self setData];
}

- (void)loadUI {
  self.avatarImage = [[UIImageView alloc] init];
  self.avatarImage.contentMode = UIViewContentModeScaleAspectFill;
  self.avatarImage.clipsToBounds = YES;
  self.avatarImage.layer.cornerRadius = 44 / 2;
  self.avatarImage.layer.masksToBounds = YES;
  self.avatarImage.layer.borderColor = [UIColor whiteColor].CGColor;
  self.avatarImage.layer.borderWidth = 2.0;
  self.avatarImage.layer.allowsEdgeAntialiasing = YES;

  self.userName = [UILabel new];
  self.userName.font = Font_15_B;
  self.userName.textColor = [UIColor ex_mainTextColor];
  self.userName.textAlignment = NSTextAlignmentLeft;

  self.dateAndFrom = [UILabel new];
  self.dateAndFrom.font = Font_15;
  self.dateAndFrom.textColor = [UIColor ex_subTextColor];
  self.dateAndFrom.textAlignment = NSTextAlignmentLeft;

  self.desc = [UILabel new];
  self.desc.font = Font_15;
  self.desc.textColor = [UIColor ex_mainTextColor];
  self.desc.numberOfLines = 0;
  self.desc.lineBreakMode = NSLineBreakByTruncatingTail;
  self.desc.textAlignment = NSTextAlignmentLeft;
  self.picturesView = [UIView new];
  self.picturesView.backgroundColor = [UIColor whiteColor];

  self.retweetedStatusContentView = [UIView new];
  self.retweetedStatusContentView.backgroundColor =
      [UIColor ex_globalBackgroundColor];

  self.retweetedStatusDesc = [UILabel new];
  self.retweetedStatusDesc.font = Font_15;
  self.retweetedStatusDesc.textColor = [UIColor ex_subTextColor];
  self.retweetedStatusDesc.numberOfLines = 0;
  self.retweetedStatusDesc.lineBreakMode = NSLineBreakByTruncatingTail;
  self.retweetedStatusDesc.textAlignment = NSTextAlignmentLeft;

  self.retweetedStatusPicView = [UIView new];
  self.picturesView.backgroundColor = [UIColor whiteColor];

  [self.retweetedStatusContentView addSubview:self.retweetedStatusDesc];
  [self.retweetedStatusContentView addSubview:self.retweetedStatusPicView];

  [self.view addSubview:self.userName];
  [self.view addSubview:self.dateAndFrom];
  [self.view addSubview:self.avatarImage];
  [self.view addSubview:self.desc];
  [self.view addSubview:self.picturesView];
  [self.view addSubview:self.retweetedStatusContentView];
}

- (void)makeConstraint {
  [self.avatarImage mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.view).offset(15);
    make.top.equalTo(self.view).offset(5);
    make.width.mas_equalTo(44);
    make.height.mas_equalTo(44);
  }];

  [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.avatarImage.mas_right).offset(15);
    make.top.equalTo(self.avatarImage);

  }];

  [self.dateAndFrom mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.avatarImage.mas_right).offset(15);
    make.top.equalTo(self.userName.mas_bottom).offset(5);
    make.top.lessThanOrEqualTo(self.view.mas_right).offset(-15);
  }];

  [self.desc mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.avatarImage.mas_bottom).offset(5);
    make.left.equalTo(self.view).offset(15);
    make.right.lessThanOrEqualTo(self.view).offset(-15);
  }];

  if (self.weiboInfo.pic_urls.count > 0) {
    CGFloat height =
        [[WeiboItemCell class] getPictureViewHeight:kScreenWidth
                                          weiboInfo:self.weiboInfo];
    [self.picturesView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(self.view).offset(15);
      make.top.equalTo(self.desc.mas_bottom).offset(5);
      make.height.mas_equalTo(height);
      make.right.equalTo(self.view).offset(-15);
    }];
  } else {
    [self.picturesView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(self.view).offset(15);
      make.top.equalTo(self.desc.mas_bottom).offset(5);
      make.height.mas_equalTo(0);
      make.right.equalTo(self.view).offset(-15);
    }];
  }

  if (self.weiboInfo.retweeted_status) {
    [self.retweetedStatusContentView
        mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.equalTo(self.view);
          make.right.equalTo(self.view);
          make.top.equalTo(self.picturesView.mas_bottom).offset(5);
          make.height.mas_equalTo([self getRetweetedStatusHeight]);
        }];

    [self.retweetedStatusDesc mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(self.retweetedStatusContentView).offset(15);
      make.right.lessThanOrEqualTo(self.retweetedStatusContentView).offset(-15);
      make.top.equalTo(self.retweetedStatusContentView).offset(5);
    }];

    if (self.weiboInfo.retweeted_status.pic_urls.count > 0) {
      CGFloat height = [[WeiboItemCell class]
          getPictureViewHeight:kScreenWidth
                     weiboInfo:self.weiboInfo.retweeted_status];
      [self.retweetedStatusPicView
          mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.retweetedStatusContentView).offset(15);
            make.top.equalTo(self.retweetedStatusDesc.mas_bottom).offset(5);
            make.height.mas_equalTo(height);
            make.right.equalTo(self.retweetedStatusContentView).offset(-15);
          }];
    }
  } else {
    [self.retweetedStatusContentView
        mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.equalTo(self.view);
          make.right.equalTo(self.view);
          make.top.equalTo(self.picturesView.mas_bottom);
          make.height.mas_equalTo(0);
        }];
  }

  [self.repostAndCommentVC.view
      mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.retweetedStatusContentView.mas_bottom).offset(5);
        make.bottom.equalTo(self.view);
      }];
}

- (CGFloat)getRetweetedStatusHeight {
  CGFloat maxWidth = self.view.frame.size.width - 30;
  CGFloat height = 0;

  if (self.weiboInfo.retweeted_status) {
    NSString *desc = [NSString
        stringWithFormat:@"%@:%@", self.weiboInfo.retweeted_status.user.name,
                         self.weiboInfo.retweeted_status.text];
    height += [desc lineBreakSizeOfStringwithFont:Font_15
                                         maxwidth:maxWidth
                                    lineBreakMode:NSLineBreakByWordWrapping];
    height += 10;
    if (self.weiboInfo.retweeted_status.pic_urls.count > 0) {
      height += [[WeiboItemCell class]
          getPictureViewHeight:kScreenWidth
                     weiboInfo:self.weiboInfo.retweeted_status];
      height += 10;
    }
  }
  return height;
}

- (void)loadRepostAndCommentUI {
  self.repostAndCommentVC =
      [[RepostAndCommentViewController alloc] initWithNibName:nil bundle:nil];
  self.repostAndCommentVC.weiboInfo = self.weiboInfo;
  [self.view addSubview:self.repostAndCommentVC.view];
  [self.repostAndCommentVC didMoveToParentViewController:self];
}

- (void)setData {
  self.userName.text = self.weiboInfo.user.name;
  [self.avatarImage
      sd_setImageWithURL:[NSURL URLWithString:self.weiboInfo.user
                                                  .profile_image_url]
        placeholderImage:[UIImage imageNamed:@"avatar_user_man"]];
  NSString *dateAndFromStr =
      [NSString stringWithFormat:@"%@ %@", [self.weiboInfo getCreatedAtString],
                                 self.weiboInfo.source];
  NSAttributedString *attrStr = [[NSAttributedString alloc]
            initWithData:[dateAndFromStr
                             dataUsingEncoding:NSUnicodeStringEncoding]
                 options:@{
                   NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType
                 }
      documentAttributes:nil
                   error:nil];
  NSString *desc = [NSString
      stringWithFormat:@"%@:%@", self.weiboInfo.retweeted_status.user.name,
                       self.weiboInfo.retweeted_status.text];
  self.retweetedStatusDesc.text = desc;

  [[WeiboItemCell class] fillPictureView:kScreenWidth
                                     pic:self.picturesView
                               weiboInfo:self.weiboInfo];
  [[WeiboItemCell class] fillPictureView:kScreenWidth
                                     pic:self.retweetedStatusPicView
                               weiboInfo:self.weiboInfo.retweeted_status];
  self.dateAndFrom.attributedText = attrStr;
  self.desc.text = self.weiboInfo.text;
}

@end
