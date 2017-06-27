//
//  RNRouter.h
//  Gabbermap
//
//  Created by Alex Padalko on 3/18/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RNVMMVScene.h"

@class UIWindow;
@class UIViewController;

@interface RNRouter : NSObject

+(instancetype)createWithWindow:(UIWindow*)window;

+(instancetype)sharedInstance;
-(void)registerViewControllerClass:(Class)vcClass forRoute:(NSString*)routeName;
-(UIViewController *)getViewControllerForScene:(RNVMMVScene*)scene;

@end
