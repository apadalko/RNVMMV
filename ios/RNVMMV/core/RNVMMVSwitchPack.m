//
//  RNSwitchPack.m
//  Gabbermap
//
//  Created by Alex Padalko on 4/5/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "RNVMMVSwitchPack.h"
#import <React/RCTConvert.h>

@implementation RNVMMVSwitchPack

-(instancetype)initWithData:(NSDictionary*)data{
  if (self=[super init]) {
    self.scene = [[ RNVMMVScene alloc] initWithData:data[@"scene"]];
  }
  return self;
}
@end
@implementation RCTConvert (RNVMMVSwitchPack)

+ (RNVMMVSwitchPack *)RNVMMVSwitchPack:(id)json
{
  return [[RNVMMVSwitchPack alloc] initWithData:json];
}

@end
