//
//  RNVMMVScene.h
//  Gabbermap
//
//  Created by Alex Padalko on 4/5/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RNVMMVScene : NSObject
-(instancetype)initWithData:(NSDictionary*)data;

-(instancetype)initWithRouteName:(NSString*)routeName viewModelIdentifier:(NSString*)viewModelIdentifier rootComponentName:(NSString*)rootComponentName;
@property (nonatomic,retain)NSString * viewModelIdentifier;
@property (nonatomic,retain)NSString * rootComponentName;
@property (nonatomic,retain)NSString * routeName;
@end
