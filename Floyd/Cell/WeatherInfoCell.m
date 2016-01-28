//
//  WeatherInfoCell.m
//  Floyd
//
//  Created by admin on 16/1/7.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "WeatherInfoCell.h"

@implementation WeatherInfoCellUserData

@end

@interface WeatherInfoCell ()
@property(nonatomic, strong) UILabel *weatherTitle;
@property(nonatomic, strong) UIImageView *weatherIcon;
@property(nonatomic, strong) UILabel *weatherDescLabel;
@property(nonatomic, strong) UILabel *weatherTemperature;
@property(nonatomic, strong) UILabel *weatherWindDirection;
@property(nonatomic, strong) UILabel *weatherWindForce;

@end

@implementation WeatherInfoCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor ex_globalBackgroundColor];
    self.weatherTitle = [UILabel new];
    self.weatherTitle.font = [UIFont systemFontOfSize:20];
    self.weatherTitle.textColor = [UIColor blueColor];
    self.weatherTitle.textAlignment = NSTextAlignmentCenter;

    self.weatherIcon = [[UIImageView alloc] init];
    self.weatherDescLabel = [UILabel new];
    self.weatherDescLabel.font = [UIFont systemFontOfSize:20];
    self.weatherDescLabel.textColor = [UIColor blueColor];
    self.weatherDescLabel.textAlignment = NSTextAlignmentCenter;

    self.weatherTemperature = [UILabel new];
    self.weatherTemperature.font = [UIFont systemFontOfSize:15];
    self.weatherTemperature.textColor = [UIColor blueColor];
    self.weatherTemperature.textAlignment = NSTextAlignmentCenter;

    self.weatherWindDirection = [UILabel new];
    self.weatherWindDirection.font = [UIFont systemFontOfSize:15];
    self.weatherWindDirection.textColor = [UIColor blueColor];
    self.weatherWindDirection.textAlignment = NSTextAlignmentCenter;

    self.weatherWindForce = [UILabel new];
    self.weatherWindForce.font = [UIFont systemFontOfSize:15];
    self.weatherWindForce.textColor = [UIColor blueColor];
    self.weatherWindForce.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.weatherIcon];
    [self.contentView addSubview:self.weatherTitle];
    [self.contentView addSubview:self.weatherDescLabel];
    [self.contentView addSubview:self.weatherTemperature];
    [self.contentView addSubview:self.weatherWindDirection];
    [self.contentView addSubview:self.weatherWindForce];

    [self makeConstraints];
  }
  return self;
}

- (void)makeConstraints {
  [self.weatherTitle mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.contentView).offset(15);
    make.top.equalTo(self.contentView).offset(15);
  }];

  [self.weatherIcon mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.contentView).offset(15);
    make.top.equalTo(self.weatherTitle.mas_bottom).offset(5);
    make.width.mas_equalTo(60);
    make.height.mas_equalTo(60);
  }];

  [self.weatherDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.contentView).offset(15);
    make.top.equalTo(self.weatherIcon.mas_bottom).offset(5);
  }];

  [self.weatherTemperature mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.weatherDescLabel);
    make.top.equalTo(self.weatherDescLabel.mas_bottom).offset(5);
  }];

  [self.weatherWindDirection mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.weatherDescLabel);
    make.top.equalTo(self.weatherTemperature.mas_bottom).offset(5);
  }];

  [self.weatherWindForce mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.weatherDescLabel);
    make.top.equalTo(self.weatherWindDirection.mas_bottom).offset(5);
  }];
}

- (void)dealloc {
  self.userData = nil;
}

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
}

+ (CGFloat)heightForObject:(id)object
               atIndexPath:(NSIndexPath *)indexPath
                 tableView:(UITableView *)tableView {
  return 250;
}

- (BOOL)shouldUpdateCellWithObject:(NICellObject *)object {
  self.userData = (WeatherInfoCellUserData *)object.userInfo;
  NSString *title;
  NSString *icon;
  NSString *temperature;
  NSString *windDirection;
  NSString *windForce;
  NSString *weatherDesc;
  if (self.userData.isDayWeather) {
    title = @"白天";
    icon = self.userData.weather.dayWeatherIcon;
    weatherDesc = self.userData.weather.dayWeather;
    temperature = [NSString
        stringWithFormat:@"温度：%zd", self.userData.weather.dayTemperature];
    windDirection =
        [NSString stringWithFormat:@"风向：%@",
                                   self.userData.weather.dayWindDirection];
    windForce = [NSString
        stringWithFormat:@"风力：%@", self.userData.weather.dayWindForce];
  } else {
    title = @"晚上";
    icon = self.userData.weather.nightWeatherIcon;
    weatherDesc = self.userData.weather.nightWeather;
    temperature =
        [NSString stringWithFormat:@"温度：%zd",
                                   self.userData.weather.nightTemperature];
    windDirection =
        [NSString stringWithFormat:@"风向：%@",
                                   self.userData.weather.dayWindDirection];
    windForce = [NSString
        stringWithFormat:@"风力：%@", self.userData.weather.nightWindForce];
  }

  self.weatherIcon.image = [UIImage imageNamed:icon];
  self.weatherTitle.text = title;
  self.weatherDescLabel.text = weatherDesc;
  self.weatherTemperature.text = temperature;
  self.weatherWindDirection.text = windDirection;
  self.weatherWindForce.text = windForce;
  return YES;
}

+ (NICellObject *)createObject:(id)_delegate userData:(id)_userData {
  WeatherInfoCellUserData *userData = [[WeatherInfoCellUserData alloc] init];
  NICellObject *cellObj =
      [[NICellObject alloc] initWithCellClass:[WeatherInfoCell class]
                                     userInfo:userData];
  return cellObj;
}

@end
