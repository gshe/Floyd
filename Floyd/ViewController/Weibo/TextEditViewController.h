//
//  TextEditViewController.h
//  Floyd
//
//  Created by George She on 16/1/28.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "FDViewController.h"
@protocol TextEditViewControllerDelegate;

@interface TextEditViewController : FDViewController
@property(nonatomic, strong) NSString *oldText;
@property(nonatomic, strong) NSString *placeHolder;
@property(nonatomic, weak) id<TextEditViewControllerDelegate> delegate;
@end

@protocol TextEditViewControllerDelegate <NSObject>
- (void)TextEditVC:(TextEditViewController *)vc textChanged:(NSString *)newText;
@end