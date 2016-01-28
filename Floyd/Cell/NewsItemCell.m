//
//  NewsItemCell.m
//  Floyd
//
//  Created by admin on 16/1/8.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "NewsItemCell.h"
@implementation NewsItemCellUserData
@end

@interface NewsItemCell ()
@property(nonatomic, strong) UILabel *title;
@property(nonatomic, strong) UILabel *desc;
@property(nonatomic, strong) UILabel *pubDate;
@end

@implementation NewsItemCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.contentView.backgroundColor = [UIColor whiteColor];

    self.title = [UILabel new];
    self.title.font = Font_15_B;
    self.title.numberOfLines = 0;
    self.title.textColor = [UIColor ex_mainTextColor];
    self.title.textAlignment = NSTextAlignmentLeft;

    self.desc = [UILabel new];
    self.desc.font = Font_15;
    self.desc.textColor = [UIColor ex_subTextColor];
    self.desc.numberOfLines = 0;
    self.desc.lineBreakMode = NSLineBreakByWordWrapping;
    self.desc.textAlignment = NSTextAlignmentLeft;

    self.pubDate = [UILabel new];
    self.pubDate.font = Font_15;
    self.pubDate.textColor = [UIColor ex_subTextColor];
    self.pubDate.textAlignment = NSTextAlignmentLeft;

    self.clipsToBounds = YES;
    [self.contentView addSubview:self.title];
    [self.contentView addSubview:self.desc];
    [self.contentView addSubview:self.pubDate];

    [self makeConstraint];
  }
  return self;
}

- (void)makeConstraint {
  [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.contentView).offset(10);
    make.left.equalTo(self.contentView).offset(15);
    make.right.lessThanOrEqualTo(self.contentView).offset(-15);
  }];

  [self.desc mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.title.mas_bottom).offset(5);
    make.left.equalTo(self.contentView).offset(15);
    make.right.lessThanOrEqualTo(self.contentView).offset(-15);
  }];

  [self.pubDate mas_makeConstraints:^(MASConstraintMaker *make) {
    make.bottom.equalTo(self.contentView).offset(-5);
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
  CGFloat height = 45;
  NICellObject *obj = object;
  NewsItemCellUserData *userData = (NewsItemCellUserData *)obj.userInfo;
  CGFloat maxWidth = tableView.frame.size.width - 30;

  height += [userData.newsItem.newsDesc
      lineBreakSizeOfStringwithFont:Font_15
                           maxwidth:maxWidth
                      lineBreakMode:NSLineBreakByWordWrapping];

  height += [userData.newsItem.title
      lineBreakSizeOfStringwithFont:Font_15
                           maxwidth:maxWidth
                      lineBreakMode:NSLineBreakByWordWrapping];
  return height;
}

- (BOOL)shouldUpdateCellWithObject:(NICellObject *)object {
  self.userData = (NewsItemCellUserData *)object.userInfo;
  self.title.text = self.userData.newsItem.title;
  self.desc.text = self.userData.newsItem.newsDesc;
  self.pubDate.text = self.userData.newsItem.pubDate;
  return YES;
}

+ (NICellObject *)createObject:(id)_delegate userData:(id)_userData {
  NewsItemCellUserData *userData = [[NewsItemCellUserData alloc] init];
  NICellObject *cellObj =
      [[NICellObject alloc] initWithCellClass:[NewsItemCell class]
                                     userInfo:userData];
  return cellObj;
}

@end
