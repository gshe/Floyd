//
//  WeiboCommentCell.m
//  Floyd
//
//  Created by admin on 16/1/15.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "WeiboCommentCell.h"
#import "UIImageView+WebCache.h"

@implementation WeiboCommentCellUserData
@end

@interface WeiboCommentCell ()
@property(nonatomic, strong) UILabel *userName;
@property(nonatomic, strong) UILabel *desc;
@property(nonatomic, strong) UILabel *dateAndFrom;
@property(nonatomic, strong) UIImageView *avatarImage;
@end

@implementation WeiboCommentCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.contentView.backgroundColor = [UIColor whiteColor];

    self.userName = [UILabel new];
    self.userName.font = Font_15_B;
    self.userName.textColor = [UIColor ex_mainTextColor];
    self.userName.textAlignment = NSTextAlignmentLeft;

    self.avatarImage = [[UIImageView alloc] init];
    self.avatarImage.contentMode = UIViewContentModeScaleAspectFill;
    self.avatarImage.clipsToBounds = YES;
    self.avatarImage.layer.cornerRadius = 44 / 2;
    self.avatarImage.layer.masksToBounds = YES;
    self.avatarImage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.avatarImage.layer.borderWidth = 2.0;
    self.avatarImage.layer.allowsEdgeAntialiasing = YES;

    self.desc = [UILabel new];
    self.desc.font = Font_15;
    self.desc.textColor = [UIColor ex_subTextColor];
    self.desc.numberOfLines = 0;
    self.desc.lineBreakMode = NSLineBreakByWordWrapping;
    self.desc.textAlignment = NSTextAlignmentLeft;

    self.dateAndFrom = [UILabel new];
    self.dateAndFrom.font = Font_15;
    self.dateAndFrom.textColor = [UIColor ex_subTextColor];
    self.dateAndFrom.textAlignment = NSTextAlignmentLeft;

    self.clipsToBounds = YES;
    [self.contentView addSubview:self.avatarImage];
    [self.contentView addSubview:self.userName];
    [self.contentView addSubview:self.desc];
    [self.contentView addSubview:self.dateAndFrom];

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
}

- (void)dealloc {
  self.userData = nil;
}

+ (CGFloat)heightForObject:(id)object
               atIndexPath:(NSIndexPath *)indexPath
                 tableView:(UITableView *)tableView {
  NICellObject *obj = object;
  WeiboCommentCellUserData *userData = (WeiboCommentCellUserData *)obj.userInfo;
  CGFloat maxWidth = tableView.frame.size.width - 30;

  CGFloat height = [userData.weiboComment.text
      lineBreakSizeOfStringwithFont:Font_15
                           maxwidth:maxWidth
                      lineBreakMode:NSLineBreakByWordWrapping];

  return 61 + height;
}

- (BOOL)shouldUpdateCellWithObject:(NICellObject *)object {
  self.userData = (WeiboCommentCellUserData *)object.userInfo;
  self.userName.text = self.userData.weiboComment.user.name;
  [self.avatarImage
      sd_setImageWithURL:[NSURL URLWithString:self.userData.weiboComment.user
                                                  .profile_image_url]
        placeholderImage:[UIImage imageNamed:@"avatar_user_man"]];
  NSString *dateAndFromStr = [NSString
      stringWithFormat:@"%@ %@",
                       [self.userData.weiboComment getCreatedAtString],
                       self.userData.weiboComment.source];
  NSAttributedString *attrStr = [[NSAttributedString alloc]
            initWithData:[dateAndFromStr
                             dataUsingEncoding:NSUnicodeStringEncoding]
                 options:@{
                   NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType
                 }
      documentAttributes:nil
                   error:nil];
  self.dateAndFrom.attributedText = attrStr;
  self.desc.text = self.userData.weiboComment.text;
  return YES;
}

+ (NICellObject *)createObject:(id)_delegate userData:(id)_userData {
  WeiboCommentCellUserData *userData = [[WeiboCommentCellUserData alloc] init];
  NICellObject *cellObj =
      [[NICellObject alloc] initWithCellClass:[WeiboCommentCell class]
                                     userInfo:userData];
  return cellObj;
}
@end
