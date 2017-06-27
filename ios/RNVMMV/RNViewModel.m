//
//  RNViewModel.m
//  Gabbermap
//
//  Created by Alex Padalko on 3/16/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "RNViewModel.h"
#import "RNVMMV.h"
#import "RNViewModel_Private.h"
#import "RNVMMVCallBackManager.h"
typedef void (^ObserveBlock) (id x);

@interface RNViewModel (){
  dispatch_queue_t _workQueue;
}
@property (nonatomic,retain)NSMutableDictionary * observers;

@end
@implementation RNViewModel
-(instancetype)initWithIndentifier:(NSString *)identifier{
  if (self=[super init]) {
    _identifier = identifier;
    self.observers = [[NSMutableDictionary alloc] init];
    _workQueue = dispatch_queue_create("rn.rnvmmv.com", 0);
  }
  return self;
}
-(dispatch_queue_t)workQueue{
  return _workQueue;
}
-(void)observe:(NSString*)something resultBlock:(void(^)(id x))resultBlock{
    dispatch_async([self workQueue], ^{
  [self.observers setValue:[resultBlock copy] forKey:something];
      
    });
}
-(void)callFuncton:(NSString*)functionName params:(NSArray*)_params callBack:(void(^)(BOOL success,id data, NSError * error))callBack{
  
  
  
  NSArray * params = nil;
  

  if(_params){
    params = [NSArray arrayWithArray:_params];
  }else{
    params=@[];
  }

  NSMutableArray * args = [[NSMutableArray alloc] init];
  [args addObject:self.identifier];
  [args addObject:functionName];
  [args addObject:params];
  
  if (callBack) {
    [args addObject:[[RNVMMVCallBackManager sharedInstance] registerCallBack:callBack]];
  }
  
  [[[RNVMMV sharedInstance] bridge] enqueueJSCall:@"RNVMMVBlackBox"
                                           method:@"callFunctionForViewModel"
                                             args:args completion:nil];
  
}
-(void)callFuncton:(NSString*)functionName params:(NSArray*)params{
  [self callFuncton:functionName params:params callBack:nil];
}



-(void)didReciveValue:(id)_val forKey:(NSString *)key{
  
  dispatch_async([self workQueue], ^{
    
    
    ObserveBlock b = [self.observers valueForKey:key];
    if (b) {
      
      dispatch_async(dispatch_get_main_queue(), ^{
       b(_val);
      });
    }
    
  });
  
}
-(void)dealloc{
  NSLog(@"viewmodel dealloc: %@",self);
}

@end
