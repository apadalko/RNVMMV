//
//  RNRouter.m
//  Gabbermap
//
//  Created by Alex Padalko on 3/18/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "RNRouter.h"
#import "RNRouter_Private.h"
#import <React/RCTBridge.h>
#import "RNBlackBox.h"

#import "RNVMMVViewController.h"
#import "RNVMMVScene.h"
@interface RNRouter ()
@property (nonatomic,retain)NSMutableDictionary * registredRoutes;
@property (nonatomic,retain)UIWindow* window;

//
@property (nonatomic,retain)NSMutableDictionary * prepearedViewControllers;

//self.prepearedViewControllers = [[NSMutableDictionary alloc] init];


@end



@implementation RNRouter
@synthesize bridge=_bridge;
static RNRouter * inst;

+(instancetype)createWithWindow:(UIWindow*)window{
  inst = [[RNRouter alloc] initWithWindow:window];
  return inst;
}
+(instancetype)sharedInstance{

  
  return inst;
}


-(instancetype)initWithWindow:(UIWindow*)window{
  if (self=[super init]) {
    self.window = window;
    self.prepearedViewControllers = [[NSMutableDictionary alloc] init];
  }
  return self;
}







-(void)registerViewControllerClass:(Class)vcClass forRoute:(NSString *)routeName{
  NSMutableDictionary * data = [[NSMutableDictionary alloc] init];
//  if (vmClassName) {
//    [data setValue:vmClassName forKey:@"vm"];
//  }
  [data setValue:vcClass forKey:@"vc"];

  
  self.registredRoutes[routeName]=data;
}

-(NSMutableDictionary *)registredRoutes{
  if (!_registredRoutes) {
    _registredRoutes=[[NSMutableDictionary alloc] init];
  }
  return _registredRoutes;
}
@end


@implementation RNRouter(Private)

-(void)setNewRootViewController:(id)vc{
  dispatch_async(dispatch_get_main_queue(), ^{
    id realVC = vc;
    if (![vc isKindOfClass:[UINavigationController class]]) {
      realVC  =[[UINavigationController alloc] initWithRootViewController:vc];
    }
    self.window.rootViewController = realVC;
    
  });
}

-(UIViewController *)getPrepearedViewControllerForRoute:(NSString *)route{
  __block UIViewController * result = nil;
  dispatch_sync([self methodQueue], ^{
    
    result = [self prepearedViewControllers][route];
    
    
  });
  
  return result;
}

-(UIViewController *)getViewControllerForScene:(RNVMMVScene*)scene{
  
  Class vcClass;
  NSDictionary * data = self.registredRoutes[scene.routeName];
  if (data) {
    vcClass=data[@"vc"];
  }
  if (!vcClass) {
    vcClass =[UIViewController class];
  }
  
  RNVMMVViewController * vc =  [[vcClass alloc] init];
  NSString * indif = [NSString stringWithFormat:@"%@_%@",scene.routeName,NSStringFromClass(vcClass)];
  [vc setIdentifier:indif];
  RNViewModel * viewModel = [[RNViewModel alloc] initWithIndentifier:scene.viewModelIdentifier];
  [[RNBlackBox sharedInstance] addViewModel:viewModel];
  [vc setViewModel:viewModel];
  [vc setRootComponentName:scene.rootComponentName];
  [vc rnvmmv_setup];
  return  vc;
}


//RCT_EXPORT_MODULE();
RCT_EXTERN void RCTRegisterModule(Class);
+ (NSString *)moduleName { return @"RNRouter"; }
+ (void)load { RCTRegisterModule(self); }

RCT_EXPORT_METHOD(didReciveRootScene:(RNVMMVScene*)scene){
  
  NSLog(@"%@",scene);
  
  id vc = [self getViewControllerForScene:scene];
//  id vc = [[RNVariblesStorage sharedInstance] get:pack];
  [[RNRouter sharedInstance] setNewRootViewController:vc];
//    NSLog(@"TEST2");
}

//RCT_REMAP_METHOD(resolve:(NSString*)routeName
//                 viewModelIndentifier:(NSString*)viewModelIndentifier
//                 rootComponentName:(NSString*)rootComponentName,resolver:(RCTPromiseResolveBlock)resolve){
//
//
//  NSLog(@"??");
//
//}

RCT_EXPORT_METHOD(resolve:(NSString*)routeName
                  viewModelIndentifier:(NSString*)viewModelIndentifier
                  rootComponentName:(NSString*)rootComponentName){
  
  /// call native public router for view controller
  //if null generate basic viewcontroller
  
//
//  RNViewModel * viewModel = [[RNViewModel alloc] initWithIndentifier:viewModelIndentifier];
//  
//  UIViewController * vc = [[RNRouter sharedInstance] getViewControllerForRoute:routeName withViewModel:viewModel];
//  if (rootComponentName) {
//    [vc setRootComponentName:rootComponentName];
//  }
//  
//  [[RNBlackBox sharedInstance] addViewModel:viewModel];
//  
//  [[self bridge] enqueueJSCall:@"RNVMMVRouter" method:@"didResoleNativeRoute" args:@[routeName,[[[RNVariblesStorage sharedInstance] put:vc forKey:vc.identifier] toDictionary]] completion:^{
//    NSLog(@"TEST1");
//  }];

  
  //some root component setup
  
  
}


@end
