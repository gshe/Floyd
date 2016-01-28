//
//  AppDelegate.m
//  Floyd
//
//  Created by admin on 16/1/4.
//  Copyright © 2016年 George She. All rights reserved.
//

#import "AppDelegate.h"
#import "WeatherViewController.h"
#import "NewsViewController.h"
#import "ProfileTableViewController.h"
#import "CitySelectTableViewController.h"
#import "MMDrawerController.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "weiboSDK.h"
#import "XWindowStack.h"
#import "MyWeiboViewController.h"
#import "NewsChannelSelectViewController.h"

@interface AppDelegate () <WeiboSDKDelegate>

@end

@implementation AppDelegate
- (void)prepareForLaunching {
  // Disk cache
  NSURLCache *URLCache =
      [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024
                                    diskCapacity:20 * 1024 * 1024
                                        diskPath:nil];
  [NSURLCache setSharedURLCache:URLCache];

  // AFNetworking
  [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
  // Sina SDK
  [WeiboSDK enableDebugMode:YES];
  [WeiboSDK registerApp:SinaWeiboV2AppKey];
}

- (UIViewController *)getRootViewController {
  WeatherViewController *weatherVC =
      [[WeatherViewController alloc] initWithNibName:nil bundle:nil];
  UINavigationController *nav1 =
      [[UINavigationController alloc] initWithRootViewController:weatherVC];
  CitySelectTableViewController *cityController =
      [[CitySelectTableViewController alloc] init];
  UINavigationController *leftSideController = [[UINavigationController alloc]
      initWithRootViewController:cityController];
  cityController.delegate = weatherVC;

  MMDrawerController *weatherDrawerController = [[MMDrawerController alloc]
      initWithCenterViewController:nav1
          leftDrawerViewController:leftSideController
         rightDrawerViewController:nil];
  [weatherDrawerController setShowsShadow:NO];
  [weatherDrawerController setRestorationIdentifier:@"MMDrawer"];
  [weatherDrawerController setMaximumLeftDrawerWidth:150];
  [weatherDrawerController
      setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
  [weatherDrawerController
      setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
  [weatherDrawerController
      setDrawerVisualStateBlock:^(MMDrawerController *drawerController,
                                  MMDrawerSide drawerSide,
                                  CGFloat percentVisible) {
        MMDrawerControllerDrawerVisualStateBlock block;
        block = [[MMExampleDrawerVisualStateManager sharedManager]
            drawerVisualStateBlockForDrawerSide:drawerSide];
        if (block) {
          block(drawerController, drawerSide, percentVisible);
        }
      }];
  weatherDrawerController.tabBarItem =
      [[UITabBarItem alloc] initWithTitle:@"天气"
                                    image:[UIImage imageNamed:@"weather"]
                                      tag:1];

  NewsViewController *newsVC =
      [[NewsViewController alloc] initWithNibName:nil bundle:nil];
  newsVC.tabBarItem =
      [[UITabBarItem alloc] initWithTitle:@"资讯"
                                    image:[UIImage imageNamed:@"news"]
                                      tag:2];

  NewsChannelSelectViewController *newsChannelSelectVc =
      [[NewsChannelSelectViewController alloc] initWithNibName:nil bundle:nil];
  UINavigationController *newsRightSideController =
      [[UINavigationController alloc]
          initWithRootViewController:newsChannelSelectVc];
  cityController.delegate = weatherVC;
  UINavigationController *nav2 =
      [[UINavigationController alloc] initWithRootViewController:newsVC];
  MMDrawerController *newsDrawerController = [[MMDrawerController alloc]
      initWithCenterViewController:nav2
          leftDrawerViewController:nil
         rightDrawerViewController:newsRightSideController];
  [newsDrawerController setShowsShadow:NO];
  [newsDrawerController setRestorationIdentifier:@"MMDrawer2"];
  [newsDrawerController setMaximumRightDrawerWidth:150];
  [newsDrawerController
      setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
  [newsDrawerController
      setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
  [newsDrawerController
      setDrawerVisualStateBlock:^(MMDrawerController *drawerController,
                                  MMDrawerSide drawerSide,
                                  CGFloat percentVisible) {
        MMDrawerControllerDrawerVisualStateBlock block;
        block = [[MMExampleDrawerVisualStateManager sharedManager]
            drawerVisualStateBlockForDrawerSide:drawerSide];
        if (block) {
          block(drawerController, drawerSide, percentVisible);
        }
      }];

  newsVC.channelSelectVC = newsChannelSelectVc;
  newsChannelSelectVc.delegate = newsVC;
  newsDrawerController.tabBarItem =
      [[UITabBarItem alloc] initWithTitle:@"资讯"
                                    image:[UIImage imageNamed:@"news"]
                                      tag:2];

  MyWeiboViewController *weiboVC =
      [[MyWeiboViewController alloc] initWithNibName:nil bundle:nil];
  weiboVC.tabBarItem =
      [[UITabBarItem alloc] initWithTitle:@"微博"
                                    image:[UIImage imageNamed:@"LOGO"]
                                      tag:3];
  ;
  ProfileTableViewController *profileVC =
      [[ProfileTableViewController alloc] initWithNibName:nil bundle:nil];
  profileVC.tabBarItem =
      [[UITabBarItem alloc] initWithTitle:@"我的"
                                    image:[UIImage imageNamed:@"me"]
                                      tag:4];
  ;

  UINavigationController *nav3 =
      [[UINavigationController alloc] initWithRootViewController:weiboVC];

  UINavigationController *nav4 =
      [[UINavigationController alloc] initWithRootViewController:profileVC];
  UITabBarController *tabVC = [[UITabBarController alloc] init];
  tabVC.viewControllers =
      [NSArray arrayWithObjects:weatherDrawerController, newsDrawerController,
                                nav3, nav4, nil];
  tabVC.selectedIndex = 0;
  return tabVC;
}

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

  NSURLCache *cache =
      [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024
                                    diskCapacity:100 * 1024 * 1024
                                        diskPath:nil];
  [NSURLCache setSharedURLCache:cache];

  [self prepareForLaunching];

  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

  //  UIColor *tintColor = [UIColor colorWithRed:29.0 / 255.0
  //                                       green:173.0 / 255.0
  //                                        blue:234.0 / 255.0
  //                                       alpha:1.0];
  //  [self.window setTintColor:tintColor];
  UIViewController *rootVC = [self getRootViewController];
  self.window.rootViewController = rootVC;
  [self.window makeKeyAndVisible];
  [XWindowStack pushWindow:self.window];
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state.
  // This can occur for certain types of temporary interruptions (such as an
  // incoming phone call or SMS message) or when the user quits the application
  // and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down
  // OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate
  // timers, and store enough application state information to restore your
  // application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called
  // instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the inactive state;
  // here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the
  // application was inactive. If the application was previously in the
  // background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if
  // appropriate. See also applicationDidEnterBackground:.
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)application:(UIApplication *)application
              openURL:(NSURL *)url
    sourceApplication:(NSString *)sourceApplication
           annotation:(id)annotation {
  return [WeiboSDK handleOpenURL:url delegate:self];
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
  if ([response isKindOfClass:WBAuthorizeResponse.class]) {
    WBAuthorizeResponse *authResponse = (WBAuthorizeResponse *)response;
    WeiboInfoManager *manager = response.userInfo[@"From"];
    if ([manager isKindOfClass:[WeiboInfoManager class]]) {
      [manager handleWBAuthorizeResponse:authResponse];
    }
  }
}
@end
