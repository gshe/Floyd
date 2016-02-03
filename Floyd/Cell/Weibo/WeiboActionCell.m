//
//  WeiboActionCell.m
//  Floyd
//
//  Created by George She on 16/1/20.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "WeiboActionCell.h"
@implementation WeiboActionCellUserData
@end

@interface WeiboActionCell ()
@property(nonatomic, strong) UIButton *actionComment;
@property(nonatomic, strong) UIButton *actionRepost;
@property(nonatomic, strong) UIButton *actionLikeIt;
@property(nonatomic, strong) UIView *actionCommentLine;
@property(nonatomic, strong) UIView *actionRepostLine;
@property(nonatomic, strong) UIView *actionLikeItLine;

@property(nonatomic, assign) CGFloat oneThirdWidth;
@end

@implementation WeiboActionCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.oneThirdWidth = kScreenWidth / 3;
    self.contentView.backgroundColor = [UIColor ex_globalBackgroundColor];

    self.actionComment = [UIButton buttonWithType:UIButtonTypeCustom];
    self.actionComment.titleLabel.font = Font_15;
    [self.actionComment setTitle:@"转发" forState:UIControlStateNormal];
    [self.actionComment setTitleColor:[UIColor ex_subTextColor]
                             forState:UIControlStateNormal];
    [self.actionComment addTarget:self
                           action:@selector(onCommentClicked:)
                 forControlEvents:UIControlEventTouchUpInside];

    self.actionRepost = [UIButton new];
    self.actionRepost.titleLabel.font = Font_15;
    [self.actionRepost setTitle:@"评论" forState:UIControlStateNormal];
    [self.actionRepost setTitleColor:[UIColor ex_subTextColor]
                            forState:UIControlStateNormal];
    [self.actionRepost addTarget:self
                          action:@selector(onRepostClicked:)
                forControlEvents:UIControlEventTouchUpInside];

    self.actionLikeIt = [UIButton new];
    self.actionLikeIt.titleLabel.font = Font_15;
    [self.actionLikeIt setTitle:@"赞" forState:UIControlStateNormal];
    [self.actionLikeIt setTitleColor:[UIColor ex_subTextColor]
                            forState:UIControlStateNormal];
    [self.actionLikeIt addTarget:self
                          action:@selector(onLikeClicked:)
                forControlEvents:UIControlEventTouchUpInside];

    self.actionCommentLine = [UIView new];
    self.actionCommentLine.backgroundColor = [UIColor redColor];
    self.actionRepostLine = [UIView new];
    self.actionRepostLine.backgroundColor = [UIColor redColor];
    self.actionLikeItLine = [UIView new];
    self.actionLikeItLine.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.actionComment];
    [self.contentView addSubview:self.actionRepost];
    [self.contentView addSubview:self.actionLikeIt];
    [self.contentView addSubview:self.actionCommentLine];
    [self.contentView addSubview:self.actionRepostLine];
    [self.contentView addSubview:self.actionLikeItLine];

    [self makeConstraints];
  }

  return self;
}

- (void)dealloc {
  self.userData = nil;
}

- (void)makeConstraints {
  [self.actionRepost mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.equalTo(self.contentView);
    make.left.equalTo(self.contentView);
    make.right.equalTo(self.contentView.mas_left).offset(self.oneThirdWidth);
  }];

  [self.actionComment mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.equalTo(self.contentView);
    make.left.equalTo(self.contentView).offset(self.oneThirdWidth);
    make.right.equalTo(self.contentView.mas_left)
        .offset(2 * self.oneThirdWidth);
  }];

  [self.actionLikeIt mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.equalTo(self.contentView);
    make.left.equalTo(self.contentView.mas_left).offset(2 * self.oneThirdWidth);
    make.right.equalTo(self.contentView);
  }];

  [self.actionRepostLine mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.actionRepost);
    make.right.equalTo(self.actionRepost);
    make.height.mas_equalTo(2);
    make.bottom.equalTo(self.contentView).offset(-2);
  }];

  [self.actionCommentLine mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.actionComment);
    make.right.equalTo(self.actionComment);
    make.height.mas_equalTo(2);
    make.bottom.equalTo(self.contentView).offset(-2);
  }];

  [self.actionLikeItLine mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.actionLikeIt);
    make.right.equalTo(self.actionLikeIt);
    make.height.mas_equalTo(2);
    make.bottom.equalTo(self.contentView).offset(-2);
  }];
}

+ (CGFloat)heightForObject:(id)object
               atIndexPath:(NSIndexPath *)indexPath
                 tableView:(UITableView *)tableView {
  return 44;
}

- (BOOL)shouldUpdateCellWithObject:(NICellObject *)object {
  self.userData = (WeiboActionCellUserData *)object.userInfo;

  NSString *title = [NSString
      stringWithFormat:@"转发 %zd", self.userData.weiboInfo.reposts_count];
  [self.actionRepost setTitle:title forState:UIControlStateNormal];
  title = [NSString
      stringWithFormat:@"评论 %zd", self.userData.weiboInfo.comments_count];
  [self.actionComment setTitle:title forState:UIControlStateNormal];
  title = [NSString
      stringWithFormat:@"赞 %zd", self.userData.weiboInfo.attitudes_count];
  [self.actionLikeIt setTitle:title forState:UIControlStateNormal];
  switch (self.userData.curAction) {
  case FDActionMode_Repost:
    [self.actionRepost setTitleColor:[UIColor redColor]
                            forState:UIControlStateNormal];
    [self.actionComment setTitleColor:[UIColor ex_subTextColor]
                             forState:UIControlStateNormal];
    [self.actionLikeIt setTitleColor:[UIColor ex_subTextColor]
                            forState:UIControlStateNormal];
    self.actionRepostLine.hidden = NO;
    self.actionCommentLine.hidden = YES;
    self.actionLikeItLine.hidden = YES;
    break;
  case FDActionMode_Comment:
    [self.actionRepost setTitleColor:[UIColor ex_subTextColor]
                            forState:UIControlStateNormal];
    [self.actionComment setTitleColor:[UIColor redColor]
                             forState:UIControlStateNormal];
    [self.actionLikeIt setTitleColor:[UIColor ex_subTextColor]
                            forState:UIControlStateNormal];
    self.actionRepostLine.hidden = YES;
    self.actionCommentLine.hidden = NO;
    self.actionLikeItLine.hidden = YES;
    break;
  case FDActionMode_LikeIt:
    [self.actionRepost setTitleColor:[UIColor ex_subTextColor]
                            forState:UIControlStateNormal];
    [self.actionComment setTitleColor:[UIColor ex_subTextColor]
                             forState:UIControlStateNormal];
    [self.actionLikeIt setTitleColor:[UIColor redColor]
                            forState:UIControlStateNormal];
    self.actionRepostLine.hidden = YES;
    self.actionCommentLine.hidden = YES;
    self.actionLikeItLine.hidden = NO;
    break;
  default:
    break;
  }
  return YES;
}

+ (NICellObject *)createObject:(id)_delegate userData:(id)_userData {
  WeiboActionCellUserData *userData = [[WeiboActionCellUserData alloc] init];
  NICellObject *cellObj =
      [[NICellObject alloc] initWithCellClass:[WeiboActionCell class]
                                     userInfo:userData];
  return cellObj;
}

- (void)onCommentClicked:(id)sender {
	if ([self.userData.delegate respondsToSelector:@selector(actionModeChanged:)]){
		[self.userData.delegate actionModeChanged:FDActionMode_Comment];
	}
}

- (void)onRepostClicked:(id)sender {
	if ([self.userData.delegate respondsToSelector:@selector(actionModeChanged:)]){
		[self.userData.delegate actionModeChanged:FDActionMode_Repost];
	}
}

- (void)onLikeClicked:(id)sender {
	if ([self.userData.delegate respondsToSelector:@selector(actionModeChanged:)]){
		[self.userData.delegate actionModeChanged:FDActionMode_LikeIt];
	}
}
@end
