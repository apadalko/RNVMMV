//
//  RNRouter_Private.h
//  Gabbermap
//
//  Created by Alex Padalko on 3/18/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "RNRouter.h"
#import <React/RCTBridgeModule.h>
@class RNViewModel;
@interface RNRouter (Private)<RCTBridgeModule>
-(void)setNewRootViewController:(id)vc;
@end
