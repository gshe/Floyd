//
//  AlbumInfoCell.m
//  Floyd
//
//  Created by George She on 16/1/29.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "PhotoInfoCell.h"
#import "UIImageView+WebCache.h"

@implementation PhotoInfoCellUserData
@end

@interface PhotoInfoCell ()
@property(nonatomic, strong) UIImageView *coverImage;
@property(nonatomic, strong) UILabel *albumName;
@property(nonatomic, strong) UILabel *albumDesc;
@end

@implementation PhotoInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor ex_globalBackgroundColor];
    self.albumName = [UILabel new];
    self.albumName.font = [UIFont systemFontOfSize:20];
    self.albumName.textColor = [UIColor ex_mainTextColor];
    self.albumName.textAlignment = NSTextAlignmentCenter;

    self.albumDesc = [UILabel new];
    self.albumDesc.font = [UIFont systemFontOfSize:15];
    self.albumDesc.textColor = [UIColor ex_subTextColor];
    self.albumDesc.textAlignment = NSTextAlignmentCenter;

    self.coverImage = [UIImageView new];
    self.coverImage.contentMode = UIViewContentModeScaleToFill;
    [self.contentView addSubview:self.coverImage];
    [self.contentView addSubview:self.albumName];
    [self.contentView addSubview:self.albumDesc];
    self.clipsToBounds = YES;
    [self makeConstraints];
  }
  return self;
}

- (void)makeConstraints {
  [self.coverImage mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.contentView).offset(15);
    make.top.equalTo(self.contentView).offset(15);
    make.height.mas_equalTo(64);
    make.width.mas_equalTo(64);
  }];

  [self.albumName mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.coverImage.mas_right).offset(15);
    make.right.lessThanOrEqualTo(self.contentView.mas_right).offset(-15);
    make.top.equalTo(self.coverImage);
  }];

  [self.albumDesc mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.coverImage.mas_right).offset(15);
    make.right.lessThanOrEqualTo(self.contentView.mas_right).offset(-15);
    make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
  }];
}

- (void)dealloc {
  self.userData = nil;
}

+ (CGFloat)heightForObject:(id)object
               atIndexPath:(NSIndexPath *)indexPath
                 tableView:(UITableView *)tableView {
  return 86;
}

- (BOOL)shouldUpdateCellWithObject:(NICellObject *)object {
  self.userData = (PhotoInfoCellUserData *)object.userInfo;
  self.albumName.text = self.userData.photo.name;
  self.albumDesc.text = self.userData.photo.desc;
  NSString *url = QINIU_FILE_URL_MEDIUM(self.userData.photo.url);
  [self.coverImage sd_setImageWithURL:[NSURL URLWithString:url]
                     placeholderImage:[UIImage imageNamed:@"img_lose"]];
  return YES;
}

+ (NICellObject *)createObject:(id)_delegate userData:(id)_userData {
  PhotoInfoCellUserData *userData = [[PhotoInfoCellUserData alloc] init];
  NICellObject *cellObj =
      [[NICellObject alloc] initWithCellClass:[PhotoInfoCell class]
                                     userInfo:userData];
  return cellObj;
}
@end
