//
//  SmartWeatherAPI.m
//  Floyd
//
//  Created by admin on 16/1/5.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "SmartWeatherAPI.h"
#import "AFNetworking.h"
#import "Base64.h"
#include <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>

#define kAppId @"5dd7173792534af2"
#define kAppIdShort @"5dd717"
#define kPrivateKey @"9c7aab_SmartWeatherAPI_27cc531"
//基础气象数据接口：
#define kBaseWeatherType @"forecast_f"

//常规气象数据接口：
#define kNormalWeatherType @"forecast_v"

//基础指数数据接口：
#define kBaseIndexType @"index_f"

//常规指数数据接口：
#define kNormalIndexType @"index_v"

@implementation SmartWeatherAPI

- (NSString *)hmacsha1:(NSString *)data secret:(NSString *)key {

  const char *cKey = [key cStringUsingEncoding:NSASCIIStringEncoding];
  const char *cData = [data cStringUsingEncoding:NSASCIIStringEncoding];

  unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];

  CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);

  NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];

  NSString *hash = [HMAC base64Encoding];

  return hash;
}

- (NSString *)getEndcodedUrlWithAreaId:(NSString *)areaId
                                  type:(NSString *)type {
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"yyyyMMddHHmm"];
  NSString *date = [formatter stringFromDate:[NSDate date]];
  NSString *urlStr =
      [NSString stringWithFormat:@"http://open.weather.com.cn/data/"
                                 @"?areaid=%@&type=%@&date=%@&appid=%@",
                                 areaId, type, date, kAppId];
  NSString *endocdedKey = [self hmacsha1:urlStr secret:kPrivateKey];
  NSString *encodedUrl =
      [NSString stringWithFormat:@"http://open.weather.com.cn/data/"
                                 @"?areaid=%@&type=%@&date=%@&appid=%@&key=%@",
                                 areaId, type, date, kAppIdShort, endocdedKey];
  return encodedUrl;
}

- (void)queryWeather:(NSString *)areaId
             success:(void (^)(Weather *))successBlock
              failed:(void (^)(NSError *))failedBlock {

  NSURL *url =
      [NSURL URLWithString:[self getEndcodedUrlWithAreaId:areaId
                                                     type:kNormalWeatherType]];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];

  // 2
  AFHTTPRequestOperation *operation =
      [[AFHTTPRequestOperation alloc] initWithRequest:request];
  operation.responseSerializer = [AFHTTPResponseSerializer serializer];
  [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation,
                                             NSData *responseObject) {
    NSString *aStr = [[NSString alloc] initWithData:responseObject
                                           encoding:NSUTF8StringEncoding];
    NSError *error;
    Weather *weather = [[Weather alloc] initWithString:aStr error:&error];
    if (!error) {
      successBlock(weather);
    } else {
      failedBlock(error);
    }
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    failedBlock(error);
  }];
  // 5
  [operation start];
}

- (void)QueryIndex:(NSString *)areaId
           success:(void (^)(Index *))successBlock
            failed:(void (^)(NSError *))failedBlock {
  NSURL *url =
      [NSURL URLWithString:[self getEndcodedUrlWithAreaId:areaId
                                                     type:kNormalIndexType]];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];

  // 2
  AFHTTPRequestOperation *operation =
      [[AFHTTPRequestOperation alloc] initWithRequest:request];
  operation.responseSerializer = [AFHTTPResponseSerializer serializer];
  [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation,
                                             NSData *responseObject) {
    NSString *aStr = [[NSString alloc] initWithData:responseObject
                                           encoding:NSUTF8StringEncoding];
    NSError *error;
    Index *index = [[Index alloc] initWithString:aStr error:&error];
    if (!error) {
      successBlock(index);
    } else {
      failedBlock(error);
    }
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    failedBlock(error);
  }];
        // 5
	[operation start];
}

@end
