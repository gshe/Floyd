//
//  WeiboDateTimeConverter.m
//  Floyd
//
//  Created by admin on 16/1/15.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "WeiboDateTimeConverter.h"

@implementation WeiboDateTimeConverter
+ (NSString *)weiboDateTimeToString:(NSString *)weiboDateTime {
  NSDateFormatter *dateFormaterFrom = [[NSDateFormatter alloc] init];
  [dateFormaterFrom
      setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
  [dateFormaterFrom setDateFormat:@"EEE MMM dd HH:mm:ss Z yyyy"];
  NSDateFormatter *dateFormaterTo = [[NSDateFormatter alloc] init];
  [dateFormaterTo setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
  NSDate *dt = [dateFormaterFrom dateFromString:weiboDateTime];
  return [dateFormaterTo stringFromDate:dt];
  return nil;
}
@end
