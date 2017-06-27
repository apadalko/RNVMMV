//
//  RNVMMVScene.m
//  Gabbermap
//
//  Created by Alex Padalko on 4/5/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "RNVMMVScene.h"


#import <React/RCTConvert.h>
@implementation RNVMMVScene
-(instancetype)initWithData:(NSDictionary *)data{
  return [self initWithRouteName:data[@"routeName"] viewModelIdentifier:data[@"viewModel"][@"indentifier"]  rootComponentName:data[@"rootComponentName"]];
  
}
-(instancetype)initWithRouteName:(NSString *)routeName viewModelIdentifier:(NSString *)viewModelIdentifier rootComponentName:(NSString *)rootComponentName{
  if (self=[super init]) {
    self.routeName=routeName;
    self.viewModelIdentifier=viewModelIdentifier;
    self.rootComponentName=([rootComponentName isEqual:[NSNull null]])?nil:rootComponentName;
  }
  return self;
}
@end
@implementation RCTConvert (RNVMMVScene)

+ (RNVMMVScene *)RNVMMVScene:(id)json
{
  return [[RNVMMVScene alloc] initWithData:json];
}

@end
