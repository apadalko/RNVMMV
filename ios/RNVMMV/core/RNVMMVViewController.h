//
//  RNVMMVViewController.h
//  Gabbermap
//
//  Created by Alex Padalko on 4/5/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNViewModel.h"
#import "RNRouter.h"
#import "RNVMMVSwitchPack.h"
#import <React/RCTRootView.h>
@interface RNVMMVViewController : UIViewController
@property (nonatomic,retain)NSString * identifier;
@property (nonatomic,retain)RNViewModel * viewModel;
@property (nonatomic,retain)NSString * rootComponentName;
@property (nonatomic,retain)RCTRootView * contentView;
-(void)rnvmmv_setup;
@end
