//
//  IndexInfoCell.m
//  Floyd
//
//  Created by admin on 16/1/7.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "IndexInfoCell.h"
@implementation IndexInfoCellUserData
@end

@interface IndexInfoCell ()
@property(nonatomic, strong) UILabel *indexTitle;
@property(nonatomic, strong) UILabel *indexLevel;
@property(nonatomic, strong) UILabel *indexDesc;
@end

@implementation IndexInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor ex_globalBackgroundColor];
    self.indexTitle = [UILabel new];
    self.indexTitle.font = [UIFont systemFontOfSize:20];
    self.indexTitle.textColor = [UIColor blueColor];
    self.indexTitle.textAlignment = NSTextAlignmentCenter;

    self.indexLevel = [UILabel new];
    self.indexLevel.font = [UIFont systemFontOfSize:15];
    self.indexLevel.textColor = [UIColor blueColor];
    self.indexLevel.textAlignment = NSTextAlignmentCenter;

    self.indexDesc = [UILabel new];
    self.indexDesc.font = [UIFont systemFontOfSize:15];
    self.indexDesc.textColor = [UIColor blueColor];
    self.indexDesc.textAlignment = NSTextAlignmentLeft;
    self.indexDesc.numberOfLines = 0;
    self.indexDesc.lineBreakMode = NSLineBreakByCharWrapping;

    [self.contentView addSubview:self.indexTitle];
    [self.contentView addSubview:self.indexLevel];
    [self.contentView addSubview:self.indexDesc];
    [self makeConstraints];
  }
  return self;
}

- (void)makeConstraints {
  [self.indexTitle mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.contentView).offset(15);
    make.top.equalTo(self.contentView).offset(15);
  }];

  [self.indexLevel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.contentView).offset(15);
    make.top.equalTo(self.indexTitle.mas_bottom).offset(5);
  }];

  [self.indexDesc mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.contentView).offset(15);
    make.right.lessThanOrEqualTo(self.contentView.mas_right).offset(-15);
    make.top.equalTo(self.indexLevel.mas_bottom).offset(5);
  }];
}

- (void)dealloc {
  self.userData = nil;
}

+ (CGFloat)heightForObject:(id)object
               atIndexPath:(NSIndexPath *)indexPath
                 tableView:(UITableView *)tableView {
  return 120;
}

- (BOOL)shouldUpdateCellWithObject:(NICellObject *)object {
  self.userData = (IndexInfoCellUserData *)object.userInfo;
  self.indexTitle.text = self.userData.index.indexNameCN;
  self.indexLevel.text = self.userData.index.indexLevel;
  self.indexDesc.text = self.userData.index.indexDesc;
  return YES;
}

+ (NICellObject *)createObject:(id)_delegate userData:(id)_userData {
  IndexInfoCellUserData *userData = [[IndexInfoCellUserData alloc] init];
  NICellObject *cellObj =
      [[NICellObject alloc] initWithCellClass:[IndexInfoCell class]
                                     userInfo:userData];
  return cellObj;
}

@end
