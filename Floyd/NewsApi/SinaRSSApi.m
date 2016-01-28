//
//  SinaNewsApi.m
//  Floyd
//
//  Created by admin on 16/1/8.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "SinaRSSApi.h"
#import "AFNetworking.h"
#import "XMLDictionary.h"

@implementation SinaRSSApi
- (void)queryChannelsWithsuccess:(void (^)(RSSRoot *ret))successBlock
                              failed:(void (^)(NSError *error))failedBlock;
{
  NSURL *url =
      [NSURL URLWithString:@"http://rss.sina.com.cn/sina_all_opml.xml"];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];

  // 2
  AFHTTPRequestOperation *operation =
      [[AFHTTPRequestOperation alloc] initWithRequest:request];
  operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
  [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation,
                                             NSXMLParser *xmlParser) {
    NSError *error;
    NSDictionary *dic = [NSDictionary dictionaryWithXMLParser:xmlParser];
    RSSRoot *category = [[RSSRoot alloc] initWithDictionary:dic error:&error];
    if (!error) {
      successBlock(category);
    } else {
      failedBlock(error);
    }
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    failedBlock(error);
  }];
  // 5
  [operation start];
}

- (void)loadItemsWithUrl:(NSString *)urlStr
                success:(void (^)(RSSChannelDetail *ret))successBlock
                 failed:(void (^)(NSError *error))failedBlock {
  NSURL *url = [NSURL URLWithString:urlStr];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];

  // 2
  AFHTTPRequestOperation *operation =
      [[AFHTTPRequestOperation alloc] initWithRequest:request];
  operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
  [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation,
                                             NSXMLParser *xmlParser) {
    NSError *error;
    NSDictionary *dic = [NSDictionary dictionaryWithXMLParser:xmlParser];
    RSSChannelDetail *channel =
        [[RSSChannelDetail alloc] initWithDictionary:dic error:&error];
    if (!error) {
      successBlock(channel);
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
