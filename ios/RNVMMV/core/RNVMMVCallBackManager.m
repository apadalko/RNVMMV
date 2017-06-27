//
//  RNVMMVCallBackManager.m
//  Gabbermap
//
//  Created by Alex Padalko on 4/19/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "RNVMMVCallBackManager.h"

@implementation RNVMMVCallBackManager
static RNVMMVCallBackManager * inst;
+(instancetype)sharedInstance{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    inst = [[self alloc] init];
  });
  
  return inst;
}

-(NSString *)registerCallBack:(RNVMMVFunctionCallback)callback{
  return @"test";
}
@end
