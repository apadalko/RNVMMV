//
//  GMSignInViewController.m
//  Gabbermap
//
//  Created by Alex Padalko on 3/19/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "GMSignInViewController.h"
#import <React/RCTRootView.h>
#import "RNVMMV.h"

@interface GMSignInViewController ()

@end

@implementation GMSignInViewController
//-(void)loadView{
//
//
//  if (self.rootComponentName) {
//    [self setView:[[RCTRootView alloc] initWithBridge:[[RNVMMV sharedInstance] bridge] moduleName:self.rootComponentName initialProperties:nil]];
//  }else{
//    [super loadView];
//  }
//}
- (void)viewDidLoad {
    [super viewDidLoad];
  
  [self.view setBackgroundColor:[UIColor greenColor]];

  
}
-(void)viewDidDisappear:(BOOL)animated{
  [super viewDidDisappear:animated];
  NSLog(@"NC:%@",self.navigationController);
  NSLog(@"Retain count is %ld", CFGetRetainCount((__bridge CFTypeRef)self));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
  NSLog(@"GMSignInViewController DEALLCO");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
