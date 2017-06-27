//
//  RNVMMVViewController.m
//  Gabbermap
//
//  Created by Alex Padalko on 4/5/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "RNVMMVViewController.h"
#import "RNVMMV.h"
@interface RNVMMVViewController ()

@end

@implementation RNVMMVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  if (self.rootComponentName) {


                  self.contentView =  [[RCTRootView alloc] initWithBridge:[[RNVMMV sharedInstance] bridge] moduleName:self.rootComponentName initialProperties:@{@"viewModelIdentifier":self.viewModel.identifier}];
        
        self.contentView.backgroundColor=[UIColor clearColor];
        [self.view addSubview:self.contentView];

  

 

  }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews{
  [super viewDidLayoutSubviews];
  [self.contentView setFrame:self.view.bounds];
}


-(void)rnvmmv_setup{
  __weak id selfWeak = self;
  [self.viewModel observe:@"switchPack" resultBlock:^(RNVMMVSwitchPack * x) {
    if (x) {
      NSLog(@"???");
      id vc =   [[RNRouter sharedInstance] getViewControllerForScene:[x scene]];
      [[selfWeak navigationController] pushViewController:vc animated:YES];
    }
  }];
}

-(void)dealloc{
  NSLog(@"vc dealloc: %@",self);
}
@end
