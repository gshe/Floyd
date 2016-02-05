//
//  SettingsTableViewController.m
//  Floyd
//
//  Created by admin on 16/1/4.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "XMDeveloperHelper.h"

@interface SettingsTableViewController ()
@property(nonatomic, strong) NITableViewActions *actions;
@end

@implementation SettingsTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  [self refreshUI];
}
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.rdv_tabBarController.tabBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	self.rdv_tabBarController.tabBarHidden = self.tabBarInitStatus;
}
- (void)refreshUI {
  _actions = [[NITableViewActions alloc] initWithTarget:self];
  NSMutableArray *contents = [@[] mutableCopy];
  [contents addObject:@"通用"];
  [contents
      addObject:[self.actions
                    attachToObject:[NITitleCellObject objectWithTitle:@"关于"]
                       tapSelector:@selector(aboutApp:)]];
  [contents addObject:@"缓存"];
  [contents addObject:[self.actions
                          attachToObject:[NITitleCellObject
                                             objectWithTitle:@"清空缓存"]
                             tapSelector:@selector(cleanCache:)]];
  [contents addObject:@"调试"];
  [contents
      addObject:[NISwitchFormElement
                    switchElementWithID:0
                              labelText:@"Switch with target/selector"
                                  value:[[XMDeveloperHelper
                                                sharedInstance] isFlexOpen]
                        didChangeTarget:self
                      didChangeSelector:@selector(openFlex:)]];

  self.tableView.delegate = [self.actions forwardingTo:self];
  [self setTableData:contents];
}

- (void)openFlex:(id)sender {
  if ([[XMDeveloperHelper sharedInstance] isFlexOpen]) {
    [[XMDeveloperHelper sharedInstance] closeFlex];
  } else {
    [[XMDeveloperHelper sharedInstance] openFlex];
  }
}

- (void)aboutApp:(id)sender {
}

- (void)cleanCache:(id)sender {
	
}

@end
