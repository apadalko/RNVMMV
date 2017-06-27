//
//  GMWelcomeViewController.m
//  Gabbermap
//
//  Created by Alex Padalko on 3/18/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "GMWelcomeViewController.h"
#import <React/RCTRootView.h>
#import "RNVMMV.h"
#import "GMWelcomeGrid.h"



@interface GMWelcomeViewController ()
@property (nonatomic,retain)GMWelcomeGrid * gridView;
@property (nonatomic,retain)UIImageView * backgroundView;
@property (nonatomic)BOOL firstGridAppear;



@end

@implementation GMWelcomeViewController



-(void)viewWillAppear:(BOOL)animated{
  [super viewWillAppear:animated];
  
}

-(void)viewDidAppear:(BOOL)animated{
  [super viewDidAppear:animated];
  
  if (!self.firstGridAppear){
    [self showGrid];
    self.firstGridAppear = YES;
  }
}

- (void)viewDidLoad {
  [super viewDidLoad];
//  [self.navigationController setNavigationBarHidden:YES];
  [self.view setBackgroundColor:[UIColor whiteColor]];
  
  self.backgroundView = [[UIImageView alloc] init];
  
  [self.backgroundView setImage:[UIImage imageNamed:@"mapScr"]];
  self.backgroundView.contentMode = UIViewContentModeScaleAspectFill;
  
 

  
  self.gridView = [[GMWelcomeGrid alloc] init];
  [self.view insertSubview:self.gridView atIndex:0];
    [self.view insertSubview:self.backgroundView atIndex:0];
  //    [self performSelector:@selector(showGrid) withObject:nil afterDelay:2];
  
  UIButton * b = [UIButton buttonWithType:UIButtonTypeCustom];
  [self.view addSubview:b];
  [b setFrame:CGRectMake(100, 100, 100, 100)];
  [b setBackgroundColor:[UIColor redColor]];
  [b addTarget:self action:@selector(onB) forControlEvents:UIControlEventTouchUpInside];
  
  
  [self.viewModel observe:@"loadSomeShitResponse" resultBlock:^(id x) {
    NSLog(@"loadSomeShitResponse");
    
    NSLog(@"%@",x);
    
  }];
  
  // Do any additional setup after loading the view.
}
-(void)onB{
  
  NSLog(@"CALLING");
    [self.viewModel callFuncton:@"loadSomeShit" params:@[@"1",@"333"] callBack:^(BOOL success, id data, NSError *error) {
      
      NSLog(@"???");
    }];
//  [self.viewModel callFuncton:@"goToSignIn" params:@[@"1",@"333"]];
}
-(void)restart{
  
  [self.gridView clean];
  
  [self showGrid];
  
}


#pragma mark -
-(void)showGrid{
  [self.gridView appear:^{
    
    
    
    
    
    
  }];
}


#pragma mark control




-(void)viewDidLayoutSubviews{
  [super viewDidLayoutSubviews];
  [self.backgroundView setFrame:self.view.bounds];
  [self.gridView setFrame:self.view.bounds];
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

