/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import "AppDelegate.h"

#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>
#import <React/RCTBridge.h>

#import "RNRouter.h"


///
#import "RNVMMV.h"
#import "GMWelcomeViewController.h"
#import "GMSignInViewController.h"
@interface AppDelegate()
@property (nonatomic,retain)RCTBridge *bridge ;
@property (nonatomic,retain)RNRouter * router;
@end
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  
  UIViewController *rootViewController = [UIViewController new];
  self.window.rootViewController = rootViewController;
  [self.window makeKeyAndVisible];
  
  [RNRouter createWithWindow:self.window];
  
  [[RNRouter sharedInstance] registerViewControllerClass:[GMWelcomeViewController class] forRoute:@"welcome"];
  [[RNRouter sharedInstance] registerViewControllerClass:[GMSignInViewController class] forRoute:@"sign_in"];
  
  
  NSURL *jsCodeLocation;

  jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index.ios" fallbackResource:nil];

  [RNVMMV loadApplicationWithURL:jsCodeLocation withLaunchOptions:launchOptions];
  

//  self.router =  [[RNRouter alloc] init];
//  self.router.bridge = self.bridge;

//  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//    sleep(3);
//    dispatch_async(dispatch_get_main_queue(), ^{
//      NSLog(@"LAST CHECK");
//      [RNRouter sharedInstance];
//      
//    });
//  });
  
 
//  [bridge enqueueJSCall:<#(NSString *)#> args:<#(NSArray *)#>]
//  
//  
//  rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];



  return YES;
  
  RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                      moduleName:@"Gabbermap"
                                               initialProperties:nil
                                                   launchOptions:launchOptions];

}

@end
