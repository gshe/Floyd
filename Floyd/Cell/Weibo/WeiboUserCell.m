//
//  WeiboUserCell.m
//  Floyd
//
//  Created by admin on 16/1/14.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "WeiboUserCell.h"
#import "UIImageView+WebCache.h"

@implementation WeiboUserCellUserData
@end

@interface WeiboUserCell ()
@property(nonatomic, strong) UILabel *title;
@property(nonatomic, strong) UIImageView *avatarImage;
@end

@implementation WeiboUserCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.contentView.backgroundColor = [UIColor ex_globalBackgroundColor];

    self.title = [UILabel new];
    self.title.font = Font_S;
    self.title.textColor = [UIColor blueColor];
    self.title.textAlignment = NSTextAlignmentLeft;

    self.avatarImage = [[UIImageView alloc] init];
    self.avatarImage.contentMode = UIViewContentModeScaleAspectFill;
    self.avatarImage.clipsToBounds = YES;
    self.avatarImage.layer.cornerRadius = 44 / 2;
    self.avatarImage.layer.masksToBounds = YES;
    self.avatarImage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.avatarImage.layer.borderWidth = 2.0;
    self.avatarImage.layer.allowsEdgeAntialiasing = YES;

    [self.contentView addSubview:self.title];
    [self.contentView addSubview:self.avatarImage];

    [self makeConstraint];
  }
  return self;
}

- (void)makeConstraint {

  [self.avatarImage mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.equalTo(self.contentView);
    make.left.equalTo(self.contentView).offset(15);
    make.width.mas_equalTo(44);
    make.height.mas_equalTo(44);
  }];

  [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.equalTo(self.contentView);
    make.left.equalTo(self.avatarImage.mas_right).offset(15);
  }];
}

- (void)dealloc {
  self.userData = nil;
}

+ (CGFloat)heightForObject:(id)object
               atIndexPath:(NSIndexPath *)indexPath
                 tableView:(UITableView *)tableView {

  return 44;
}

- (BOOL)shouldUpdateCellWithObject:(NICellObject *)object {
  self.userData = (WeiboUserCellUserData *)object.userInfo;
  self.title.text = self.userData.user.name;
  [self.avatarImage
      sd_setImageWithURL:[NSURL
                             URLWithString:self.userData.user.profileImageUrl]
        placeholderImage:[UIImage imageNamed:@"avatar_user_man"]];
  return YES;
}

+ (NICellObject *)createObject:(id)_delegate userData:(id)_userData {
  WeiboUserCellUserData *userData = [[WeiboUserCellUserData alloc] init];
  NICellObject *cellObj =
      [[NICellObject alloc] initWithCellClass:[WeiboUserCell class]
                                     userInfo:userData];
  return cellObj;
}
@end
