//
//  CitySelectCell.m
//  Floyd
//
//  Created by admin on 16/1/7.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "CitySelectCell.h"

@implementation CitySelectCellUserData
@end

@interface CitySelectCell ()
@property(nonatomic, strong) UILabel *title;
@property(nonatomic, strong) UILabel *indexLevel;
@property(nonatomic, strong) UILabel *indexDesc;
@end

@implementation CitySelectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.title = [UILabel new];
    self.title.font = [UIFont systemFontOfSize:15];
    self.title.textColor = [UIColor blueColor];
    self.title.textAlignment = NSTextAlignmentCenter;

    [self.contentView addSubview:self.title];
    [self makeConstraints];
  }
  return self;
}

- (void)makeConstraints {
  [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.contentView).offset(15);
    make.top.equalTo(self.contentView).offset(15);
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
  self.userData = (CitySelectCellUserData *)object.userInfo;
  self.title.text = self.userData.cityName;
  return YES;
}

+ (NICellObject *)createObject:(id)_delegate userData:(id)_userData {
  CitySelectCellUserData *userData = [[CitySelectCellUserData alloc] init];
  NICellObject *cellObj =
      [[NICellObject alloc] initWithCellClass:[CitySelectCell class]
                                     userInfo:userData];
  return cellObj;
}

@end
