//
//  RNBlackBox.m
//  Gabbermap
//
//  Created by Alex Padalko on 3/19/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "RNBlackBox.h"
#import <React/RCTBridgeModule.h>
#import "RNViewModel.h"
#import "RNViewModel_Private.h"
#import <React/RCTConvert.h>
#import <objc/runtime.h>
#import <React/RCTBridge+Private.h>
@interface RNBlackBox () <RCTBridgeModule>
@property (nonatomic,retain)NSMapTable * viewModels;
@end
@implementation RNBlackBox
static RNBlackBox * inst;
+(instancetype)sharedInstance{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    inst = [[RNBlackBox alloc] init];
  });
  return inst;
}

-(void)addViewModel:(RNViewModel*)viewModel{

  [self.viewModels setObject:viewModel forKey:[viewModel identifier]];

}

-(id)_processValue:(id)value{
  if ([value isKindOfClass:[NSDictionary class]]) {
    if ([value valueForKey:@"~className"]) {
       Class cl = NSClassFromString([value valueForKey:@"~className"]);
    }
  }else if ([value isKindOfClass:[NSArray class]]){
    
  }else{
    return  value;
  }
  
  return nil;
}

RCT_EXPORT_METHOD(send:(NSString*)viewModelIndif
                  key:(NSString*)key
                  value:(id)value){

  
  RNViewModel * vm = [self.viewModels objectForKey:viewModelIndif];
     id val = value;
  if (vm) {
     if ([val isKindOfClass:[NSDictionary class]]&&[val valueForKey:@"~className"]) {
      NSString * className = [val valueForKey:@"~className"];
      SEL selector = NSSelectorFromString([NSString stringWithFormat:@"%@:",className]);
      if ([RCTConvert respondsToSelector:selector]) {
        
        
        
        NSDictionary * d = [val valueForKey:@"properties"];
        if (!d) {
          d = @{};
        }
        NSMethodSignature *typeSignature = [RCTConvert methodSignatureForSelector:selector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:typeSignature];
        
        [ invocation setArgument: &d atIndex: 2 ];
        invocation.selector = selector;
        
        invocation.target = [RCTConvert class];
        
        [invocation invoke];
        
        [ invocation getReturnValue: &val ];
        CFBridgingRetain(val);
        
      }
    }
    [vm didReciveValue:val forKey:key];
  }
  


  
  
}

-(NSMapTable *)viewModels{
  if (!_viewModels) {
    _viewModels = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsWeakMemory];
  }
  return _viewModels;
}


//RCT_EXPORT_MODULE();
RCT_EXTERN void RCTRegisterModule(Class);
+ (NSString *)moduleName { return @"RNBlackBox"; }
+ (void)load { RCTRegisterModule(self); }
@end
