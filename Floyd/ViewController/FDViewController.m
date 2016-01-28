//
//  FDViewController.m
//  Floyd
//
//  Created by admin on 16/1/15.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "FDViewController.h"

@implementation FDViewController
#pragma Action
- (void)showError:(NSError *)error {
  if (error) {
    UIAlertView *alert = [[UIAlertView alloc]
            initWithTitle:@"错误"
                  message:[NSString stringWithFormat:@"%@", error]
                 delegate:nil
        cancelButtonTitle:@"确定"
        otherButtonTitles:nil, nil];
    [alert show];
        }
}
@end
