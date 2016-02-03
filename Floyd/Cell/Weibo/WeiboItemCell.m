//
//  WeiboItemCell.m
//  Floyd
//
//  Created by admin on 16/1/15.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "WeiboItemCell.h"
#import "UIImageView+WebCache.h"
#define TAG_BASE 3000

@implementation WeiboItemCellUserData
@end

@interface WeiboItemCell ()
@property(nonatomic, strong) UILabel *userName;
@property(nonatomic, strong) UILabel *dateAndFrom;
@property(nonatomic, strong) UIImageView *avatarImage;
@property(nonatomic, strong) UILabel *desc;
@property(nonatomic, strong) UIView *actionLine;
@property(nonatomic, strong) UIView *actionView;
@property(nonatomic, strong) UIButton *actionForward;
@property(nonatomic, strong) UIButton *actionCommet;
@property(nonatomic, strong) UIButton *actionLikeIt;
@property(nonatomic, strong) UIView *picturesView;
@property(nonatomic, assign) CGFloat oneThirdWidth;

@property(nonatomic, strong) UIView *retweetedStatusContentView;
@property(nonatomic, strong) UILabel *retweetedStatusDesc;
@property(nonatomic, strong) UIView *retweetedStatusPicView;
@end

@implementation WeiboItemCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {

    self.contentView.backgroundColor = [UIColor whiteColor];

    self.oneThirdWidth = kScreenWidth / 3;

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

    self.actionView = [UIView new];
    self.actionView.backgroundColor = [UIColor ex_globalBackgroundColor];

    self.actionLine = [UIView new];
    self.actionLine.backgroundColor = [UIColor whiteColor];

    self.actionForward = [UIButton buttonWithType:UIButtonTypeCustom];
    self.actionForward.titleLabel.font = Font_15;
    [self.actionForward setTitle:@"转发" forState:UIControlStateNormal];
    [self.actionForward setTitleColor:[UIColor ex_subTextColor]
                             forState:UIControlStateNormal];
    [self.actionForward addTarget:self
                           action:@selector(forwardButtonPressed:)
                 forControlEvents:UIControlEventTouchUpInside];

    self.actionCommet = [UIButton new];
    self.actionCommet.titleLabel.font = Font_15;
    [self.actionCommet setTitle:@"评论" forState:UIControlStateNormal];
    [self.actionCommet setTitleColor:[UIColor ex_subTextColor]
                            forState:UIControlStateNormal];
    [self.actionCommet addTarget:self
                          action:@selector(commentButtonPressed:)
                forControlEvents:UIControlEventTouchUpInside];

    self.actionLikeIt = [UIButton new];
    self.actionLikeIt.titleLabel.font = Font_15;
    [self.actionLikeIt setTitle:@"赞" forState:UIControlStateNormal];
    [self.actionLikeIt setTitleColor:[UIColor ex_subTextColor]
                            forState:UIControlStateNormal];
    [self.actionLikeIt addTarget:self
                          action:@selector(likeItButtonPressed:)
                forControlEvents:UIControlEventTouchUpInside];

    [self.actionView addSubview:self.actionLine];
    [self.actionView addSubview:self.actionForward];
    [self.actionView addSubview:self.actionCommet];
    [self.actionView addSubview:self.actionLikeIt];

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
    self.actionLine.backgroundColor = [UIColor whiteColor];

    [self.retweetedStatusContentView addSubview:self.retweetedStatusDesc];
    [self.retweetedStatusContentView addSubview:self.retweetedStatusPicView];

    [self.contentView addSubview:self.userName];
    [self.contentView addSubview:self.dateAndFrom];
    [self.contentView addSubview:self.avatarImage];
    [self.contentView addSubview:self.desc];
    [self.contentView addSubview:self.picturesView];
    [self.contentView addSubview:self.retweetedStatusContentView];
    [self.contentView addSubview:self.actionView];
    self.clipsToBounds = YES;
    [self makeConstraint];
  }
  return self;
}

- (void)makeConstraint {
  [self.avatarImage mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.contentView).offset(15);
    make.top.equalTo(self.contentView).offset(5);
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
    make.top.lessThanOrEqualTo(self.contentView.mas_right).offset(-15);
  }];

  [self.desc mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.avatarImage.mas_bottom).offset(5);
    make.left.equalTo(self.contentView).offset(15);
    make.right.lessThanOrEqualTo(self.contentView).offset(-15);
  }];

  [self.picturesView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.contentView).offset(15);
    make.top.equalTo(self.desc.mas_bottom).offset(5);
    make.height.mas_equalTo(1);
    make.right.equalTo(self.contentView).offset(-15);
  }];

  [self.actionView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(self.contentView);
    make.bottom.equalTo(self.contentView);
    make.height.mas_equalTo(40);

  }];
  [self.actionLine mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(self.contentView);
    make.top.equalTo(self.actionView);
    make.height.mas_equalTo(0.5);

  }];
  [self.actionForward mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.equalTo(self.actionView);
    make.left.equalTo(self.actionView).offset(15);
  }];

  [self.actionCommet mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.equalTo(self.actionView);
    make.left.equalTo(self.actionView).offset(self.oneThirdWidth + 15);
  }];

  [self.actionLikeIt mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.equalTo(self.actionView);
    make.left.equalTo(self.actionView).offset(2 * self.oneThirdWidth + 15);
  }];
}

- (void)dealloc {
  self.userData = nil;
}

- (void)prepareForReuse {
  [super prepareForReuse];

  self.desc.text = nil;
  self.avatarImage.image = nil;
  self.dateAndFrom.attributedText = nil;
  for (UIView *v in self.picturesView.subviews) {
    if ([v isKindOfClass:[UIImageView class]]) {
      UIImageView *imgView = (UIImageView *)v;
      [imgView sd_cancelCurrentImageLoad];
      [v removeFromSuperview];
    }
  }

  for (UIView *v in self.retweetedStatusPicView.subviews) {
    if ([v isKindOfClass:[UIImageView class]]) {
      UIImageView *imgView = (UIImageView *)v;
      [imgView sd_cancelCurrentImageLoad];
      [v removeFromSuperview];
    }
  }
  self.picturesView.frame = CGRectZero;
  self.retweetedStatusPicView.frame = CGRectZero;
  [self setNeedsLayout];
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)updateConstraints {
  [super updateConstraints];

  if (self.userData.weiboInfo.pic_urls.count > 0) {
    CGFloat height =
        [[self class] getPictureViewHeight:kScreenWidth
                                 weiboInfo:self.userData.weiboInfo];
    [self.picturesView mas_remakeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(self.contentView).offset(15);
      make.top.equalTo(self.desc.mas_bottom).offset(5);
      make.height.mas_equalTo(height);
      make.right.equalTo(self.contentView).offset(-15);
    }];
  } else {
    [self.picturesView mas_remakeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(self.contentView).offset(15);
      make.top.equalTo(self.desc.mas_bottom).offset(5);
      make.height.mas_equalTo(1);
      make.right.equalTo(self.contentView).offset(-15);
    }];
  }

  if (self.userData.weiboInfo.retweeted_status) {
    [self.retweetedStatusContentView
        mas_remakeConstraints:^(MASConstraintMaker *make) {
          make.left.equalTo(self.contentView);
          make.right.equalTo(self.contentView);
          make.top.equalTo(self.picturesView.mas_bottom).offset(5);
          make.bottom.equalTo(self.actionView).offset(5);
        }];

    [self.retweetedStatusDesc
        mas_remakeConstraints:^(MASConstraintMaker *make) {
          make.left.equalTo(self.retweetedStatusContentView).offset(15);
          make.right.lessThanOrEqualTo(self.retweetedStatusContentView)
              .offset(-15);
          make.top.equalTo(self.retweetedStatusContentView).offset(5);
        }];

    if (self.userData.weiboInfo.retweeted_status.pic_urls.count > 0) {
      CGFloat height =
          [[self class] getPictureViewHeight:kScreenWidth
                                   weiboInfo:self.userData.weiboInfo];
      [self.retweetedStatusPicView
          mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.retweetedStatusContentView).offset(15);
            make.top.equalTo(self.retweetedStatusDesc.mas_bottom).offset(5);
            make.height.mas_equalTo(height);
            make.right.equalTo(self.retweetedStatusContentView).offset(-15);
          }];
    } else {
      [self.retweetedStatusPicView
          mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.retweetedStatusContentView).offset(15);
            make.top.equalTo(self.retweetedStatusDesc.mas_bottom).offset(5);
            make.height.mas_equalTo(1);
            make.right.equalTo(self.retweetedStatusContentView).offset(-15);
          }];
    }
  }
}

+ (CGFloat)heightForObject:(id)object
               atIndexPath:(NSIndexPath *)indexPath
                 tableView:(UITableView *)tableView {
  CGFloat height = 64;
  NICellObject *obj = object;
  WeiboItemCellUserData *userData = (WeiboItemCellUserData *)obj.userInfo;
  CGFloat maxWidth = tableView.frame.size.width - 30;

  height += [userData.weiboInfo.text
      lineBreakSizeOfStringwithFont:Font_15
                           maxwidth:maxWidth
                      lineBreakMode:NSLineBreakByWordWrapping];
  if (userData.weiboInfo.pic_urls.count > 0) {
    height += [[WeiboItemCell class] getPictureViewHeight:kScreenWidth
                                                weiboInfo:userData.weiboInfo];
    height += 10;
  }
  if (userData.weiboInfo.retweeted_status) {
    NSString *desc =
        [NSString stringWithFormat:@"%@:%@", userData.weiboInfo.retweeted_status
                                                 .user.name,
                                   userData.weiboInfo.retweeted_status.text];
    height += [desc lineBreakSizeOfStringwithFont:Font_15
                                         maxwidth:maxWidth
                                    lineBreakMode:NSLineBreakByWordWrapping];
    height += 10;
    if (userData.weiboInfo.retweeted_status.pic_urls.count > 0) {
      height += [[WeiboItemCell class]
          getPictureViewHeight:kScreenWidth
                     weiboInfo:userData.weiboInfo.retweeted_status];
      height += 10;
    }
  }
  if (userData.hiddenAction) {

  } else {
    height += 40;
  }
  return height;
}

- (BOOL)shouldUpdateCellWithObject:(NICellObject *)object {
  self.userData = (WeiboItemCellUserData *)object.userInfo;
  self.userName.text = self.userData.weiboInfo.user.name;
  [self.avatarImage
      sd_setImageWithURL:[NSURL URLWithString:self.userData.weiboInfo.user
                                                  .profile_image_url]
        placeholderImage:[UIImage imageNamed:@"avatar_user_man"]];
  NSString *dateAndFromStr = [NSString
      stringWithFormat:@"%@ %@", [self.userData.weiboInfo getCreatedAtString],
                       self.userData.weiboInfo.source];
  NSAttributedString *attrStr = [[NSAttributedString alloc]
            initWithData:[dateAndFromStr
                             dataUsingEncoding:NSUnicodeStringEncoding]
                 options:@{
                   NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType
                 }
      documentAttributes:nil
                   error:nil];
  if (self.userData.weiboInfo.retweeted_status) {
    NSString *desc = [NSString
        stringWithFormat:@"%@:%@",
                         self.userData.weiboInfo.retweeted_status.user.name,
                         self.userData.weiboInfo.retweeted_status.text];
    self.retweetedStatusDesc.text = desc;
    self.retweetedStatusContentView.hidden = NO;
  } else {
    self.retweetedStatusContentView.hidden = YES;
  }

  [[self class] fillPictureView:kScreenWidth
                            pic:self.picturesView
                      weiboInfo:self.userData.weiboInfo];
  [[self class] fillPictureView:kScreenWidth
                            pic:self.retweetedStatusPicView
                      weiboInfo:self.userData.weiboInfo.retweeted_status];
  self.dateAndFrom.attributedText = attrStr;
  self.desc.text = self.userData.weiboInfo.text;
  NSString *title = [NSString
      stringWithFormat:@"转发 %zd", self.userData.weiboInfo.reposts_count];
  [self.actionForward setTitle:title forState:UIControlStateNormal];
  title = [NSString
      stringWithFormat:@"评论 %zd", self.userData.weiboInfo.comments_count];
  [self.actionCommet setTitle:title forState:UIControlStateNormal];
  title = [NSString
      stringWithFormat:@"点赞 %zd", self.userData.weiboInfo.attitudes_count];
  [self.actionLikeIt setTitle:title forState:UIControlStateNormal];
  if (self.userData.hiddenAction) {
    self.actionView.hidden = YES;
  } else {
    self.actionView.hidden = NO;
  }
  [self setNeedsUpdateConstraints];
  return YES;
}

+ (NICellObject *)createObject:(id)_delegate userData:(id)_userData {
  WeiboItemCellUserData *userData = [[WeiboItemCellUserData alloc] init];
  NICellObject *cellObj =
      [[NICellObject alloc] initWithCellClass:[WeiboItemCell class]
                                     userInfo:userData];
  return cellObj;
}

+ (CGFloat)getPictureViewHeight:(CGFloat)contentWidth
                      weiboInfo:(WeiboInfo *)weiboInfo {
  CGFloat oneWidth = (contentWidth - 2 * 7 - 30) / 3;
  if (!weiboInfo || weiboInfo.pic_urls.count == 0) {
    return 0;
  }

  CGFloat height = 0;
  switch (weiboInfo.pic_urls.count) {
  case 1:
    height = 150;
    break;
  case 2:
  case 3:
    height = oneWidth;
    break;
  case 4:
  case 5:
  case 6:
    height = oneWidth * 2 + 7;
    break;
  case 7:
  case 8:
  case 9:
    height = oneWidth * 3 + 7 * 2;
    break;
  default:
    height = oneWidth * 3 + 7 * 2;

    break;
  }
  return height;
}

+ (void)fillPictureView:(CGFloat)contentWidth
                    pic:(UIView *)picContentView
              weiboInfo:(WeiboInfo *)wbInfo {
  CGFloat oneWidth = (contentWidth - 2 * 7 - 30) / 3;
  NSInteger totalCount = wbInfo.pic_urls.count;
  if (totalCount == 0) {
    return;
  }

  if (totalCount == 1) {
    UIImageView *imageView = [[UIImageView alloc]
        initWithFrame:CGRectMake(0, 0, contentWidth - 30, 150)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.tag = TAG_BASE;
    [picContentView addSubview:imageView];
  } else {
    for (NSInteger index = 0; index < 3; index++) {
      UIImageView *imageView = [[UIImageView alloc]
          initWithFrame:CGRectMake(index * oneWidth + index * 7, 0, oneWidth,
                                   oneWidth)];
      imageView.contentMode = UIViewContentModeScaleAspectFit;
      imageView.tag = TAG_BASE + index;
      [picContentView addSubview:imageView];
    }

    if (totalCount > 3) {
      for (NSInteger index = 0; index < 3; index++) {
        UIImageView *imageView = [[UIImageView alloc]
            initWithFrame:CGRectMake(index * oneWidth + index * 7, oneWidth + 7,
                                     oneWidth, oneWidth)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.tag = TAG_BASE + 3 + index;
        [picContentView addSubview:imageView];
      }
    }
    if (totalCount > 6) {
      for (NSInteger index = 0; index < 3; index++) {
        UIImageView *imageView = [[UIImageView alloc]
            initWithFrame:CGRectMake(index * oneWidth + index * 7,
                                     (126 + 7) * 2, oneWidth, oneWidth)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.tag = TAG_BASE + 6 + index;
        [picContentView addSubview:imageView];
      }
    }
  }

  if (wbInfo.pic_urls.count == 1 && wbInfo.bmiddle_pic) {
    NSInteger imgTag = TAG_BASE;
    UIImageView *imgView = [picContentView viewWithTag:imgTag];
    if ([imgView isKindOfClass:[UIImageView class]]) {
      [imgView sd_setImageWithURL:[NSURL URLWithString:wbInfo.bmiddle_pic]
                 placeholderImage:[UIImage imageNamed:@"img_lose"]];
    }
  } else {
    for (NSInteger index = 0; index < wbInfo.pic_urls.count; index++) {
      NSInteger imgTag = TAG_BASE + index;
      UIImageView *imgView = [picContentView viewWithTag:imgTag];
      if ([imgView isKindOfClass:[UIImageView class]]) {
        [imgView sd_setImageWithURL:[NSURL URLWithString:wbInfo.pic_urls[index][
                                                             @"thumbnail_pic"]]
                   placeholderImage:[UIImage imageNamed:@"img_lose"]];
      }
    }
  }
}

#pragma Action
- (void)forwardButtonPressed:(id)sender {
  if ([self.userData.delegate
          respondsToSelector:@selector(weiboCell:forwordAction:)]) {
    [self.userData.delegate weiboCell:self
                        forwordAction:self.userData.weiboInfo];
  }
}

- (void)commentButtonPressed:(id)sender {
  if ([self.userData.delegate
          respondsToSelector:@selector(weiboCell:commentAction:)]) {
    [self.userData.delegate weiboCell:self
                        commentAction:self.userData.weiboInfo];
  }
}

- (void)likeItButtonPressed:(id)sender {
  if ([self.userData.delegate
          respondsToSelector:@selector(weiboCell:likeItAction:)]) {
    [self.userData.delegate weiboCell:self
                         likeItAction:self.userData.weiboInfo];
  }
}

@end
